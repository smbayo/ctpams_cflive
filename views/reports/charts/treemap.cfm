<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>CT Programs Treemap</title>
    <script type="text/javascript" src="../../includes/javascript/d3/d3.v2.js"></script>
    <style type="text/css">
        body {
            background: url(./images/texture-noise.png);
            overflow: hidden;
            margin: 0;
            font-size: 12px;
            font-family: "Helvetica Neue", Helvetica;
        }

        #chart, #header, #footer {
            position: absolute;
            top: 0;
        }

        #header, #footer {
            z-index: 1;
            display: block;
            font-size: 36px;
            font-weight: 300;
            text-shadow: 0 1px 0 #fff;
        }

        #header.inverted, #footer.inverted {
            color: #fff;
            text-shadow: 0 1px 4px #000;
        }

        #header {
            top: 80px;
            left: 140px;
            width: 1200px;
        }

        #footer {
            top: 680px;
            right: 140px;
            text-align: right;
        }

        rect {
            pointer-events: all;
            cursor: pointer;
        }

        .chart {
            display: block;
            margin: auto;
            margin-top: 40px;
        }

        .parent .label {
            color: #FFFFFF;
            padding-left: 2px;
            padding-top: 2px;
            text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
            -webkit-text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
            -moz-text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
        }

        .labelbody {
            background: transparent;
        }

        .label {
            padding: 2px;
            white-space: pre;
            overflow: hidden;
            text-overflow: ellipsis;
            text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
            -webkit-text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
            -moz-text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
        }

        .child .label {
            white-space: pre-wrap;
            text-align: center;
            text-overflow: ellipsis;
        }

        .cell {
            font-size: 11px;
            cursor: pointer
        }
    </style>
</head>
<body>
<div id="body"></div>
<div id="footer">
    CT Programs Treemap - Program/Region/Country
    <div class="hint">click to descend or ascend</div>
    <div>
        <select>
            <option value="size">Size</option>
            <option value="count">Count</option>
        </select>
    </div>
    <div class="chart" style="width: 1200px; height: 620px;">
    </div>
</div>
</body>

