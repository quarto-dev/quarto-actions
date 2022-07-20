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

* `version` - _optional_. If provided, the specific quarto version will be installed. Ex: `version: 0.3.71`

  ```yaml
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: 0.3.71
  ```

* `tinytex` - _optional_. Set `tinytex: true` to [install TinyTeX](https://quarto.org/docs/output-formats/pdf-engine.html#installing-tex) using `quarto install tool tinytex`. Note: Installing TinyTeX on Windows can take several minutes.

  ```yaml
    steps:
      - uses: quarto-dev/quarto-actions/setup@v2
        with:
          tinytex: true
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

