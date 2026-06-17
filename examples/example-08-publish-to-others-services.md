# Quarto Actions: Publishing to others services not supported by `quarto publish`

With the `publish` action, you can publish to [any supported destinations](https://quarto.org/docs/publishing/ci.html#publishing-credentials). If you need to publish to another service, the following can be done: 

* use the `quarto-actions/render` action to render the project on CI (usually to a `_book` or `_site` directory, or any other name you used)
* use a custom Github action step to publish the rendered project to the service of your choice. 

The custom step could be using a CLI tool you have installed, or another Github action from the Github marketplace. 

Below is an example to publish to Cloudfare Pages, using their Github action [`cloudflare/wrangler-action`](https://github.com/cloudflare/wrangler-action).

```yaml
on:
  workflow_dispatch:
  push:
    branches: main

name: Quarto Publish to Cloudfare Pages

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      deployments: write # needed for Cloudflare
    steps:
      - name: Check out repository
        uses: actions/checkout@v6

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2
        with:
          tinytex: true
          
      - name: Render Quarto Project
        uses: quarto-dev/quarto-actions/render@v2
      
      - name: Publish
        uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          command: pages deploy _book --project-name=cloudflare-project-name # replace _book with _site or your output-dir from `_quarto.yml`
          gitHubToken: ${{ secrets.GITHUB_TOKEN }}
```
