# Examples of workflow YAML files

You'll find here some generic workflows for Quarto projects.

## Templates

### Quarto Book

- [`quarto-book-gh-pages`](./quarto-book-gh-pages.yaml): Render an HTML Quarto Book and deploy to github pages

- [`quarto-book-netlify`](./quarto-book-netlify.yaml): Render an HTML Quarto Book and deploy to [Netlify](https://www.netlify.com). You must also config 2 github secrets:
  - `NETLIFY_AUTH_TOKEN`: [Personal access tokens](https://app.netlify.com/user/applications#personal-access-tokens) > New access token
  - `NETLIFY_SITE_ID`: team page > your site > Settings > Site details > Site information > Site ID
  - More details see [this Netlify action](https://github.com/nwtgck/actions-netlify).

### How to use ?

1. Download one of the YAML workflows into the `.github/workflows` folder of your project where [Github Actions Workflows](https://docs.github.com/en/actions/quickstart) are stored
2. Edit the workflow file according to your needs, especially adding steps to setup any computation engines you may need (Python, R, Julia, ...). 

See the repository examples using Quarto actions below.

#### Specific for R users

With the [**usethis**](https://usethis.r-lib.org/) package, R users can easily add one of these example workflow in a project using [`usethis::use_github_action()`](https://usethis.r-lib.org/reference/github_actions.html) and the full URL of the raw YAML file. Example (where `v1` indicates the version tag):

```r
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/quarto-dev/quarto-actions/v1/examples/quarto-book-gh-pages.yaml"
)
```

This will download the YAML file into the `.github/workflows/` folder of your project, where it can be further adapted to your project (like adding a step to install R and R dependencies).

## Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook)). Book with `*.md` and `.ipynb` is built with Quarto and Python in GHA and deployed to Github Pages. [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-render.yml).

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals)) uses a complex workflow to build several books with R and Quarto and organizes them in a unique website deployed to Github pages. [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml).

- [Pathology Atlas](https://www.patolojiatlasi.com/EN) is a multilingual website ([source](https://github.com/patolojiatlasi/patolojiatlasi.github.io)). Two versions are rendered and deployed using Github Action. [workflow file](https://github.com/patolojiatlasi/patolojiatlasi.github.io/blob/main/.github/workflows/Quarto-Render-Bilingual-Book-Push-Tweet-Updates.yml)
