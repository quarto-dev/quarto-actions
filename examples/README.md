# Using Quarto Actions: Examples

* [Basics](./example-01-basics.md)
* [Freeze](./example-02-freeze.md)
* [Dependencies](./example-03-dependencies.md)
* [Render with no publish](./example-04-render-no-publish.md)
* [Rendering and publishing a non-top-level project](./example-05-non-top-level.md)
* [Publishing a single format, publishing without rendering](./example-06-no-render.md)
* [Publishing a single format](./example-07-publish-single-format.md)
* [Publishing to other services](./example-08-publish-to-others-services.md)

## Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook), [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-publish.yml)) This book contains `.md` and `.ipynb` files, and is built with Quarto and Python in GHA, and deployed to Github Pages. 

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals), [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml)) This projects uses a workflow to build several books with R and Quarto and organizes them in a website deployed to Github pages.

- [Pathology Atlas](https://www.patolojiatlasi.com/EN) ([source](https://github.com/patolojiatlasi/patolojiatlasi.github.io), [workflow file](https://github.com/patolojiatlasi/patolojiatlasi.github.io/blob/main/.github/workflows/Quarto-Render-Bilingual-Book-Push-Other-Repos-GitLab.yml)) This multilingual website is rendered in two versions and deployed using Github Actions. 
