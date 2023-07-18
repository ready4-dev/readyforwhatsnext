---
title: "Develop choice models"
linkTitle: "Predict choice"
date: "2023-07-11"
description: "Using tools (soon to be formalised into ready4 framework modules) from the mychoice R package, it is possible to develop choice models from responses to a discrete choice experiment survey."
weight: 97
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
rmd_hash: a4c0911fb56cd680

---

{{% pageinfo %}} This below section renders a vignette article from the mychoice library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthu/articles/mychoice.html)
-   [view the source file](https://github.com/ready4-dev/youthu/blob/main/vignettes/mychoice.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthu/edit/main/vignettes/mychoice.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/mychoice/'>mychoice</a></span><span class='o'>)</span></span>
<span><span class='c'>#&gt; The legacy packages maptools, rgdal, and rgeos, underpinning the sp package,</span></span>
<span><span class='c'>#&gt; which was just loaded, will retire in October 2023.</span></span>
<span><span class='c'>#&gt; Please refer to R-spatial evolution reports for details, especially</span></span>
<span><span class='c'>#&gt; https://r-spatial.org/r/2023/05/15/evolution4.html.</span></span>
<span><span class='c'>#&gt; It may be desirable to make the sf package available;</span></span>
<span><span class='c'>#&gt; package maintainers should consider adding sf to Suggests:.</span></span>
<span><span class='c'>#&gt; The sp package is now running under evolution status 2</span></span>
<span><span class='c'>#&gt;      (status 2 uses the sf package in place of rgdal)</span></span>
<span></span></code></pre>

</div>

The tools in mychoice are designed to make it easier to develop and use choice models with [ready4 - an open source health economic model of the systems shaping mental health and wellbeing in young people](https://www.ready4-dev.com).

This development version of the mychoice package has been made available as part of the process of testing and documenting the package.

Currently there are no vignettes available. However, examples of the application of mychoice functions to a real world discrete choice experiment are in programs available at <https://doi.org/10.5281/zenodo.6626256> (design of a discrete choice experiment survey) and <https://doi.org/10.5281/zenodo.7223286> (analysis of discrete choice experiment survey responses). PDF versions of each program, along with the artefacts produced by each are available in the online dataset at <https://doi.org/10.7910/DVN/VGPIPS>.

