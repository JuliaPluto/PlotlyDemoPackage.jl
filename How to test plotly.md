# How to test Plotly in different environments
It's easy to test plotly-Julia code in the different Julia programming environments. I wrote a code snippet for each environment, with simple instructions that require no or minimal installation.


## Pluto
Open Pluto. If you don't want to install it, you can use the online version:

https://binder.plutojl.org/ (and click "New notebook")




Use this snippet:

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
plot(rand(10))
```




## Jupyter
Open Jupyter. If you don't want to install it, you can use the online version:

https://mybinder.org/v2/gh/fonsp/pluto-on-binder/HEAD (and start a new Julia notebook) (you can use any Binder instance that has a Project.toml file in the repository)


Use this snippet:

```julia
import Pkg
Pkg.activate(temp=true)
Pkg.add([
    Pkg.PackageSpec(
        url="https://github.com/JuliaPluto/PlotlyDemoPackage.jl", # fill in package URL
        rev="main", # fill in branch name here
    ),
])
using Plots
```

```julia
plot(rand(10))
```


## VS Code Julia extension results
Open VS Code. Enable the Julia extension.

Create a new file (Ctrl+N), and in the bottom right corner, select "Julia" as the file language.

Now use the following snippet:

```julia
import Pkg
Pkg.activate(temp=true)
Pkg.add([
    Pkg.PackageSpec(
        url="https://github.com/JuliaPluto/PlotlyDemoPackage.jl", # fill in package URL
        rev="main", # fill in branch name here
    ),
])
using Plots

plot(rand(10))
```


Run this code with the "Julia REPL" with inline results: Open the command palette (Ctrl+Shift+P), and select "Julia: Execute file in REPL".

When the code finishes, this should open the "Julia Plots (1/1)" panel, with your plot.




## Web
Run the following snippet in a Julia REPL:



```julia
import Pkg
Pkg.activate(temp=true)
Pkg.add([
    Pkg.PackageSpec(
        url="https://github.com/JuliaPluto/PlotlyDemoPackage.jl", # fill in package URL
        rev="main", # fill in branch name here
    ),
])
using Plots
```

```julia
p = plot(rand(10));
```

```julia
write("test_output.html", repr(MIME"text/html"(), p))
```

And now open `test_output.html` in your browser. You can do this from the REPL:

```julia
import DefaultApplication
DefaultApplication.open("test_output.html")
```



## VS Code notebook

Open VS Code. Enable the Julia extension. Open the command palette (Ctrl+Shift+P), and select "Create: New Jupyter Notebook". In the first cell, in the bottom right corner, select "Julia" as the cell language.

Use this snippet:

```julia
import Pkg
Pkg.activate(temp=true)
Pkg.add([
    Pkg.PackageSpec(
        url="https://github.com/JuliaPluto/PlotlyDemoPackage.jl", # fill in package URL
        rev="main", # fill in branch name here
    ),
])
using Plots
```

```julia
plot(rand(10))
```

Now run the cell. Pick a Julia kernel. (This will not install IJulia.jl since it's not needed.)


