# Quarto Actions: Basics

The simplest workflow using Quarto Actions uses the `setup` and `publish` actions: [quarto-publish-example.yml](quarto-publish-example.yml). Note that GitHub Pages use a `gh-pages` branch in your repository, which will be automatically created if one doesn't exist.

## GitHub Pages

1. **Add the GitHub Actions workflow to your project**

   Copy [quarto-publish-example.yml](quarto-publish-example.yml) to `.github/workflows/quarto-publish.yml`. Uncomment the "Publish to GitHub Pages (and render)" action. No further changes are needed to the action (in particular, do *not* edit the line below to add a secret to this file. This file has the same permissions as your repository, and might be publicly readable)
   
2. **Add `_publish.yml` to your repository**

   Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish gh-pages` locally once.

Now, add and commit the workflow file you have just created, and push the result to GitHub. This should trigger a new action from GitHub that will automatically render and publish your website through GitHub pages.


## Netlify

1. **Create Netlify auth token**

   Go to Netlify's [applications page](https://app.netlify.com/user/applications), and click on "New Access Token" to create a new personal access token. Give this token a memorable name, and note the resulting string (or keep this browser window open).

2. **Add Netlify auth token to your GitHub repository**

   Go to the GitHub webpage for the repository that will be using this GitHub Action. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `NETLIFY_AUTH_TOKEN`, and for the "Value" field, paste the string you got from step 1.

3. **Add the GitHub Actions workflow to your project**

   Copy [quarto-publish-example.yml](quarto-publish-example.yml) to `.github/workflows/quarto-publish.yml`.
   
   Uncomment the "Publish to Netlify (and render)" action. No further changes are needed (in particular, do *not* edit the line below to add a secret to this file. This file has the same permissions as your repository, and might be publicly readable)

4. **Add `_publish.yml` to your repository**

   Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish netlify` locally once.


Finally, add and commit the files you have just created, and push the result to GitHub. This should trigger a new action from GitHub that will automatically render and publish your website through Netlify.

## RStudio Connect

1. **Create RStudio Connect auth token**

   After logging in to your RStudio Connect server, click on your username on the top right. A sidebar should slide in from the right. Click on "API keys". On the new page, click on the "New API Key" button. Give it a memorable name and note the resulting string (or keep this browser window open).

2. **Add RStudio Connect auth token to your GitHub repository**

   Go to the GitHub webpage for the repository that will be using this GitHub Action. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `CONNECT_API_KEY`, and for the "Value" field, paste the string you got from step 1.

3. **Add the GitHub Actions workflow to your project**

   Copy [quarto-publish-example.yml](quarto-publish-example.yml) to `.github/workflows/quarto-publish.yml`. Uncomment the "Publish to RStudio Connect (and render)" action, and change the CONNECT_SERVER entry to the URL of your RStudio Connect server. No further changes are needed to the action (in particular, do *not* edit the line below to add a secret to this file. This file has the same permissions as your repository, and might be publicly readable)

4. **Add `_publish.yml` to your repository**

   Quarto stores publishing metadata information in `_publish.yml`. To create this file, run `quarto publish connect` locally once.

Finally, add and commit the files you have just created, and push the result to GitHub. This should trigger a new action from GitHub that will automatically render and publish your website through RStudio Connect.



