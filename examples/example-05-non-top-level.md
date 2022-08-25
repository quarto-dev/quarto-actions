# Quarto Actions: non-top-level projects

It's possible to have a quarto project in a large GitHub repository, where the quarto project does not reside at the top-level directory. In this case, add a `path` input to the invocation of the `render` or `publish` action. For example:

```yaml
- name: Publish to GitHub Pages (and render)
  uses: quarto-dev/quarto-actions/publish@v2
  with:
    target: gh-pages
    path: subdirectory-to-use
```