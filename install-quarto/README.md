# install-quarto

Install last Quarto release (https://github.com/quarto-dev/quarto-cli/releases) using GitHub Actions. This action can be used to install Quarto on all runner OS and `quarto` will be available from PATH.

## Usage

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

This action will 

* Download the Github Release of quarto on Mac and Linux and install it
* On Windows, it will for now use Scoop to install Quarto msi, until Quarto MSI file can be installed on Github Action (https://github.com/quarto-dev/quarto-cli/issues/108)
