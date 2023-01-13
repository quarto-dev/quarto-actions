# Usage

```yaml
- name: Render Quarto Project
  uses: quarto-dev/quarto-actions/render@v2
  with:
    to: html # If set, it will be equivalent to `quarto render --to html`
    path: source-folder # By default, the current working dir is used i.e `quarto render .` Can also be a path to a single .qmd file.
```
