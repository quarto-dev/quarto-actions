# Quarto Actions: Rendering a single format

With the `publish` action, it is either rendering all format by default, or none with  `render: false`. If you need to customize the rendering step, e.g. only render one format in CI before publishing, use a two step process: 

* use the `quarto-actions/render@v2` action and provide a target output format (in this example YAML configuration, we use the HTML format)
* use the `quarto-actions/publish@v2` action with `render: false` to skip rendering before publishing (in this example YAML configuration, we publish to GitHub Pages)

```yaml
- name: Render Book project
  uses: quarto-dev/quarto-actions/render@v2
  with:
    to: html

- name: Publish HTML book
    uses: quarto-dev/quarto-actions/publish@v2
  with:
    target: gh-pages
    render: false
```
