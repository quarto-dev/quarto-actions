# Examples of workflow YAML files

You'll find here some generic workflows for Quarto projects.

## Templates

### Quarto Book

- [`quarto-book-gh-pages`](./quarto-book-gh-pages.yaml): Render an HTML Quarto Book and deploy to github pages

- [`quarto-book-netlify`](./quarto-book-netlify.yaml): Render an HTML Quarto Book and deploy to [Netlify](https://www.netlify.com). Requires secrets, see the Netlify section below.

### Quarto Blog

- [`quarto-blog-netlify`](./quarto-blog-netlify.yaml): Render an HTML Quarto Blog and deploy to [Netlify](https://www.netlify.com). Requires secrets, see the Netlify section below.

- [`quarto-blog-netlify-downlit`](./quarto-blog-netlify-downlit.yaml): Render an HTML Quarto Blog and deploy to [Netlify](https://www.netlify.com). Adds support for the `code-link: true` option of quarto that requires the R package, downlit. Requires secrets, see the Netlify section below.

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

### Netlify

Workflows that deploy to Netlify require two GitHub secrets, which you can add to your repo by navigating to Settings -> Secrets -> Actions -> New repository secret.

- `NETLIFY_AUTH_TOKEN`: [Personal access tokens](https://app.netlify.com/user/applications#personal-access-tokens) -> New access token
- `NETLIFY_SITE_ID`: Team Page -> Your Site -> Settings -> Site details -> Site information -> API ID

For more details, see [this Netlify action](https://github.com/nwtgck/actions-netlify) that handles the deployment.

## Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook)). Book with `*.md` and `.ipynb` is built with Quarto and Python in GHA and deployed to Github Pages. [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-render.yml).

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals)) uses a complex workflow to build several books with R and Quarto and organizes them in a unique website deployed to Github pages. [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml).

- [Pathology Atlas](https://www.patolojiatlasi.com/EN) is a multilingual website ([source](https://github.com/patolojiatlasi/patolojiatlasi.github.io)). Two versions are rendered and deployed using Github Action. [workflow file](https://github.com/patolojiatlasi/patolojiatlasi.github.io/blob/main/.github/workflows/Quarto-Render-Bilingual-Book-Push-Tweet-Updates.yml)

- [Davis Vaughan's Blog](https://blog.davisvaughan.com) is an R focused blog that is powered by Quarto ([source](https://github.com/DavisVaughan/blog)). The blog is automatically rendered through GitHub Actions and deployed to Netlify. [workflow file](https://github.com/DavisVaughan/blog/blob/main/.github/workflows/quarto-blog-netlify-downlit.yaml).
