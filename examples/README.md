# Examples of workflow YAML files

## Templates 

### Quarto Book

- Render a HTML Quarto Book and deploy to github pages ([`quarto-book-gh-pages`](./quarto-book-gh-pages.yaml))

## Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook)). Book with `*.md` and `.ipynb` is built with Quarto and Python in GHA and deployed to Github Pages. [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-render.yml).

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals)) uses a complex workflow to build several books with R and Quarto and organizes them in a unique website deployed to Github pages. [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml).