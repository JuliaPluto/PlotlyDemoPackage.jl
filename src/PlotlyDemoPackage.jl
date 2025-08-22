module PlotlyDemoPackage
import JSON
using Artifacts
using Base64

# Get artifact paths
const plotly_artifact_path = artifact"plotly_js"
const mathjax_artifact_path = artifact"mathjax_js"
const plotly_js_file = joinpath(plotly_artifact_path, "plotly.min.js")
const mathjax_js_file = joinpath(mathjax_artifact_path, "tex-svg-full.js")
const plotly_local_url = "data:application/javascript;base64,$(Base64.base64encode(read(plotly_js_file)))"
const mathjax_local_url = "data:application/javascript;base64,$(Base64.base64encode(read(mathjax_js_file)))"

# CDN URLs
const plotly_cdn_url = "https://cdn.jsdelivr.net/npm/plotly.js-dist-min@3.1.0/plotly.min.js"
const mathjax_cdn_url = "https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-svg-full.js"

# Switch between the two
const use_cdn = Ref(true)


export plot

function generate_plotly_data_object(x, y)
    # This is implemented by your package
	[
		Dict(
			"type" => "scatter",
			"x" => x,
			"y" => y,
		)
	]
end

function generate_plotly_layout_object()
    # This is implemented by your package
	Dict(
		"title" => "test",
	)
end

function generate_plotly_config_object()
    # This is implemented by your package
	Dict(
		"responsive" => true,
		"displaylogo" => false,
	)
end

struct _MyPlotType
    data
    layout
    config
end


function plot(x::AbstractVector{<:Real}, y::AbstractVector{<:Real})
    _MyPlotType(
        generate_plotly_data_object(x, y),
        generate_plotly_layout_object(),
        generate_plotly_config_object(),
    )
end

function Base.show(io::IO, m::MIME"text/html", p::_MyPlotType)
    id = String(rand('a':'z',16))

    # You could also use HypertextLiteral.jl for this to make it faster and nicer looking.
	out = """
	<div id=$id></div>
    
    <!-- The asset URLs are included as link elements, instead of interpolated directly into JS. This is a nice semantic way to do it, and it increases performance when using data URIs (because HTML is easier to parse than JS). -->
    
    <link id="$id-mathjax-julia" href="$(use_cdn[] ? mathjax_cdn_url : mathjax_local_url)" >
    <link id="$id-plotlyjs-julia" href="$(use_cdn[] ? plotly_cdn_url : plotly_local_url)" >
    
	<script type="module" id="plotly-julia-script">
    
    // Both MathJax and Plotly can be imported with ES6, but the package itself is still exposed as a global `window` variable, not through an ES6 `export`.
    // This means that it's best to only import the package once, since different imports would collide. (It might already be imported from a different URL on this page, so we can't rely on ES6 import deduplication). 
    
	if(window.MathJax == null)
        // Calling `await import` will load the library, and return when loaded.
		await import(document.querySelector(`link#$id-mathjax-julia`).href)
	
	if(window.Plotly == null)
		await import(document.querySelector(`link#$id-plotlyjs-julia`).href)

    // At this point, both MathJax and Plotly are loaded and defined on `window`.
	Plotly.newPlot(
		"$id", 
		$(JSON.json(p.data)), 
		$(JSON.json(p.layout)), 
		$(JSON.json(p.config)),
	)
	</script>
	"""
	
    write(io, out)
end

# This adds support for the "VS Code Julia" extension "Plot panel".
Base.show(io::IO, m::MIME"juliavscode/html", p::_MyPlotType) = Base.show(io, MIME"text/html"(), p)

end
