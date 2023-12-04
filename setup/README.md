# setup

Setup a Quarto release (https://github.com/quarto-dev/quarto-cli/releases) using GitHub Actions. This action can be used to install Quarto on all runner OSs, so that `quarto` will be available from the path.

## Usage

This action will:

* On macOS and Linux:
  - Download a release of Quarto from GitHub and install it
  - use `gh` to download the latest available bundle, if no `version` is specified as input. If `gh` is not available on your Github Action runner, you can specify a fixed `version` which will be directly downloaded using `wget`.
  - Install TinyTeX if requested.
* On Windows:
  - Use **Scoop** (https://github.com/ScoopInstaller/Scoop) to install Quarto, as we have still an issue with Quarto MSI on Github Action (https://github.com/quarto-dev/quarto-cli/issues/108). The action will also install **Scoop** on the runner.

We recommend using a Linux or MacOS runner if possible, especially if TinyTeX is needed.

### Inputs available

* `version` - _optional_. If provided, the specific quarto version will be installed. Ex: `version: 1.4.515`

  ```yaml
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: 1.4.515
  ```
  
  If not provided, `setup` will use the latest _released_ version of quarto.
  
  If the latest `pre-release` build is desired, use `version: pre-release`.

* `tinytex` - _optional_. Set `tinytex: true` to [install TinyTeX](https://quarto.org/docs/output-formats/pdf-engine.html#installing-tex) using `quarto install tool tinytex`. Note: Installing TinyTeX on Windows can take several minutes.

  ```yaml
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
        with:
          tinytex: true
  ```

### GitHub Enterprise

For GitHub Enterprise Server (GHES), you may need to [generate a personal access token (PAT) on github.com](https://github.com/settings/tokens/new) to enable downloading Quarto. GitHub's [setup-python action](https://github.com/actions/setup-python/blob/main/docs/advanced-usage.md#avoiding-rate-limit-issues) uses a similar workaround, from which these instructions are adapted:

  - Create a PAT on any github.com account by using [this link](https://github.com/settings/tokens/new) after logging into github.com (not your GHES instance). This PAT does not need any rights, so make sure all the boxes are unchecked.
  - Store this PAT in the repository / organization where you run your workflow, e.g. as `GH_GITHUB_COM_TOKEN`. You can do this by navigating to your repository -> **Settings** -> **Secrets** -> **Actions** -> **New repository secret**.
  - In your workflow, incorporate your PAT as an environment variable. For example:

    ```yaml
    - name: Set up Quarto
      uses: quarto-dev/quarto-actions/setup@v2
      env:
        GH_TOKEN: ${{ secrets.GH_GITHUB_COM_TOKEN }}
    ```

## Examples

```yaml
name: quarto-setup

on: 
  branch: main

jobs:
  quarto-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
      - run: |
          quarto --version
  quarto-windows:
    runs-on: windows-latest
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
      - run: |
          quarto --version
  quarto-macos:
    runs-on: macos-latest
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
      - run: |
          quarto --version
```

