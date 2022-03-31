# install-quarto

Install a Quarto release (https://github.com/quarto-dev/quarto-cli/releases) using GitHub Actions. This action can be used to install Quarto on all runner OS and `quarto` will be available from PATH

## Usage

This action will:

* Download the Github Release of Quarto on Mac and Linux and install it
* On Windows, it will for now use **Scoop** (https://github.com/ScoopInstaller/Scoop) to install Quarto, as we have still an issue with Quarto MSI on Github Action (https://github.com/quarto-dev/quarto-cli/issues/108). (**Scoop** will be installed on the runner by the action)
* On Linux and MacOS, it will use **gh** CLI to download the last available bundle (no `version` specified as input). If you don't have **gh** on your Github Action runner, you can specify a fix `version` to directly download from a URL using `wget`.

Inputs available

* `version` - _optional_. If provided, the specific quarto version will be installed. Ex: `version: 0.3.71`

  ```yaml
    steps:
      - uses: quarto-dev/quarto-actions/install-quarto@main
        with:
          version: 0.3.71
  ```

Example on different OS:

```yaml
name: quarto-setup

on: 
  branch: main

jobs:
  quarto-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: quarto-dev/quarto-actions/install-quarto@v1
      - run: |
          quarto --version
  quarto-windows:
    runs-on: windows-latest
    steps:
      - uses: quarto-dev/quarto-actions/install-quarto@v1
      - run: |
          quarto --version
  quarto-macos:
    runs-on: macos-latest
    steps:
      - uses: quarto-dev/quarto-actions/install-quarto@v1
      - run: |
          quarto --version
```

