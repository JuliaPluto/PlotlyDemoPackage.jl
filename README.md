# PlotlyDemoPackage.jl

It works in all environments!



## In Jupyter
<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 33 29" src="https://github.com/user-attachments/assets/bd63b471-bbee-4774-b163-2a96e08a3e41" />

## In Pluto
<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 35 51" src="https://github.com/user-attachments/assets/9c10e532-3101-4c57-bd50-445ee5d25f94" />


## In VS Code notebooks
<img width="1440" height="900" alt="Scherm­afbeelding 2025-08-19 om 17 35 24" src="https://github.com/user-attachments/assets/47c8ad02-8aef-44fc-8edf-9b97b19f25b6" />


## In VS Code results
TODO


## In the web
You can write the HTML repr to a file and open it in a browser:

```julia
p = plot(1:100, rand(100))

write("/Users/fons/Downloads/test.html", repr(MIME"text/html"(), p))
```

<img width="1440" height="819" alt="Scherm­afbeelding 2025-08-19 om 17 36 42" src="https://github.com/user-attachments/assets/47d00094-74c9-48f3-8d40-e8a3bc004f4b" />

This HTML snippet also works when embedded in a larger page.


