# Github Actions for Quarto

This repository stores [Github Actions](https://github.com/features/actions) around Quarto (https://quarto.org/)

1. [quarto-dev/quarto-actions/install-quarto](https://github.com/quarto-dev/quarto-actions/tree/master/install-quarto) - Install Quarto binary

## Examples

### Template of workflow YAML file

See [Examples](./examples) for different YAML worflow file to render and deploy Quarto documents and projects

### Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook)). Book with `*.md` and `.ipynb` is built with Quarto and Python in GHA and deployed to Github Pages. [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-render.yml).

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals)) uses a complex workflow to build several books with R and Quarto and organizes them in a unique website deployed to Github pages. [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml).