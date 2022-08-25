# Quarto Actions: Publishing without rendering

By default, the `quarto-actions/publish@v2` action will re-render your entire project before publishing.
However, if you store the rendered project in version control, you don't need
the GitHub action to re-render the project. In that case, add the option `render: false`
to the `publish` action:

```yaml
- name: Publish to GitHub Pages (and render)
  uses: quarto-dev/quarto-actions/publish@v2
  with:
    target: gh-pages
    render: false
```
