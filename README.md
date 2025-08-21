# PlotlyDemoPackage.jl
This (unregisted) package demonstates how you can expose Plotly in a Julia package, in a way that works reliably in all Julia programming environments.



# How to use
See [How to test plotly.md](How to test plotly.md) for examples in each environment.

In short:


```julia
begin
    import Pkg
    Pkg.activate(temp=true)
    Pkg.add([
        Pkg.PackageSpec(
            url="https://github.com/JuliaPluto/PlotlyDemoPackage.jl", # fill in package URL
            rev="main", # fill in branch name here
        ),
    ])
    using Plots
end
```

```julia
plot(1:10, rand(10))
```


This demo package only supports:

```julia
plot(x::Vector, y::Vector)
```

## Offline mode
By default, plots get JS assets from the jsdelivr CDN. To use offline mode, set `PlotlyDemoPackage.use_cdn[] = false` and re-display a plot.



# Used technologies
Notable are:
- No requireJS (it has been deprecated/abandoned for a long time)
- `<script type="module">` for top-level await
- E6 dynamic `import` to dynamically load libraries or not, depending on what is already loaded. E.g. Pluto and Jupyter preload MathJax.
- top-level `await` to avoid redundant work when rendering multiple plots at the same time.
- Julia Artifacts to make the JS assets available in a very reliable way.
- No Pkg build step for reliability
- Data URL (using Base64) to make the local JS assets available without relying on file server dynamics.


# Pluto optimizations _(not in this package)_
Using specific API for Pluto, we could make the experience even better in Pluto. Right now, **this is not done** for simplicity.

What would be added:
- [`AbstractPlutoDingetjes.Display.published_to_js`](https://plutojl.org/en/docs/abstractplutodingetjes/#published_to_js) for:
  - offline support without performance penalty.
  - displaying large amounts of data more quickly.
- [`AbstractPlutoDingetjes.Display.is_inside_pluto`](https://plutojl.org/en/docs/abstractplutodingetjes/#is_inside_pluto) to display different content when rendered in a Pluto(-compatible) display.
- `Plotly.react` and some of Pluto's [JS API](https://plutojl.org/en/docs/javascript-api/) to dynamically update plots when the data changes, for ultra-fast updates without layout shift.

These technologies are used in the https://github.com/JuliaPluto/PlutoPlotly.jl package, but it would be nice to make some of it available by default in other plotting package.


# Environment support
It works in all environments!


## In Jupyter
<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 33 29" src="https://github.com/user-attachments/assets/bd63b471-bbee-4774-b163-2a96e08a3e41" />

## In Pluto
<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 35 51" src="https://github.com/user-attachments/assets/9c10e532-3101-4c57-bd50-445ee5d25f94" />


## In VS Code notebooks
<img width="1440" height="900" alt="Scherm­afbeelding 2025-08-19 om 17 35 24" src="https://github.com/user-attachments/assets/47c8ad02-8aef-44fc-8edf-9b97b19f25b6" />


## In VS Code results
<img width="1440" height="900" alt="Scherm­afbeelding 2025-08-21 om 09 26 47" src="https://github.com/user-attachments/assets/c57ab57e-2e7d-4c71-952e-b4b07b567919" />



## In the web
You can write the HTML repr to a file and open it in a browser:

```julia
p = plot(1:100, rand(100))

write("/Users/fons/Downloads/test.html", repr(MIME"text/html"(), p))
```

<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 36 42" src="https://github.com/user-attachments/assets/47d00094-74c9-48f3-8d40-e8a3bc004f4b" />

This HTML snippet also works when embedded in a larger page.


