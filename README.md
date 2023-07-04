# Github Actions for Quarto

This repository stores [Github Actions](https://github.com/features/actions) useful for building and publishing [Quarto](https://quarto.org/) documents.

1. [quarto-dev/quarto-actions/setup](./setup) - Install Quarto
2. [quarto-dev/quarto-actions/render](./render) - Render project
3. [quarto-dev/quarto-actions/publish](./publish) - Publish project

We recommend using `v2` for your actions, and our examples all use `v2`.

## Examples

In [Examples](./examples), you will find a YAML workflow file to serve as a template to be reused as a base for your project. We are also sharing some links to real example Github repositories using Quarto with Github Actions for rendering and deploying documents and projects. If you want to add your repository in the list, we welcome a PR.

## Release Management

This repository uses [GitHub's recommended release management for actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions#using-release-management-for-actions): 

* GitHub releases with tags are used for updates on the actions. 
* Semantic versioning is used, with major, minor and possibly patch release. 
* Major versions (such as `v1`) will always point to the last minor or patch release for this major version. (when `v1.0.2` is out, `v1` will point to this update, too). This means using `quarto-dev/quarto-actions/setup@v2` in your workflow file will automatically get the updated versions. Using `quarto-dev/quarto-actions/setup@v1.0.2` will pin a specific release.
* Major version changes (`v1` to `v2`) will often come with breaking changes, and workflows might require manual updates.