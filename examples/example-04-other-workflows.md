# Using Quarto Actions: other workflows

## Render without publishing

If you need to render your project in a GitHub Action, but will use the output for something besides publishing (or publishing to a service not supported by `quarto publish`), then use the `render` action:

```yaml
- name: Render Quarto Project
  uses: quarto-dev/quarto-actions/render@v2
```