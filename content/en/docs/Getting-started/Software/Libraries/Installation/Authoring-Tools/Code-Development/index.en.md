---
title: Installing tools for authoring computational models
linkTitle: "Models"
author: Matthew Hamilton
date: "2023-01-09"
description: Instructions for installing the ready4class, ready4fun and ready4pack libraries.
weight: 1
categories: 
- Documentation
tags: 
- Framework
- Framework - authoring tools
- Framework - authoring tools (modules)
- Software
- Software - libraries
- Software - libraries (installation)
- Software - libraries (ready4class)
- Software - libraries (ready4fun)
- Software - libraries (ready4pack)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: eeb0b48a429fc491

---

## Before you install

If you are a [coder](/docs/getting-started/users/coder/) planning on using ready4 to author computational models, then you may wish to install the [ready4class](https://ready4-dev.github.io/ready4class/), [ready4fun](https://ready4-dev.github.io/ready4fun/) and [ready4pack](https://ready4-dev.github.io/ready4pack/) libraries.

**However, please note that none of these libraries are yet available as a [production release](/docs/getting-started/software/status/production-releases/). You should therefore understand the limitations of using ready4 software [development releases](/docs/getting-started/software/status/development-releases/) before you make the decision to install this software.** Although we use these authoring tools intensively to help us write highly standardised model modules, we feel that these tools are only likely to be helpful to others once much more comprehensive documentation and training resources become available. Without this training and support, these packages are unlikely to appear to be very user-friendly. Furthermore, the initial burden of complying with house-style, file-naming and directory structure requirements of these packages is only likely to be worthwhile if you plan on developing multiple ready4 module libraries. If you still think these tools could be useful to you, consider contacting us first to discuss what additional information may be most helpful to you.

## Installation

As ready4class and ready4fun are bundled as [dependencies](/docs/getting-started/software/libraries/dependencies/) of ready4pack, you can install all three from [our GitHub organisation](https://github.com/ready4-dev) using one command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://remotes.r-lib.org/reference/install_github.html'>install_github</a></span><span class='o'>(</span><span class='s'>"ready4-dev/ready4pack"</span><span class='o'>)</span></span></code></pre>

</div>

## Configuration

To use these computational model authoring tools, you will need to have set-up and appropriately configured your own accounts in:

-   [GitHub](https://github.com) (you will need write permissions to a GitHub organisation and to then enable GitHub actions and GitHub pages support for the repositories you create in that organisation);
-   [Zenodo](https://zenodo.org) (you will need to have linked each GitHub repository used for your ready4 projects to your Zenodo account); and
-   [Codecov](https://about.codecov.io) (linked to your GitHub organisation).

The machine onto which you install ready4pack will also need to be securely storing your GitHub credentials (i.e. the value for the GITHUB_PAT token).

## Try it out!

It should be noted that the development workflow supported by our computational model authoring tools is not yet well documented. We don't recommend undertaking R package development with these tools until this has been rectified. However, if you still want to try these tools out, the best place to start is review the examples in the [ready4class](https://ready4-dev.github.io/ready4class/articles/V_01.html), [ready4fun](https://ready4-dev.github.io/ready4fun/articles/V_01.html) and [ready4pack](https://ready4-dev.github.io/ready4pack/articles/V_01.html) vignettes.

