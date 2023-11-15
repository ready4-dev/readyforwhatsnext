---
title: Installing tools for authoring reproducible analyses
linkTitle: "Analyses"
author: Matthew Hamilton
date: "2023-11-15"
description: Instructions for installing the ready4show library.
weight: 3
categories: 
- Documentation
tags: 
- Framework
- Framework - authoring tools
- Software
- Software - libraries
- Software - libraries (installation)
- Software - libraries (ready4show)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: bd14f21b02315e45

---

## Before you install

If you are a [coder](/docs/getting-started/users/coder/) or [modeller](/docs/getting-started/users/modeller) planning to implement a reproducible analysis with ready4, you will need to install the [ready4show](https://ready4-dev.github.io/ready4show/) library.

**However, please note that ready4show is not yet available as a [production release](/docs/software/status/production-releases/). You should therefore understand the limitations of using ready4 software [development releases](/docs/software/status/development-releases/) before you make the decision to install this software.**

If you have installed other ready4 libraries, then ready4show may have already been installed as a [dependency](/docs/software/libraries/dependencies/). If you can run the following command without producing an error message, then you already have it.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/find.package.html'>find.package</a></span><span class='o'>(</span><span class='s'>"ready4show"</span><span class='o'>)</span></span></code></pre>

</div>

## Installation

The ready4show library can be installed directly from its [GitHub repository](https://github.com/ready4-dev/ready4show).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://remotes.r-lib.org/reference/install_github.html'>install_github</a></span><span class='o'>(</span><span class='s'>"ready4-dev/ready4show"</span><span class='o'>)</span></span></code></pre>

</div>

## Try it out!

Before you apply ready4show tools to your own project, you should make sure you can run some or all of the example code included in the [package vignettes](https://ready4-dev.github.io/ready4show/articles/).

