# Using Quarto Actions: do not render

By default, `quarto publish` will re-render your project before publishing it.
However, if you store the rendered project in version control, you don't need
the GitHub action to re-render the project. In that case, add the option `render: false`
to the `publish` action:

```yaml
- name: Publish to GitHub Pages (and render)
  uses: quarto-dev/quarto-actions/publish@v2
  with:
    to: gh-pages
    render: false
```

