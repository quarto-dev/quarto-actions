# Using Quarto Actions: do not render

By default, `quarto publish` will re-render your project before publishing it.
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

## Chaining render then publish

By default, `quarto publish` will render to all format defined before publishing.  
If you need to customize the rendering step, e.g only render one format in CI before publishing, use a two step process: 

* `quarto render` by providing the targer output format
* `quarto publish --no-render` to skip re-rendering before publishing

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
    path: ${{ env.QUARTO_OUTPUT }} # define this env var if you are using a non default output-dir
```