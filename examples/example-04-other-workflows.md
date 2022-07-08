# Using Quarto Actions: other workflows

## Render without publishing

If you need to render your project in a GitHub Action, but will use the output for something besides publishing (or publishing to a service not supported by `quarto publish`), then instead of `publish`, use the `render` action:

```yaml
- name: Render Quarto Project
  uses: quarto-dev/quarto-actions/render@v2
```

Use also this action if you need to render to a specific format that you want to publish (`quarto publish` will render to all format before publishing unless `--no-render` is passed).

```yaml
- name: Render Quarto Project
  uses: quarto-dev/quarto-actions/render@v2
  with:
    to: html
```
