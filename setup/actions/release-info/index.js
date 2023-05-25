const core = require("@actions/core");
const github = require("@actions/github");

async function run() {
  // Repo information
  const owner = core.getInput("owner");
  const repo = core.getInput("repo");

  // GH Api
  const myToken = core.getInput("github-token");
  const octokit = github.getOctokit(myToken);
  
  // Redirect info
  // Function to process a release into a set of 
  // download urls / info and a list of redirects
  const processRelease = async (releaseRaw) => {
    const releaseInfo = {};

    // Release metadata
    releaseInfo.version = releaseRaw.tag_name.slice(1);
    releaseInfo.name = releaseRaw.name;
    releaseInfo.created = releaseRaw.created_at;
    releaseInfo.updated = releaseRaw.updated_at;
    releaseInfo.published = releaseRaw.published_at;

    return {
      releaseInfo
    }
  }
  
  // Function to get latest prerelease
  const getPrerelease = async () => {
    // List the releases
    var pagenumber = 1;
    var matchedRelease = undefined;
    while(true) {
      console.log("page " + pagenumber + " of prereleases");
      var releases = await octokit.rest.repos.listReleases({
        owner,
        repo,
        per_page: 25,
        page: pagenumber
      });  

      for (const release of releases.data) {
        if (release.prerelease) {
          matchedRelease = release;
          break;
        }
      }

      if (matchedRelease) {
        break;
      } else {
        pagenumber = pagenumber + 1;
      }
    }
    return matchedRelease;    
  }

  // Process the latest release
  const latestRelease = await octokit.rest.repos.getLatestRelease({
    owner,
    repo,
  });
  const releaseProcessed = await processRelease(latestRelease.data);
  const releaseInfo = releaseProcessed.releaseInfo;
  if (releaseInfo.assets === undefined || releaseInfo.assets.length === 0) {
    throw new Error("Error generating downloads - an empty release was detected.");
  }


  // Process the latest pre-release
  console.log("Starting prelease");
  const prerelease = await getPrerelease();
  const prereleaseProcessed = await processRelease(prerelease);
  const prereleaseInfo = prereleaseProcessed.releaseInfo;
  if (prereleaseInfo.assets === undefined || prereleaseInfo.assets.length === 0) {
    throw new Error("Error generating downloads - an empty pre-release was detected.");
  }

  // Note the prerelease data as a test
  console.log({ releaseInfo, prereleaseInfo });

  core.exportVariable("LATEST_RELEASE", releaseInfo.version);
  core.exportVariable("LATEST_PRERELEASE", prereleaseInfo.version);
}

try {
  run().catch((error) => {
    core.setFailed(error.message);
  });
} catch (error) {
  core.setFailed(error.message);
}
