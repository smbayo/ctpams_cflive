/* 
 * Replace these URL's according to production environment.
 * 
 * URL_FRAMEWORK: Where to load All Results JSON data from
 * URL_{ACTIVITY, INDICATOR, RESULT}: Base URL to load Activity, Indicator and
 * Result; append respective IDs.
 * 
 * */
var URL_ACTIVITY_JSON = "index.cfm/framework/getJsonactivity/activityID/";
var URL_INDICATOR_JSON = "index.cfm/framework/getJsonindicator/indicatorID/";
var URL_FRAMEWORK = "index.cfm/framework/getJsonAllREsults/";
var URL_ACTIVITY = "index.cfm/proposal/review/activityID/";
var URL_INDICATOR = "index.cfm/indicator/viewIndicator/indicatorID/";
var URL_RESULT = "index.cfm/framework/viewResult/resultsFrameworkElementID/";


var RF_CLUSTER = function () {
    /* 
     * width and height: should be set to fit the SVG into a container.  They
     * control the size of the SVG element.
     * 
     * treeWidth and treeHeight: set dynamically for tree layout.
     * Normally, do not set these manually.
     *
     * shiftX and shiftY: set dynamically according to click event source.
     * These control the `vis` svg:g group translation to shift event source
     * element back to center.
     *
     * boxWidth and boxHeight: These control the size of Result Element
     * rectangles. Changing them will have have side-effect of text flow in
     * the boxes and the overall layout of the framework.
     *
     * duration: how long the transition animation lasts in milliseconds.
     *
     * i: keeping track of generated node.id
     *
     * root: reference to the treeObject returned from frameworkTree.
     *
     * */
    var width = 1370,
        height = 800,
        treeWidth = 1370,
        treeHeight = 800,
        shiftX = 20,
        shiftY = 20,
        boxWidth = 155,
        boxHeight = 100,
        duration = 500,
        i = 0,
        root;

    var cluster = d3.layout.cluster()
        .size([treeWidth, treeHeight]);

    // Override default tree node separation
    cluster.separation(function (a, b) {
        return 1;
    });
    var separation = cluster.separation();

    var diagonal = d3.svg.diagonal()
        .projection(function(d) { return [d.x, d.y]; });

    /*
     * The SVG element
     *
     * The element will scale to fit the "viewBox" to fit into the width and
     * height of the SVG. 
     *
     * For details of how the viewBox and scaling works, see
     * http://www.w3.org/TR/SVG/coords.html#ViewBoxAttribute
     */
    var svg = d3.select("#chart").append("svg:svg")
        .attr("width", width)
        .attr("height", height)
        .attr("viewBox", "0 0 1370 800")
        .attr("preserveAspectRatio", "xMidYMid meet");

    // Define triangle marker pointing left.
    var defs = svg.append("svg:defs");
    defs.append("svg:marker")
        .attr("id", "Triangle")
        .attr("viewBox", "0 0 10 10")
        .attr("refX", 11)
        .attr("refY", 5)
        .attr("markerUnits", "strokeWidth")
        .attr("markerWidth", 6)
        .attr("markerHeight", 6)
        .attr("orient", "auto")
      .append("svg:path")
        .attr("d", "M 0 5 L 10 0 L 10 10 z");

    // The svg:g group that contains the whole visualization.
    var vis = svg.append("g");

    // The "drag" behavior is bind to the SVG element.
    var drag = d3.behavior.drag()
        .on("drag", function(d, i) {
            shiftX += d3.event.dx;
            shiftY += d3.event.dy;
            vis.attr("transform", "translate(" + shiftX + "," + shiftY + ")");
        });
    svg.call(drag);

    // Recursively collapse all descendants of d
    function collapse(d) {
        if (d.children) {
            d._children = d.children;
            d.children.forEach(collapse);
            d.children = null;
        } else if (d._children) {
            d._children.forEach(collapse);
        }
    }

    // Recursively expand all descendants of d
    function expand(d) {
        if (d._children) {
            d.children = d._children;
            d._children.forEach(expand);
            d._children = null;
        } else if (d.children) {
            d.children.forEach(expand);
        }
    }
    
    // Collapse the whole tree, but maintain 1st level expanded.
    function collapseAll() {
        if (!root.children) expand(root); 
        if (root.children) root.children.forEach(collapse);
        update(root);
    }

    // Expand the whole tree.
    function expandAll() {
        expand(root);
        //root.children.forEach(expand);
        update(root);
    }

    function visualizeTree (rootObj) {
        root = rootObj;
        root.x0 = width/2;
        root.y0 = 0;
        collapseAll();
    }

    /* Helper functions from d3.js to find out tree extent */
    function d3_layout_treeVisitAfter(node, callback) {
      function visit(node, previousSibling) {
        var children = node.children;
        if (children && (n = children.length)) {
          var child,
              previousChild = null,
              i = -1,
              n;
          while (++i < n) {
            child = children[i];
            visit(child, previousChild);
            previousChild = child;
          }
        }
        callback(node, previousSibling);
      }
      visit(node, null);
    }

    function d3_layout_clusterY(children) {
      return 1 + d3.max(children, function(child) {
        return child.y;
      });
    }

    function d3_layout_clusterX(children) {
      return children.reduce(function(x, child) {
        return x + child.x;
      }, 0) / children.length;
    }

    function d3_layout_clusterLeft(node) {
        var children = node.children;
        return children && children.length ? d3_layout_clusterLeft(children[0]) : node;
    }

    function d3_layout_clusterRight(node) {
        var children = node.children, n;
        return children && (n = children.length) ? d3_layout_clusterRight(children[n - 1]) : node;
    }

    function d3_layout_treeDeepest(a, b) {
      return a.depth - b.depth;
    }

    function d3_layout_treeSearch(node, compare) {
      var children = node.children;
      if (children && (n = children.length)) {
        var child,
            n,
            i = -1;
        while (++i < n) {
          if (compare(child = d3_layout_treeSearch(children[i], compare), node) > 0) {
            node = child;
          }
        }
      }
      return node;
    }
    /***** End of d3.js helper functions for tree extent *****/
    
    // Refresh the layout 
    function update(source) {

        function extent(root) {

            var previousNode,
                x = 0;

            // First walk, computing the initial x & y values.
            d3_layout_treeVisitAfter(root, function(node) {
              var children = node.children;
              if (children && children.length) {
                node.x = d3_layout_clusterX(children);
                node.y = d3_layout_clusterY(children);
              } else {
                node.x = previousNode ? x += separation(node, previousNode) : 0;
                node.y = 0;
                previousNode = node;
              }
            });

            // Compute the left-most, right-most, and depth-most nodes for extents.
            var left = d3_layout_clusterLeft(root),
                right = d3_layout_clusterRight(root),
                x0 = left.x - separation(left, right) / 2,
                x1 = right.x + separation(right, left) / 2,
                extent = x1 - x0;
            return extent;
        }
        
        // Do this BEFORE actual layout
        // Set width according to layout extent, 
        treeWidth = extent(root) * boxWidth * 1.3;
        cluster.size([treeWidth, undefined]);

        // Compute the new tree layout.
        var nodes = cluster.nodes(root).reverse();

        // Do this AFTER layout
        // Adjust height to the deepest level.
        var deep = d3_layout_treeSearch(root, d3_layout_treeDeepest),
            y1 = deep.depth || 1;
        treeHeight = (y1+1) * boxHeight * 2;
        cluster.size([undefined, treeHeight]);

        //console.log("treeSize", treeWidth, treeHeight);

        vis.transition()
            .duration(duration)
            .attr("transform", "translate(" + shiftX + "," + shiftY + ")");

        // Normalize for fixed-depth.
        nodes.forEach(function(d) { d.y = d.depth * boxHeight * 1.8; });

        // Update the nodes…
        var node = vis.selectAll("g.node")
            .data(nodes, function(d) { return d.id || (d.id = ++i); });

        // Enter any new nodes at the parent's previous position.
        var nodeEnter = node.enter().append("g")
            .attr("class", "node")
            .attr("transform", function(d) { 
                return "translate(" + source.x0 + "," + source.y0 + ")"; 
            })
            .on("click", click);

        // One rect for each element, rounded corners with children
        nodeEnter.append("svg:rect")
            .attr("x", -boxWidth/2)
            .attr("rx", function (d) {
                return d._children ? 5 : d.children ? 5: 0;
            })
            .attr("height", boxHeight)
            .attr("width", boxWidth);
            //.style("fill", RF.color);

        // Add and arrow, only show when there's children
        nodeEnter.append("svg:polygon")
            .attr("fill-opacity", function (d) { return d._children? 0.5 : d.children ? 0.5 : 0; })
            .attr("stroke-width", 3)
            .attr("transform", "translate(" + (-boxWidth/2+5) +", "+ (boxHeight-13)+")")
            .attr("points", "3,0 7,0  7,5 10,5 5,10 0,5 3,5");
            
        // Text Wrapping: create <tspan> in <text> with textFlow.js
        var textNodes = nodeEnter.append("text")
            .attr("y", "18")
            .attr("text-anchor", "middle")
            .attr("pointer-events", "none")
            .style("fill-opacity", 1e-6);
        textNodes.each(function (d, i) {
            var x = 0;
            var ddy = 12;
            var dy = textFlow(d.NAME, this, boxWidth*0.95, x, ddy);
        });

        var withActivity = nodeEnter.filter(function (d, i) {
            return d.Activities && d.Activities.length ? this : null 
        });
        var withIndicator = nodeEnter.filter(function (d, i) { 
            return d.Indicators && d.Indicators.length ? this : null 
        });

        // Result icons.
        node.append("svg:circle")
            .attr("class", "result")
            .attr("cx", boxWidth/2-11)
            .attr("cy", boxHeight-11)
            .attr("r", 8)
            .on("click", function (d, i) {
                var rfID = d.RESULTSFRAMEWORKELEMENTID;
                window.open(URL_RESULT+rfID, 'RFResult');
                d3.event.stopPropagation();
            });
        node.append("svg:text")
            .attr("dx", boxWidth/2-14)
            .attr("dy", boxHeight-7)
            .attr("pointer-events", "none")
            .text("R");

        function modalOptions(evt) {
            return { 
                position: [evt.y-boxHeight,evt.x],
                opacity: 10,
                close:true,
                overlayClose:false,
                minHeight: boxHeight,
                minWidth: boxWidth,
                maxHeight: boxHeight*3,
                maxWidth: boxWidth*3,
                overlayClose:true
            }
        }
        
        // Indicator icons.
        withIndicator.append("svg:circle")
            .attr("class", "indicator")
            .attr("cx", boxWidth/2-30)
            .attr("cy", boxHeight-11)
            .attr("r", 8)
            .on("click", function dspIndicators(d, i) {
                var lis = d.Indicators.map(function (a) {
                    if (typeof a === "number") {
                        return "<li>Indicator &lt;" + a + "&gt; loading ...</li>";
                    } else {
                        var id = a.INDICATORID,
                            name = a.NAME;
                        return "<li><a href='" + URL_INDICATOR + id + 
                            "' target='RFInd'>" + name + "</a></li>";
                    }
                });
                /*
                 * Result Indicator modal popup
                 */
                $.modal(
                    "<h4 class='rstpop'>Result Indicators</h4> <ul>"+lis.join("\n")+"</ur>", 
                    modalOptions(d3.event)
                );
                d3.event.stopPropagation();
            });
        withIndicator.append("svg:text")
            .attr("dx", boxWidth/2-32)
            .attr("dy", boxHeight-7)
            .attr("pointer-events", "none")
            .text("I");

        // Activity icons.
        withActivity.append("svg:circle")
            .attr("class", "activity")
            .attr("cx", boxWidth/2-49)
            .attr("cy", boxHeight-11)
            .attr("r", 8)
            .on("click", function dspActivities(d, i) {
                var lis = d.Activities.map(function (a) {
                    if (typeof a === "number") {
                        return "<li>Activity &lt;" + a + "&gt; loading ...</li>";
                    } else {
                        var id = a.ACTIVITYID,
                            name = a.NAME;
                        return "<li><a href='" + URL_ACTIVITY + id + 
                            "' target='RFInd'>" + name + "</a></li>";
                    }
                });
                /*
                 * Activities modal popup
                 */
                $.modal(
                    "<h4 class='actpop'>Activities</h4> <ul>"+lis.join("\n")+"</ur>", 
                    modalOptions(d3.event)
                );
                d3.event.stopPropagation();
            }); 
        withActivity.append("svg:text")
            .attr("dx", boxWidth/2-52)
            .attr("dy", boxHeight-7)
            .attr("pointer-events", "none")
            .text("A");
        
        // Transition nodes to their new position.
        var nodeUpdate = node.transition()
            .duration(duration)
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

        nodeUpdate.select("text")
            .style("fill-opacity", 1);

        // Transition exiting nodes to the parent's new position.
        var nodeExit = node.exit().transition()
            .duration(duration)
            .attr("transform", function(d) { return "translate(" + source.x + "," + source.y + ")"; })
            .remove();

        nodeExit.select("text")
            .style("fill-opacity", 1e-6);

        // Update the links…
        var link = vis.selectAll("path.link")
            .data(cluster.links(nodes), function(d) { return d.target.id; });

        // Enter any new links at the parent's previous position.
        link.enter().insert("path", "g")
            .attr("class", "link")
            .attr("d", function(d) {
                var o = {x: source.x0, y: source.y0};
                return diagonal({source: o, target: o});
            })
            .attr("marker-end", "url(#Triangle)");

        // Transition links to their new position.
        link.transition()
            .duration(duration)
            .attr("d", diagonal);

        // Transition exiting nodes to the parent's new position.
        link.exit().transition()
            .duration(duration)
            .attr("d", function(d) {
                var o = {x: source.x, y: source.y};
                return diagonal({source: o, target: o});
            })
            .remove();

        /*
         * Shift event source element back to center.
         *
         * "center" is defined by the size (width, height) of the SVG element.
         * One exception is the root element, which is set to one fifth of the
         * height from the top.
         */
        shiftX = width/2 - source.x;
        shiftY = height/2 - source.y;
        if (source === root) shiftY = height/5 - source.y;
        vis.transition()
            .duration(duration)
            .attr("transform", "translate(" + shiftX + "," + shiftY + ")");
             
        // Stash the old positions for transition.
        nodes.forEach(function(d) {
            d.x0 = d.x;
            d.y0 = d.y;
        });
    }

    // Toggle children on click.
    function click(d, i) {
        if (d.children) {
            d._children = d.children;
            d.children = null;
        } else {
            d.children = d._children;
            d._children = null;
        }
        update(d);
    }

    // Make AJAX call to url, caller need to supply success callback in chain.
    function loadJSON(url) {
        return $.ajax(url).fail(function (jqXHR, textStatus, errorThrown) {
            message = "Failed to load: '" + url + "'";
            console.log(message);
            /*window.alert("Login first, then reload this page.");*/
        });
    }

    /*
     * Construct a tree object for visualization.
     *
     * `json`: JSON object that contains a "FullFramework" attribute that has
     * an array of Result Framework Element objects, as defined by the
     * ResultsFramework JSON API. Also, it assumes that the element with lowest
     * id is the "root" element of the framework tree.
     *
     * For development purposes, if `isLocal` is set, remote loading of
     * Activity and Indicator JSON objects is disabled.
     *
     */
    function frameworkTree(json, isLocal) {
        var allElements = json['FullFramework'];
        var allElementsMap = {}; // {RESULTSFRAMEWORKELEMENTID -> element}

        if (allElements && allElements.length) {

            // Populate allElementsMap
            allElements.forEach(function(element) {
                var eid = element.RESULTSFRAMEWORKELEMENTID;
                allElementsMap[eid] = element;
            });

            // Create the tree object recursively
            function treeNode(i) {

                // Make of copy of the element
                var node = {};
                jQuery.extend(node, allElementsMap[i]);

                // Map array from IDs to JSON objects
                function loadObjects(baseURL, idxArray) {
                    var objArray;
                    if (idxArray && idxArray.length) {
                        objArray = idxArray.map(function (id) {
                            var a = {};
                            if ((typeof id) === 'number') {
                                loadJSON(baseURL + id).done(function (data) {
                                    jQuery.extend(a, data);
                                });
                            }
                            return a;
                        });
                    }
                    return objArray;
                }
                if (!isLocal) {
                    node.Activities = loadObjects(URL_ACTIVITY_JSON, node.Activities);
                    node.Indicators = loadObjects(URL_INDICATOR_JSON, node.Indicators);
                }

                // Create children recursively
                if (node.Children && node.Children.length) {
                    // d3.js relies on lowercase 'children'
                    node.children = node.Children.map(treeNode);
                }
                delete node.Children;
                return node;
            }

            var keys = Object.keys(allElementsMap);
            keys = keys.sort(function(a, b) {return a-b;});
            return treeNode(keys[0]); // Assume root has the smallest ID

        } else {
            throw new Error("Unable to parse json:", json);
        }
    }

    // Public attributes of this module
    return {
        collapseAll: collapseAll,
        expandAll: expandAll,
        visualizeTree: visualizeTree,
        frameworkTree: frameworkTree,
        loadJSON: loadJSON
    }

}();

// To test without loading remote data, set LOCAL to true.
var LOCAL = false;
if (LOCAL) {
    URL_FRAMEWORK = "rfelements_all.json";
}
RF_CLUSTER.loadJSON(URL_FRAMEWORK).done(function (data) {
    var rootObj = RF_CLUSTER.frameworkTree(data, LOCAL);
    RF_CLUSTER.visualizeTree(rootObj);
});

