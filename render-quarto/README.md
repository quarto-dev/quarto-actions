# A Github Action to Render Quarto Documents

This repository stores the `quarto-render` [GitHub Action](https://github.com/features/actions) for use with [Quarto](https://quarto.org/) projects. This action will call `quarto render` on the root directory of the repo. It also has example workflows for some common uses centered around web publishing.

## Examples

### Rendering a static `quarto` site and pushing to `gh-pages` branch

If your quarto project has `freeze: true`, you can use this Github action to render your documents and publish your workflow to Github pages by using something like the following workflow:

```yaml
# .github/workflows/render-and-publish.yaml
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

- See [here](https://github.com/pommevilla/friendly-dollop) for an example page that runs this workflow with `freeze: true` that has both Python and R code.
- Read more about using freeze in your Quarto project [here](https://quarto.org/docs/projects/code-execution.html#freeze).

### Installing Python or R dependencies before using `quarto-render` and publishing results to the `gh-pages` branch.

You can use `quarto-render` with Quarto projects that aren't frozen by first reinstalling the packages used by your documents before rendering.

- For R libraries, use `renv` to capture dependencies for your RMarkdown code and use it to restore your environment in your workflow.
  - Example job steps are [here](https://rstudio.github.io/renv/articles/ci.html#github-actions-1).
  - Read more about `renv` at the [package site](https://rstudio.github.io/renv/articles/renv.html).
- Use `pip freeze > requirements.txt` to capture Python package requirements. You can then restore your environment via `pip install -r requirements.txt`
  - Note that if you are on a Windows machine and running a Github workflow on a non-Windows image, then the above command should be modified to `pip freeze | grep -iv "win" > requirements.txt` to avoid capturing Windows-specific pacakges in your `requirements.txt`. These packages will cause errors when attempting installation on non-Windows machine.

Below is the workflow used [in an example repository](https://github.com/pommevilla/hinterland-harbor) to restore the Python and R dependencies required for its documents before rendering them with the `quarto-render` Github action and pushing them to the `gh-pages` branch with `action-gh-pages` ([link](https://github.com/peaceiris/actions-gh-pages)).

```yaml
# .github/workflows/render-and-publish.yaml
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

- See [here](https://github.com/pommevilla/hinterland-harbor) for an example repository that implements this workflow.
- While it is possible to use `quarto-render` in this way, you'll have a much better experience using `freeze`. See [here](https://github.com/pommevilla/hinterland-harbor#you-should-probably-use-freeze) for some more discussion.
