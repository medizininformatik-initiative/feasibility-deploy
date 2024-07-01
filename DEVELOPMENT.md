# Development

## Release Checklist

* create a release branch called `release/v<version>` like `release/v1.1.0`
* update the CHANGELOG based on the milestone
* create a commit with the title `Release v<version>`
* create a PR from the release branch into the main branch
* merge that PR (after proper review)
* create and push a tag called `v<version>` like `v1.1.0` on the main branch at the merge commit
* merge the `main` branch back into develop
* create release notes on GitHub
* delete the release-branch and the new-dev branch after they have been successfully merged