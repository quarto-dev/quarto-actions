# Example Github Workflows

- [`simple-render-and-publish`](#simple-render-and-publish) - Render a Quarto `site` project with `freeze: true` and publish it to the `gh-pages` branch.
- [`recreate-venv-render-and-publish`](#recreate-venv-render-and-publish) - Recreate R or Python virtual environments before rendering and publishing to the `gh-pages` branch

### Simple render and Publish

This workflow installs the latest version of Quarto, renders the root directory of the repo, and publishes it to the `gh-pages` branch using [`peaceiris/actions-gh-pages`](https://github.com/peaceiris/actions-gh-pages) action. This action assumes that the project has [frozen execution](https://quarto.org/docs/projects/code-execution.html#freeze) and that the project type is `site` (see [here](https://quarto.org/docs/projects/quarto-projects.html) for more info).

#### When should you use it?

* Your Quarto project is of the type `site`
* You've set `freeze: true` in `_quarto.yml`

#### Workflow Example

``` yaml
# Workflow from https://github.com/quarto-dev/quarto-actions/examples/simple-render-and-publish.yaml
name: Render and deploy Quarto files
on:
  push:
  pull_request:

jobs:
  quarto-render-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: "Install Quarto and render"
        uses: quarto-dev/quarto-actions/render-quarto@v1

      - name: "Deploy to gh-pages"
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_site
```

### <a name="recreate-venv-render-and-publish"></a>Recreate virtual environment, render, and publish

If your project has a [Python `venv` file](https://docs.python.org/3/tutorial/venv.html) or an [renv](https://rstudio.github.io/renv/articles/renv.html) `renv.lock` file, you can recreate these virtual environments prior to using this action. From there, you can use the `render-quarto` action to render the project and publish it to `gh-pages`. 

#### When should you use it?

- Using `freeze: true` doesn't make sense for your workflow or collaboration style.

```yaml
# .Workflow from https://github.com/quarto-dev/quarto-actions/examples/recreate-venv-render-and-publish.yaml
name: Render and deploy Quarto files
on:
  push:
  pull_request:

jobs:
  quarto-render-and-deploy:
    runs-on: ubuntu-latest
    env:
      RENV_PATHS_ROOT: ~/.local/share/renv
    steps:
      - uses: actions/checkout@v2

      - uses: actions/setup-python@v2

      - name: "Install Python deps"
        run: |
          pip install -r requirements.txt

      - uses: r-lib/actions/setup-r@v1

      - name: "Install curl for Bioconductor"
        run: |
          sudo apt -y install libcurl4-openssl-dev

      - name: "Install R Packages: Cache packages"
        uses: actions/cache@v1
        with:
          path: ${{ env.RENV_PATHS_ROOT }}
          key: ${{ runner.os }}-renv-${{ hashFiles('**/renv.lock') }}
          restore-keys: |
            ${{ runner.os }}-renv-

      - name: "Install R Packages: Restore packages"
        shell: Rscript {0}
        run: |
          if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
          renv::restore()

      - name: "Install Quarto and render"
        uses: quarto-dev/quarto-actions/render-quarto@v1

      - name: "Deploy to gh-pages"
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_site
```