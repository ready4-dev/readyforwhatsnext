---
title: "Develop choice models"
linkTitle: "Predict choice"
date: "2026-01-29"
description: "Using tools (soon to be formalised into ready4 framework modules) from the mychoice R package, it is possible to develop choice models from responses to a discrete choice experiment survey."
weight: 97
toc_hide: true
hide_summary: true
categories: 
- Documentation
tags: 
- Analyses
- Analyses - tutorials
- Model
- Model - modules
- Model - modules (people)
- Software
- Software - executable
- Software - executable (programs)
- Software - libraries
- Software - libraries (mychoice)
- Status
- Status - development
- Use
- Use - choice modelling
output: hugodown::md_document
rmd_hash: ffeb954fb82ab1c5

---

{{% pageinfo %}} This below section renders a vignette article from the mychoice library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthu/articles/mychoice.html)
-   [view the source file](https://github.com/ready4-dev/youthu/blob/main/vignettes/mychoice.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthu/edit/main/vignettes/mychoice.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/mychoice/'>mychoice</a></span><span class='o'>)</span></span></code></pre>

</div>

The tools in mychoice are designed to make it easier to develop and use choice models with the [ready4 youth mental health economic model](https://www.ready4-dev.com/docs/model/) (or any other model developed with the [ready4 framework](https://www.ready4-dev.com)).

This development version of the mychoice package has been made available as part of the process of testing and documenting the package.

Currently there are no vignettes available. However, examples of the application of mychoice functions to a real world discrete choice experiment are in programs available at <https://doi.org/10.5281/zenodo.6626256> (design of a discrete choice experiment survey) and <https://doi.org/10.5281/zenodo.7223286> (analysis of discrete choice experiment survey responses). PDF versions of each program, along with the artefacts produced by each are available in the online dataset at <https://doi.org/10.7910/DVN/VGPIPS>.

