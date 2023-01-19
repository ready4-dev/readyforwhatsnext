---
title: "Contribute code"
linkTitle: "Code"
weight: 110
tags:
- Project
- Project - contributions
- Project - contributions (types)
categories:
- Documentation
description: >
  Help improve the reliability, functionality and ease of use of ready4 software.
---

## What? 
Test, improve or extend [our software](/docs/getting-started/software/). This is essential to us achieving our following priority goals:

1. [Launching the ready4 MVP systems model](/docs/contribution-guidelines/priorities/launch/).

2. [Maintaining ready4](/docs/contribution-guidelines/priorities/curate/).

3. [Applying ready4](/docs/contribution-guidelines/priorities/apply/).

4. [Growing a ready4 community](/docs/contribution-guidelines/priorities/support/).


## Who?
To make a code contribution, you need to be a [coder](/docs/getting-started/users/coder/) familiar with R, R Markdown and git. You will also need a GitHub account. For many types of contribution, you will also need to use our [framework](/docs/framework/)'s module [authoring tools](/docs/model/authoring-modules/). We have yet to adequately document and refine these tools to make them easier for third parties to use ([we plan to do this](/docs/contribution-guidelines/priorities/support/)), so if you are interested in making anything other than a relatively minor code edit, we recommend that you first [contact our project lead](https://mph-economist.netlify.app/#contact) to discuss your idea. 

As a contributor to ready4, you will also be expected to adhere to the [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](../../code-of-conduct/)

## How ?
The process for making a code contribution, broadly conforms to the steps we itemise below, that we have minimally adapted from [this template](https://opensource.com/life/16/3/contributor-guidelines-template-and-tips). If you need further help to make a contribution, you can contact the ready4 project lead directly.

1. Find an issue that you are interested in addressing or a feature that you would like to add. Ideally consider how your planned contribution matches our [current priorities](/docs/contribution-guidelines/priorities/).

2. Fork the repository associated with the issue from [our GitHub organization](https://github.com/ready4-dev) to your local GitHub organization. This means that you will have a copy of the repository under your-GitHub-username/repository-name.

3. Clone the repository to your local machine using:

<div class="highlight">

<pre class='chroma'><code class='language-Shell' data-lang='Shell'><span><span class='nf'>git clone https://github.com/github-username/repository-name.git</span></span></code></pre>

</div>

4. Create a new branch for your fix using:

<div class="highlight">

<pre class='chroma'><code class='language-Shell' data-lang='Shell'><span><span class='nf'>git checkout -b branch-name-here</span></span></code></pre>

</div>

5. Make the appropriate changes for the issue you are trying to address or the feature that you want to add.

6. To add the file contents of the changed files to the "snapshot" git uses to manage the state of the project, also known as the index, use:

<div class="highlight">

<pre class='chroma'><code class='language-Shell' data-lang='Shell'><span><span class='nf'>git add insert-paths-of-changed-files-here</span></span></code></pre>

</div>

7. To store the contents of the index with a descriptive message, use:


<div class="highlight">

<pre class='chroma'><code class='language-Shell' data-lang='Shell'><span><span class='nf'>git commit -m "Insert a short message of the changes made here"</span></span></code></pre>

</div>

8. Push the changes to the remote repository using:

<div class="highlight">

<pre class='chroma'><code class='language-Shell' data-lang='Shell'><span><span class='nf'>git push origin branch-name-here</span></span></code></pre>

</div>

9. Submit a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) to the upstream repository.

10. Title the pull request with a short description of the changes made and the issue or bug number associated with your change. For example, you can title an issue like so "Added more log outputting to resolve #4352".

11. In the description of the pull request, explain the changes that you made, any issues you think exist with the pull request you made, and any questions you have for the maintainer. It's OK if your pull request is not perfect (no pull request is), the reviewer will be able to help you fix any problems and improve it!

12. Wait for the pull request to be reviewed by a maintainer.

13. Make changes to the pull request if the reviewing maintainer recommends them.

14. Celebrate your success after your pull request is merged!



