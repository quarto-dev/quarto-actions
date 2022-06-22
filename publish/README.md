## Netlify 

1. Create Netlify auth token. Go to Netlify's [applications page](https://app.netlify.com/user/applications), and click on "New Access Token" to create a new personal access token.
Give this token a memorable name, and note the resulting string (or keep this window open in a tab)

2. Add Netlify auth token to your repository's secrets. Go to the repository that will be using this GHA. Click on "Settings". On the new page, click on "Secrets", then on the dropdown "Actions". Now, on the right-hand tab, click on the "New repository secret" button to the right of the title "Actions secrets". For the "Name" field, use `NETLIFY_AUTH_TOKEN`, and for the "Value" field, paste the string you got from step 1.

