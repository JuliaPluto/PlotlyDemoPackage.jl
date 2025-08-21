module PlotlyDemoPackage
import JSON

const plotly_cdn_url = "https://cdn.jsdelivr.net/npm/plotly.js-dist-min@3.1.0/plotly.min.js"
const mathjax_cdn_url = "https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-svg-full.js"




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
		await import("$mathjax_cdn_url")
	
	if(window.Plotly == null)
		await import("$plotly_cdn_url")

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