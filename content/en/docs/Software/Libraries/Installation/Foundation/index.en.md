---
title: Installing the ready4 framework foundation library
linkTitle: "Foundation"
author: Matthew Hamilton
date: "2023-11-15"
description: The ready4 framework foundation is the first ready4 library you should install.
slug: Foundation
weight: 1
categories: 
- Documentation
tags: 
- Framework
- Framework - foundation
- Software
- Software - libraries
- Software - libraries (installation)
output: hugodown::md_document
rmd_hash: 3985aef67523ff0d

---

## Before you install

If you plan to use ready4 for any purpose, you will need to install the [ready4 foundation library](https://ready4-dev.github.io/ready4/).

**However, please note that the ready4 library is not yet available as a [production release](/docs/software/status/production-releases/). You should therefore understand the limitations of using ready4 software [development releases](/docs/software/status/development-releases/) before you make the decision to install this software.**

As all software in the ready4 suite [depends](/docs/software/libraries/dependencies/) on the ready4 library, so in most cases you do not need to install this library directly (it will come bundled with whatever other ready4 suite software you install).

If you can run the following command without producing an error message, then you already have it.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/find.package.html'>find.package</a></span><span class='o'>(</span><span class='s'>"ready4"</span><span class='o'>)</span></span></code></pre>

</div>

## Installation

You can install the ready4 library directly from its [GitHub repository](https://github.com/ready4-dev/ready4).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://remotes.r-lib.org/reference/install_github.html'>install_github</a></span><span class='o'>(</span><span class='s'>"ready4-dev/ready4"</span><span class='o'>)</span></span></code></pre>

</div>

## Try it out!

Before you apply ready4 tools to your own project, you should make sure you can run some or all of the example code included in the [package vignettes](https://ready4-dev.github.io/ready4/articles/).

