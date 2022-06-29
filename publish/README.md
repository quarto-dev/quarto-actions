## Netlify 

1. Create Netlify auth token. Go to Netlify's [applications page](https://app.netlify.com/user/applications), and click on "New Access Token" to create a new personal access token.
Give this token a memorable name, and note the resulting string (or keep this window open in a tab)

2. Add Netlify auth token to your repository's secrets. Go to the repository that will be using this GHA. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `NETLIFY_AUTH_TOKEN`, and for the "Value" field, paste the string you got from step 1.

3. Add the GitHub Actions workflow to your project. (Use [quarto-publish-example.yml](https://github.com/quarto-dev/quarto-actions/blob/main/examples/quarto-publish-example.yml) as an example).

4. Add `_publish.yml` to your repository. Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish netlify` locally once (TODO: how does this work in IDE?).

5. Configure action to use netlify:
   
   ```yaml
   - name: Publish to Netlify (and render)
     uses: quarto-dev/quarto-actions/publish@v2
     with:
       target: netlify
   ```

## GitHub Pages

1. Add the GitHub Actions workflow to your project. (Use [quarto-publish-example.yml](https://github.com/quarto-dev/quarto-actions/blob/main/examples/quarto-publish-example.yml) as an example).

2. Configure action to use gh-pages:

   ```yaml
   - name: Publish to GitHub Pages (and render)
     uses: quarto-dev/quarto-actions/publish@v2
     with:
       target: gh-pages
   ```

## RStudio Connect

1. Create RStudio Connect auth token.  After logging in to your RStudio Connect server, click on your username on the top right. A sidebar should slide in from the right. Click on "API keys". On the new page, click on the "New API Key" button. Give it a memorable name and note the resulting string (or keep this browser window open).

2. Add RStudio Connect auth token to your GitHub repository. Go to the GitHub webpage for the repository that will be using this GitHub Action. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `CONNECT_API_KEY`, and for the "Value" field, paste the string you got from step 1.

3. Add the GitHub Actions workflow to your project. (Use [quarto-publish-example.yml](https://github.com/quarto-dev/quarto-actions/blob/main/examples/quarto-publish-example.yml) as an example).

4. Add `_publish.yml` to your repository. Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish connect` locally once (TODO: how does this work in IDE?).

5. Configure action to use gh-pages:

   ```yaml
   - name: Publish to Netlify (and render)
     uses: quarto-dev/quarto-actions/publish@v2
     with:
       target: gh-pages
   ```



