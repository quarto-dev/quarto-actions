# Quarto Actions: Rendering Julia tutorials to be Published with Documenter.jl

Quarto Markdown files can be used very well to write tutorials that accompany a documentation
of a Julia package.
The advantage is, that the examples in the tutorials can be run (and cached), and the resulting
markdown files can directly be saved and included within the documentation which is
afterwards rendered using [Documenter.jl](https://documenter.juliadocs.org/stable/).

A challenge here are the dependencies, since the CI not only needs Julia and Quarto, but also
Python, Jupyter – and the Julia package. The dependencies to Python and Jupyter can for example
be handled with [CondaPkg.jl](https://github.com/cjdoris/CondaPkg.jl), since that allows a
versioning similar to the `Project.toml` in Julia packages.

## Folder structure

In this example we assume, that

* the documentation is provided in `docs/src` of the repository
* the tutorials are stored within `tutorials/` as well as for example the corresponding `_quarto_yml`
* the folder the results are stored is in this example `docs/src/tutorials`

Both these folders get their own `Project.toml` to have dependencies for the documentation
different from the dependencies for the tutorials. [Ijulia.jl](https://github.com/JuliaLang/IJulia.jl) should be added to both
the tutorial environment, CondaPkg to the documentation.

## Quarto Setup

the `tutorials/_quarto.yml` should use common mark as rendering, here the output
folder is set to fit the caching below.

```yml
project:
  title: "Manopt.jl Tutorials"
  output-dir: ../docs/src/tutorials
  render:
    - "*.qmd"

execute:
  freeze: auto

format:
  commonmark:
    variant: -raw_html+tex_math_dollars
    wrap: preserve
```

## CondaPkg dependencies

We first specify the versions for Python and Jupyter in `docs/CondaPkg.toml`

```toml
[deps]
jupyter = ""
python = "3.11"
```

## Documenter

We install all necessary python dependencies when the `docs/make.jl` file, that should be
executable, gets the command line argument `--quarto`

A minimal example is for this file is

```julia
#!/usr/bin/env julia
#

# (a) Activate the docs/ environment
if Base.active_project() != joinpath(@__DIR__, "Project.toml")
    using Pkg
    Pkg.activate(@__DIR__)
    Pkg.develop(PackageSpec(; path=(@__DIR__) * "/../")) #put the main package in / into development mode
    Pkg.resolve()
    Pkg.instantiate()
    if "--quarto" ∈ ARGS    # if we render,
        Pkg.build("IJulia") # activate/add the right kernel
    end
end

# (b) Issue the actual rendering
if "--quarto" ∈ ARGS
    using CondaPkg #Loads all Python dependencies
    CondaPkg.withenv() do # activates the Conda environment
        @info "Rendering Quarto"
        tutorials_folder = (@__DIR__) * "/../tutorials"
        # instantiate the tutorials environment if necessary
        Pkg.activate(tutorials_folder)
        Pkg.resolve() #resolve / setup the tutorials environment
        Pkg.instantiate()
        Pkg.activate(@__DIR__) # but return to the docs one before
        run(`quarto render $(tutorials_folder)`) # render
        return nothing
    end
end

# (c) load necessary packages for the documentation
using Documenter#, and all others you need
# (d) call makedocs( to render the docs...
```

For step (d) the [makedocs](https://documenter.juliadocs.org/stable/man/guide/#Building-an-Empty-Document) documentation is recommended

## Documenter CI

For the CI there are four recommended caches

The final `.github/workflow/documenter.yml` might look as follows

```yml
name: Documenter
on:
  push:
    branches: [master]
    tags: [v*]
  pull_request:

jobs:
  docs:
    name: Documentation
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: 1.3.353
      - uses: julia-actions/setup-julia@latest
        with:
          version: 1.9
      - name: "Documenter rendering (including Quarto)"
        run: "docs/make.jl --quarto"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
```

It is probably recommended to cache the following

* Julia – maybe even including the precompiled packages
* The CondaPkg installed dependencies
* The Quarto freeze folder
* The resulting Quarto markdown files

This can be achieved with the following steps added after setting up Julia

```yml
      - uses: julia-actions/cache@v1
        with:
          cache-compiled: "true"
      - uses: actions/cache@v3
        with:
          path: tutorials/_freeze
          key: ${{ runner.os }}-quarto-freeze
      - uses: actions/cache@v3
        with:
          path: docs/src/tutorials
          key: ${{ runner.os }}-documenter-tutorials
      - uses: actions/cache@v3
        with:
          path: docs/.CondaPkg
          key: ${{ runner.os }}-condapkg
```

## Example

Two examples using this scheme are

* [Manopt.jl](https://github.com/JuliaManifolds/Manopt.jl)
* [Manifolds.jl](https://github.com/JuliaManifolds/Manifolds.jl)
