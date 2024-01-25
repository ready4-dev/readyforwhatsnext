---
title: Installing readyforwhatsnext model modules
linkTitle: "Installation"
author: Matthew Hamilton
date: "2024-01-25"
description: To implement a modelling analysis with readyforwhatsnext you need to install model module R libraries.
slug: Modules
weight: 3
categories: 
- Documentation
tags: 
- Model
- Model - modules
- Software
- Software - libraries
- Software - libraries (installation)
output: hugodown::md_document
rmd_hash: 0c831052bae85774

---

## Before you install

If you plan on using existing readyforwhatsnext modules for a modelling project, you can review [currently available module libraries](/docs/model/modules/finding/libraries/), to identify which libraries are relevant to your project.

**However, please note that no readyforwhatsnext module library is yet available as a \[production release\](<https://www.ready4-dev.com/docs/software/status/production-releases/>. You should therefore understand the limitations of using readyforwhatsnext model software [development releases](https://www.ready4-dev.com/docs/software/status/development-releases/) before you make the decision to install this software.**

## Installation

readyforwhatsnext module libraries are currently only available as development releases, so you will need to use a tool like [devtools](https://devtools.r-lib.org) to assist with installing readyforwhatsnext R packages directly from [our GitHub organisation](https://github.com/ready4-dev). If you do not have devtools on your machine you can install it with the following command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>"devtools"</span><span class='o'>)</span></span></code></pre>

</div>

The command to install each readyforwhatsnext module takes the following format.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://remotes.r-lib.org/reference/install_github.html'>install_github</a></span><span class='o'>(</span><span class='s'>"ready4-dev/PACKAGE_NAME"</span><span class='o'>)</span></span></code></pre>

</div>

For example, if you are planning to predict health utility using some of the mapping algorithms that we have previously developed, you can install the [youthu](https://ready4-dev.github.io/youthu/) library with the following command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://remotes.r-lib.org/reference/install_github.html'>install_github</a></span><span class='o'>(</span><span class='s'>"ready4-dev/youthu"</span><span class='o'>)</span></span></code></pre>

</div>

## Configuration

A small number of readyforwhatsnext modules require that you configure some of the dependencies installed with them before they can be used. In particular:

-   if you are using modules from the [TTU](https://ready4-dev.github.io/TTU/) package to undertake a utility mapping study, you will need to have both installed and configured the cmdstanr R package as per the instructions on [that package's documentation website](https://mc-stan.org/cmdstanr/); and

-   if you are using the [mychoice](https://ready4-dev.github.io/mychoice/) package to undertake a discrete choice experiment study and are using a Mac, you need to ensure that you have a Fortran compiler installed. Some relevant advice on this: <https://mac.r-project.org/tools/> .

## Try it out!

Before you apply readyforwhatsnext modules to your own project, you should make sure you can run some or all of the example code included in relevant library vignette articles. The package website URL takes the form of `https://ready4-dev.github.io/PACKAGE_NAME/articles/` (e.g. the vignettes for the youthvars package are available at <https://ready4-dev.github.io/youthvars/articles/>).

