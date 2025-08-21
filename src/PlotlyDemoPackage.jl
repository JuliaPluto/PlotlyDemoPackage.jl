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


const plotly_cdn_url = "https://cdn.jsdelivr.net/npm/plotly.js-dist-min@3.1.0/plotly.min.js"
const mathjax_cdn_url = "https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-svg-full.js"

const use_cdn = Ref(false)


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

    # You could also use HypertextLiteral.jl for this to make it faster an nicer looking.
	out = """
	<div id=$id></div>
	<script type="module">
	if(window.MathJax == null)
		await import("$(use_cdn[] ? mathjax_cdn_url : mathjax_local_url)")
	
	if(window.Plotly == null)
		await import("$(use_cdn[] ? plotly_cdn_url : plotly_local_url)")

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



Base.show(io::IO, m::MIME"juliavscode/html", p::_MyPlotType) = Base.show(io, MIME"text/html"(), p)






    
    
    



end