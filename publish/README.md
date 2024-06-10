## Netlify 

1. Create Netlify auth token. Go to Netlify's [applications page](https://app.netlify.com/user/applications), and click on "New Access Token" to create a new personal access token.
Give this token a memorable name, and note the resulting string (or keep this window open in a tab)

2. Add Netlify auth token to your repository's secrets. Go to the repository that will be using this GHA. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `NETLIFY_AUTH_TOKEN`, and for the "Value" field, paste the string you got from step 1.

3. Add the GitHub Actions workflow to your project. (Use [quarto-publish-example.yml](../examples/quarto-publish-example.yml) as an example).

4. Add `_publish.yml` to your repository. Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish netlify` locally once.

5. Configure action to use netlify:
   
   ```yaml
   - name: Publish to Netlify (and render)
     uses: quarto-dev/quarto-actions/publish@v2
     with:
       target: netlify
       NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
   ```

## GitHub Pages

1. Create the `gh-pages` branch in your repository: Follow the "Branches" link next to the current branch dropdown in the repository home, then press the "New branch" button and enter "gh-pages" as the name for the new branch.

2. Under Settings > Pages > Build and deployment, in the Source dropdown, ensure **Deploy from a branch** is selected; then, under the Branch section, select the root of the gh-pages branch.

3. Add the GitHub Actions workflow to your project. Go to the Actions tab, press the "New workflow" button, then follow the "set up a workflow yourself" link. Use [quarto-publish-example.yml](../examples/quarto-publish-example.yml) as a template to for your action code. Make sure to uncomment the `permissions:` block at the beginning, and the GitHub Pages block.

## Posit Connect

1. Create Posit Connect auth token.  After logging in to your Posit Connect server, click on your username on the top right. A sidebar should slide in from the right. Click on "API keys". On the new page, click on the "New API Key" button. Give it a memorable name and note the resulting string (or keep this browser window open).

2. Add Posit Connect auth token to your GitHub repository. Go to the GitHub webpage for the repository that will be using this GitHub Action. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `CONNECT_API_KEY`, and for the "Value" field, paste the string you got from step 1.

3. Add the GitHub Actions workflow to your project. (Use [quarto-publish-example.yml](../examples/quarto-publish-example.yml) as an example).

4. Add `_publish.yml` to your repository. Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish connect` locally once.

5. Configure action to use Posit Connect:

   ```yaml
   - name: Publish to Posit Connect (and render)
     uses: quarto-dev/quarto-actions/publish@v2
     with:
       target: connect
       CONNECT_SERVER: enter-your-server-url-here
       CONNECT_API_KEY: ${{ secrets.CONNECT_API_KEY }} 
   ```

## Other configurations

The `with` parameter can also be set to configure the following

* `path`: Subdirectory containing the quarto project to be published or path to individual .qmd file. Default to working directory (`.`)
* `render`: Set to `render: "false"` to skip rendering of project before publishing. By default, this `publish` action will render to all formats defined.