<script type="text/javascript">
    var chartWidth = 780 - 80;
    var chartHeight = 800 - 180;
    var xscale = d3.scale.linear().range([0, chartWidth]);
    var yscale = d3.scale.linear().range([0, chartHeight]);
    var color = d3.scale.category10();
    var headerHeight = 20;
    var headerColor = "#555555";
    var transitionDuration = 500;
    var root;
    var node;

    var jsonData =  <cfoutput>#rc.treedata#</cfoutput>;

    var treemap = d3.layout.treemap()
            .round(false)
            .size([chartWidth, chartHeight])
            .sticky(true)
            .padding([headerHeight + 1, 1, 1, 1])
            .value(function(d) {
                return d.size;
            });

    var chart = d3.select("#body").append("div")
            .append("svg:svg")
            .attr("width", chartWidth)
            .attr("height", chartHeight)
            .append("svg:g");

        node = root = jsonData;
        var nodes = treemap.nodes(jsonData);

        var children = nodes.filter(function(d) {
            return !d.children;
        });
        var parents = nodes.filter(function(d) {
            return d.children;
        });

        // create parent cells
        var parentCells = chart.selectAll("g.cell.parent")
                .data(parents, function(d) {
                    return "p-" + d.name;
                });
        var parentEnterTransition = parentCells.enter()
                .append("g")
                .attr("class", "cell parent")
                .on("click", function(d) {
                    zoom(d);
                });
        parentEnterTransition.append("rect")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", headerHeight)
                .style("fill", headerColor);
        parentEnterTransition.append('foreignObject')
                .attr("class", "foreignObject")
                .append("xhtml:body")
                .attr("class", "labelbody")
                .append("div")
                .attr("class", "label");
        // update transition
        var parentUpdateTransition = parentCells.transition().duration(transitionDuration);
        parentUpdateTransition.select(".cell")
                .attr("transform", function(d) {
                    return "translate(" + d.dx + "," + d.y + ")";
                });
        parentUpdateTransition.select("rect")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", headerHeight)
                .style("fill", headerColor);
        parentUpdateTransition.select(".foreignObject")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", headerHeight)
                .select(".labelbody .label")
                .attr("style", function(d) {
                    return "width:" + Math.max(0.01, (d.dx - 1)) + "px;" +
                           "height:" + headerHeight + "px;";
                })
                .text(function(d) {
                    return d.name;
                });
        // remove transition
        parentCells.exit()
                .remove();

        // create children cells
        var childrenCells = chart.selectAll("g.cell.child")
                .data(children, function(d) {
                    return "c-" + d.name;
                });
        // enter transition
        var childEnterTransition = childrenCells.enter()
                .append("g")
                .attr("class", "cell child")
                .on("click", function(d) {
                    zoom(node === d.parent ? root : d.parent);
                });
        childEnterTransition.append("rect")
                .classed("background", true)
                .style("fill", function(d) {
                    return color(d.parent.name);
                });
        childEnterTransition.append('foreignObject')
                .attr("class", "foreignObject")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", function(d) {
                    return Math.max(0.01, d.dy - 1);
                })
                .style("display", "none")
                .append("xhtml:body")
                .attr("class", "labelbody")
                .append("div")
                .attr("class", "label")
                .text(function(d) {
                    return d.name;
                });
                
        // update transition
        var childUpdateTransition = childrenCells.transition().duration(transitionDuration);
        childUpdateTransition.select(".cell")
                .attr("transform", function(d) {
                    return "translate(" + d.x  + "," + d.y + ")";
                });
        childUpdateTransition.select("rect")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", function(d) {
                    return (d.dy - 1);
                })
                .style("fill", function(d) {
                    return color(d.parent.name);
                });
        childUpdateTransition.select(".foreignObject")
                .attr("width", function(d) {
                    return Math.max(0.01, d.dx - 1);
                })
                .attr("height", function(d) {
                    return Math.max(0.01, d.dy - 1);
                })
                .select(".labelbody .label")
                .attr("style", function(d) {
                    return "width:"  + Math.max(0.01, (d.dx - 1)) + "px;" +
                           "height:" + (d.dy - 1) + "px;";
                })
                .text(function(d) {
                    return d.name;
                });
        // exit transition
        childrenCells.exit()
                .remove();

        d3.select("select").on("change", function() {
            console.log("select zoom(node)");
            treemap.value(this.value == "size" ? size : count)
                    .nodes(root);
            zoom(node);
        });

        zoom(node);




    function size(d) {
        return d.size;
    }


    function count(d) {
        return 1;
    }


    //and another one
    function textHeight(d) {
        var ky = chartHeight / d.dy;
        yscale.domain([d.y, d.y + d.dy]);
        return (ky * d.dy) / headerHeight;
    }

    function getRGBComponents (color) {
        var r = color.substring(1, 3);
        var g = color.substring(3, 5);
        var b = color.substring(5, 7);
        return {
            R: parseInt(r, 16),
            G: parseInt(g, 16),
            B: parseInt(b, 16)
        };
    }


    function idealTextColor (bgColor) {
        var nThreshold = 105;
        var components = getRGBComponents(bgColor);
        var bgDelta = (components.R * 0.299) + (components.G * 0.587) + (components.B * 0.114);
        return ((255 - bgDelta) < nThreshold) ? "#000000" : "#ffffff";
    }


    function zoom(d) {
        this.treemap
                .padding([headerHeight/(chartHeight/d.dy), 0, 0, 0])
                .nodes(d);

        // moving the next two lines above treemap layout messes up padding of zoom result
        var kx = chartWidth  / d.dx;
        var ky = chartHeight / d.dy;
        var level = d;

        xscale.domain([d.x, d.x + d.dx]);
        yscale.domain([d.y, d.y + d.dy]);

        if (node != level) {
            chart.selectAll(".cell.child .foreignObject").style("display", "none");

        }

        var zoomTransition = chart.selectAll("g.cell").transition().duration(transitionDuration)
                .attr("transform", function(d) {
                    return "translate(" + xscale(d.x) + "," + yscale(d.y) + ")";
                })
                .each("start", function() {
                    d3.select(this).select("label")
                            .style("display", "none");
                })
                .each("end", function(d, i) {
                    if (!i && (level !== self.root)) {
                        chart.selectAll(".cell.child")
                            .filter(function(d) {
                                return d.parent === self.node; // only get the children for selected group
                            })
                            .select(".foreignObject")
                            .style("display", "")
                            .style("color", function(d) {
                                return idealTextColor(color(d.parent.name));
                            });
                    }
                });

        zoomTransition.select(".foreignObject")
                .attr("width", function(d) {
                    return Math.max(0.01, kx * d.dx - 1);
                })
                .attr("height", function(d) {
                    return d.children ? headerHeight: Math.max(0.01, ky * d.dy - 1);
                })
                .select(".labelbody .label")
                .attr("style", function(d) {
                    return "width:"  + Math.max(0.01, (kx * d.dx - 1)) + "px;" +
                           "height:" + (d.children ? headerHeight + "px": ky * d.dy - 1 + "px;");
                })
                .text(function(d) {
                    return d.name;
                });

        // update the width/height of the rects
        zoomTransition.select("rect")
                .attr("width", function(d) {
                    return Math.max(0.01, kx * d.dx - 1);
                })
                .attr("height", function(d) {
                    return d.children ? headerHeight : Math.max(0.01, ky * d.dy - 1);
                })
                .style("fill", function(d) {
                    return d.children ? headerColor : color(d.parent.name);
                });

        node = d;

        if (d3.event) {
            d3.event.stopPropagation();
        }
    }
</script>

</html>