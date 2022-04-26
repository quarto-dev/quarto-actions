# Examples of workflow YAML files

## Templates 

### Quarto Book

- [`quarto-book-gh-pages`](./quarto-book-gh-pages.yaml): Render a HTML Quarto Book and deploy to github pages

- [`quarto-book-netlify`](./quarto-book-netlify.yaml): Render a HTML Quarto Book and deploy to [Netlify](https://www.netlify.com). You must also config 2 github secrets:
  - `NETLIFY_AUTH_TOKEN`: [Personal access tokens](https://app.netlify.com/user/applications#personal-access-tokens) > New access token
  - `NETLIFY_SITE_ID`: team page > your site > Settings > Site details > Site information > API ID
  - More details see [this Netlify action](https://github.com/nwtgck/actions-netlify).

## Repositories using Quarto actions

- [Earthdata Cloud Cookbook](https://nasa-openscapes.github.io/earthdata-cloud-cookbook/) ([source](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook)). Book with `*.md` and `.ipynb` is built with Quarto and Python in GHA and deployed to Github Pages. [workflow file](https://github.com/NASA-Openscapes/earthdata-cloud-cookbook/blob/main/.github/workflows/quarto-render.yml).

- [R Manuals Quarto website](https://rstudio.github.io/r-manuals/) ([source](https://github.com/rstudio/r-manuals)) uses a complex workflow to build several books with R and Quarto and organizes them in a unique website deployed to Github pages. [workflow file](https://github.com/rstudio/r-manuals/blob/main/.github/workflows/build-website.yaml).

- [Pathology Atlas](https://www.patolojiatlasi.com/EN) is a multilingual website ([source](https://github.com/patolojiatlasi/patolojiatlasi.github.io)). Two versions are rendered and deployed using Github Action. [workflow file](https://github.com/patolojiatlasi/patolojiatlasi.github.io/blob/main/.github/workflows/Quarto-Render-Bilingual-Book-Push-Tweet-Updates.yml)