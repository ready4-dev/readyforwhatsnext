---
title: "Share data via online repositories"
linkTitle: "Share data"
date: "2022-12-24"
description: "  The retrieval and dissemination of data from online data repositories is an essential enabler of open source modelling. This tutorial describes how a module from the ready4use R package can help you to manage this process."
weight: 91
categories: 
- Documentation
tags: 
- Data
- Data - management
- Framework
- Framework - authoring-tools
- Framework - authoring-tools (datasets)
- Software
- Software - libraries
- Software - libraries (ready4use)
output: hugodown::md_document
rmd_hash: 46f9f142fe10e9b3

---

{{% pageinfo %}} This below section renders a vignette article from the ready4use library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4use/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4use/blob/master/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4use/edit/master/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

Note: **This vignette is illustrated with fake data**. The dataset explored in this example should not be used to inform decision-making.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span></code></pre>

</div>

ready4use includes a number of tools for sharing data used in conjunction with the [ready4 open source model of youth mental health systems](https://www.ready4-dev.com).

## Identify data to be shared

To illustrate how to share data using `ready4use` classes and methods, we will first need some data to publish. In this example, we are going to share `X`, a `Ready4useDyad` [(a data structure explained in another vignette)](https://ready4-dev.github.io/ready4use/V_02.html) that we can create using [data ingested from an online repository](https://ready4-dev.github.io/ready4use/V_03.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>objects_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>,</span>
<span>                                    dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/HJXYKQ"</span>,</span>
<span>                                    dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span>,</span>
<span>                                    gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/ready4"</span>,</span>
<span>                                    gh_tag_1L_chr <span class='o'>=</span> <span class='s'>"Documentation_0.0"</span><span class='o'>)</span>,</span>
<span>                     fls_to_ingest_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"ymh_clinical_tb"</span>,<span class='s'>"ymh_clinical_dict_r3"</span><span class='o'>)</span>,</span>
<span>                     metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useDyad-class.html'>Ready4useDyad</a></span><span class='o'>(</span>ds_tb <span class='o'>=</span> <span class='nv'>objects_ls</span><span class='o'>$</span><span class='nv'>ymh_clinical_tb</span>,</span>
<span>                   dictionary_r3 <span class='o'>=</span> <span class='nv'>objects_ls</span><span class='o'>$</span><span class='nv'>ymh_clinical_dict_r3</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

## Share data

We now specify where we plan to publish `X` in `Y`, a `Ready4useRepos` object ([described in another vignette](https://ready4-dev.github.io/ready4use/V_03.html)). Note, you must have write permissions to the repositories you specify in this step. The values entered in this example (the <https://doi.org/10.7910/DVN/W95KED> dataset from the [fakes](https://dataverse.harvard.edu/dataverse/fakes) dataverse will not work for you).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>, <span class='c'># Replace with values for a dataverse &amp; dataset for which</span></span>
<span>                    dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/W95KED"</span>, <span class='c'>#  you have write permissions.</span></span>
<span>                    dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span></span></code></pre>

</div>

We can now upload `X` to our preferred data repository using the `share` method. By default, if more than one data repository was specified in `Y`, then the dataverse repository will be preferred when sharing. We can overwrite this default by passing either "prefer_gh" or "all" values to the `type_1L_chr` argument. The Ready4useDyad object is now available for download at <https://doi.org/10.7910/DVN/W95KED>.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/share-methods.html'>share</a></span><span class='o'>(</span><span class='nv'>Y</span>,</span>
<span>           obj_to_share_xx <span class='o'>=</span> <span class='nv'>X</span>,</span>
<span>           fl_nm_1L_chr <span class='o'>=</span> <span class='s'>"ymh_clinical_dyad_r4"</span>,</span>
<span>           description_1L_chr <span class='o'>=</span> <span class='s'>"An example of a Ready4useDyad - a dataset (clinical youth mental health, AQoL-6D) and data dictionary pair. Note this example uses fake data."</span><span class='o'>)</span></span></code></pre>

</div>

