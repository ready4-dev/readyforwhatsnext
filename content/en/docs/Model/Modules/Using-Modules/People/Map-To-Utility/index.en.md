---
title: "Implement a utility mapping study"
linkTitle: "Map to utility"
date: "2022-12-24"
description: "Using modules from the TTU R package, it is possible to implement a fully reproducible utility mapping study. This tutorial illustrates the main steps using a hypothetical AQoL-6D utility mapping study."
weight: 95
categories: 
- Documentation
tags: 
- Analyses
- Analyses - tutorials
- Model
- Model - modules
- Model - modules (people)
- Reporting
- Software
- Software - executable
- Software - executable (programs)
- Software - libraries
- Software - libraries (specific)
- Status
- Status - development
- Use
- Use - utility mapping
output: hugodown::md_document
rmd_hash: ab6ef0bce55c99d0
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the TTU library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/TTU/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/TTU/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/TTU/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

Note: **This vignette uses fake data** - it is for illustrative purposes only and should not be used to inform decision making.

## Motivation

Youth mental health services do not typically collect health utility data from their clients, which makes it more difficult to place an economic values on outcomes attained in these services. One strategy for addressing this gap is to use data from similar samples of young people that contain both health utility and the types of outcome measures that are collected in clinical services. The TTU package provides a toolkit for conducting and reporting a utility mapping (or Transfer to Utility) study.

## Implementation

TTU has been developed for use with the [ready4 model](https://ready4-dev.github.io/ready4/) and combines and extends multiple types of [ready4 modules](https://ready4-dev.github.io/ready4/articles/V_01.html):

-   Modules for labeling, validating and summarising youth mental health datasets from the [youthvars](https://ready4-dev.github.io/youthvars/) package;
-   Modules for scoring health utility from the [scorz](https://ready4-dev.github.io/scorz/) package;
-   Modules for specifying and testing statistical models from the [specific](https://ready4-dev.github.io/specific/) package;
-   Modules for generating reports from the [ready4show](https://ready4-dev.github.io/ready4show/) package; and
-   Modules for sharing data via online data repositories from the [ready4use](https://ready4-dev.github.io/ready4use/) package.

Additionally, TTU relies on two RMarkdown programs:

-   ttu_mdl_ctlg: Generate a Template Utility Mapping (Transfer to Utility) Model Catalogue (<https://doi.org/10.5281/zenodo.5936870>)
-   ttu_lng_ss: Create a Draft Scientific Manuscript For A Utility Mapping Study (<https://doi.org/10.5281/zenodo.5976987>)

## Workflow

### Background and citation

The following workflow illustrates (**using fake data**) the same steps we used in a real world study, a summary of which is available at <https://doi.org/10.1101/2021.07.07.21260129>). Citation information for that study is:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>@article {Hamilton2021.07.07.21260129,
    author = {Hamilton, Matthew P and Gao, Caroline X and Filia, Kate M and Menssink, Jana M and Sharmin, Sonia and Telford, Nic and Herrman, Helen and Hickie, Ian B and Mihalopoulos, Cathrine and Rickwood, Debra J and McGorry, Patrick D and Cotton, Sue M},
    title = {Predicting Quality Adjusted Life Years in young people attending primary mental health services},
    elocation-id = {2021.07.07.21260129},
    year = {2021},
    doi = {10.1101/2021.07.07.21260129},
    publisher = {Cold Spring Harbor Laboratory Press},
    URL = {https://www.medrxiv.org/content/early/2021/07/12/2021.07.07.21260129},
    eprint = {https://www.medrxiv.org/content/early/2021/07/12/2021.07.07.21260129.full.pdf},
    journal = {medRxiv}
}
</code></pre>

</div>

The program applied in that study, which this workflow closely resembles is available at <https://doi.org/10.5281/zenodo.6116077> and can be cited as follows:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>@software{hamilton_matthew_2022_6212704,
  author       = {Hamilton, Matthew and
                  Gao, Caroline},
  title        = {{Complete study program to reproduce all steps from 
                   data ingest through to results dissemination for a
                   study to map mental health measures to AQoL-6D
                   health utility}},
  month        = feb,
  year         = 2022,
  note         = {{Matthew Hamilton and Caroline Gao  (2022). 
                   Complete study program to reproduce all steps from
                   data ingest through to results dissemination for a
                   study to map mental health measures to AQoL-6D
                   health utility. Zenodo.
                   https://doi.org/10.5281/zenodo.6116077. Version
                   0.0.9.3}},
  publisher    = {Zenodo},
  version      = {0.0.9.3},
  doi          = {10.5281/zenodo.6212704},
  url          = {https://doi.org/10.5281/zenodo.6212704}
}
</code></pre>

</div>

### Load required packages

We begin by loading our required packages.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/youthvars/'>youthvars</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/scorz/'>scorz</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/TTU/'>TTU</a></span><span class='o'>)</span></span></code></pre>

</div>

### Add dataset metadata

We use the Ready4useDyad and Ready4useRepos modules to [retrieve and ingest](https://ready4-dev.github.io/ready4use/articles/V_01.html) and to then [pair a dataset and its data dictionary](_https://ready4-dev.github.io/ready4use/articles/V_02.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useDyad-class.html'>Ready4useDyad</a></span><span class='o'>(</span>ds_tb <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>,</span>
<span>                                          dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/HJXYKQ"</span>,</span>
<span>                                          dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                     <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"ymh_clinical_tb"</span><span class='o'>)</span>,</span>
<span>                            metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                     <span class='nf'>youthvars</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/transform_raw_ds_for_analysis.html'>transform_raw_ds_for_analysis</a></span><span class='o'>(</span><span class='o'>)</span>,</span>
<span>                   dictionary_r3 <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"TTU"</span>, </span>
<span>                                                  dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/DKDIB0"</span>, </span>
<span>                                                  dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                     <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"dictionary_r3"</span><span class='o'>)</span>,</span>
<span>                            metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span>type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span></span></code></pre>

</div>

We use the YouthvarsSeries module to [supply metadata about out a longitudinal dataset vignette](https://ready4-dev.github.io/youthvars/articles/V_02.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/YouthvarsSeries-class.html'>YouthvarsSeries</a></span><span class='o'>(</span>a_Ready4useDyad <span class='o'>=</span> <span class='nv'>A</span>,</span>
<span>                     id_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"fkClientID"</span>,</span>
<span>                     timepoint_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"round"</span>,</span>
<span>                     timepoint_vals_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/levels.html'>levels</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>,</span>
<span>                                                             <span class='s'>"ds_tb"</span><span class='o'>)</span><span class='o'>$</span><span class='nv'>round</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Score health utility

We next use the ScorzAqol6Adol module to [score adolescent AQoL-6D health utility](https://ready4-dev.github.io/scorz/articles/V_01.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/TTU/reference/TTUProject-class.html'>TTUProject</a></span><span class='o'>(</span>a_ScorzProfile <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/scorz/reference/ScorzAqol6Adol-class.html'>ScorzAqol6Adol</a></span><span class='o'>(</span>a_YouthvarsProfile <span class='o'>=</span> <span class='nv'>A</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"a_ScorzProfile"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining, by = c("fkClientID", "match_var_chr")</span></span></code></pre>

</div>

### Evaluate candidate models

Over the next few steps we will use modules from the specific package to to [specify and assess a number of candidate utility mapping models](https://ready4-dev.github.io/specific/articles/V_01.html).

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"b_SpecificParameters"</span>, <span class='nf'><a href='https://ready4-dev.github.io/specific/reference/SpecificConverter-class.html'>SpecificConverter</a></span><span class='o'>(</span>a_ScorzProfile <span class='o'>=</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>a_ScorzProfile</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/metamorphose-methods.html'>metamorphose</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='s'>"b_SpecificParameters"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"b_SpecificParameters@predictors_lup"</span>, <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"TTU"</span>, </span>
<span>                                                                        dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/DKDIB0"</span>, </span>
<span>                                                                        dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"predictors_r3"</span><span class='o'>)</span>,</span>
<span>                        metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

We can inspect the metadata on candidate predictors that we have just ingested.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"b_SpecificParameters@predictors_lup"</span>,</span>
<span>         scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
Description
</th>
<th style="text-align:right;">
Minimum
</th>
<th style="text-align:right;">
Maximum
</th>
<th style="text-align:right;">
Class
</th>
<th style="text-align:right;">
Increment
</th>
<th style="text-align:right;">
Function
</th>
<th style="text-align:left;">
Scaling
</th>
<th style="text-align:right;">
Covariate
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
BADS
</td>
<td style="text-align:right;">
BADS total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
150
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_bads
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7
</td>
<td style="text-align:right;">
GAD7 total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_gad7
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
K6
</td>
<td style="text-align:right;">
K6 total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_k6
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
OASIS
</td>
<td style="text-align:right;">
OASIS total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_oasis
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
PHQ9
</td>
<td style="text-align:right;">
PHQ9 total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_phq9
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SCARED
</td>
<td style="text-align:right;">
SCARED total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
82
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_scared
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SOFAS
</td>
<td style="text-align:right;">
SOFAS total score
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
youthvars::youthvars_sofas
</td>
<td style="text-align:left;">
0.01
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; " colspan="100%">
<sup></sup>
</td>
</tr>
</tfoot>
</table>

</div>

</div>

We add additional metadata about variables in our dataset that will be used in exploratory modelling.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"b_SpecificParameters@depnt_var_min_max_dbl"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.03</span>,<span class='m'>1</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='c'># Inherit From TTUAqolAdol</span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"b_SpecificParameters@candidate_predrs_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"BADS"</span>,<span class='s'>"GAD7"</span>, <span class='s'>"K6"</span>, <span class='s'>"OASIS"</span>, <span class='s'>"PHQ9"</span>, <span class='s'>"SCARED"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"b_SpecificParameters@candidate_covars_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_sex_birth_s"</span>, <span class='s'>"d_age"</span>,  <span class='s'>"d_sexual_ori_s"</span>, </span>
<span>                                                           <span class='s'>"d_studying_working"</span>, <span class='s'>"c_p_diag_s"</span>, <span class='s'>"c_clinical_staging_s"</span>,</span>
<span>                                                           <span class='s'>"SOFAS"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"b_SpecificParameters@descv_var_nms_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_age"</span>,<span class='s'>"Gender"</span>,<span class='s'>"d_relation_s"</span>, <span class='s'>"d_sexual_ori_s"</span>, </span>
<span>                                                        <span class='s'>"Region"</span>, <span class='s'>"d_studying_working"</span>, <span class='s'>"c_p_diag_s"</span>, </span>
<span>                                                        <span class='s'>"c_clinical_staging_s"</span>,<span class='s'>"SOFAS"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"b_SpecificParameters@msrmnt_date_var_nm_1L_chr"</span>, <span class='s'>"d_interview_date"</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"b_SpecificParameters@fake_1L_lgl"</span>, <span class='kc'>T</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>, <span class='nf'><a href='https://ready4-dev.github.io/specific/reference/SpecificModels-class.html'>SpecificModels</a></span><span class='o'>(</span>a_YouthvarsProfile <span class='o'>=</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>a_ScorzProfile</span><span class='o'>@</span><span class='nv'>a_YouthvarsProfile</span>,</span>
<span>                                                      b_SpecificParameters <span class='o'>=</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>b_SpecificParameters</span>,</span>
<span>                                                      paths_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/tempfile.html'>tempdir</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratifySlot-methods.html'>ratifySlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>, </span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"workspace"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We now generate tables and charts that describe our dataset. These are saved in a sub-directory of our output data directory, a copy of which is [available for download](https://github.com/ready4-dev/TTU/releases/download/Documentation_0.0/_Descriptives.zip). One of the plots is also reproduced here.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"descriptives"</span>,</span>
<span>                          digits_1L_int <span class='o'>=</span> <span class='m'>3L</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>
<img src="figs/unnamed-chunk-17-1.png" width="700px" style="display: block; margin: auto;" />

</div>

We next compare the performance of different model types. This step saves model objects and plots to a sub-directory of our output directory, a copy of which is [available for download](https://github.com/ready4-dev/TTU/releases/download/Documentation_0.0/B_Candidate_Predrs_Cmprsn.zip).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html'>investigateSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>                               depnt_var_max_val_1L_dbl <span class='o'>=</span> <span class='m'>0.99</span>,</span>
<span>                               session_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/utils/sessionInfo.html'>sessionInfo</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

After inspecting the output of the previous command, we can now specify the preferred model types to use from this point onwards.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span>,</span>
<span>                     new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"GLM_GSN_LOG"</span>, <span class='s'>"OLS_CLL"</span><span class='o'>)</span>,</span>
<span>                     type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>                     what_1L_chr <span class='o'>=</span> <span class='s'>"prefd_mdls"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

Next we assess multiple versions of our preferred model type - one single predictor model for each of our candidate predictors and the same models with candidate covariates added. A number of model/plot objects saved to a sub-directory of our output directory, a copy of which is [available for download](https://github.com/ready4-dev/TTU/releases/download/Documentation_0.0/C_Predrs_Sngl_Mdl_Cmprsn.zip).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html'>investigateSlot</a></span><span class='o'>(</span><span class='nv'>A</span>,<span class='s'>"c_SpecificProject"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

After reviewing the output of the previous step, we specify the covariates we wish to add to the models.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span>,</span>
<span>                     new_val_xx <span class='o'>=</span> <span class='s'>"SOFAS"</span>,</span>
<span>                     type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>                     what_1L_chr <span class='o'>=</span> <span class='s'>"prefd_covars"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We now assess the multivariate models. More model/plot objects are saved to a sub-directory of our output directory, a copy of which is [available for download](https://github.com/ready4-dev/TTU/releases/download/Documentation_0.0/E_Predrs_W_Covars_Sngl_Mdl_Cmprsn.zip).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html'>investigateSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We next reformulate the models we finalised in the previous step so that they are suitable for modelling longitudinal change.

For our primary analysis, we use the longitudinal formulation of the models we previously selected. A series of large model files are written to the local output data directory.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html'>investigateSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

For our secondary analyses, we specify alternative combinations of predictors and covariates.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html'>investigateSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>                               scndry_anlys_params_ls <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/specific/reference/make_scndry_anlys_params.html'>make_scndry_anlys_params</a></span><span class='o'>(</span>candidate_predrs_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"SOFAS"</span><span class='o'>)</span>,</span>
<span>                                                                                 candidate_covar_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_sex_birth_s"</span>, </span>
<span>                                                                                                             <span class='s'>"d_age"</span>, </span>
<span>                                                                                                             <span class='s'>"d_sexual_ori_s"</span>,</span>
<span>                                                                                                             <span class='s'>"d_studying_working"</span><span class='o'>)</span>,</span>
<span>                                                                                 prefd_covars_chr <span class='o'>=</span> <span class='kc'>NA_character_</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                                 <span class='nf'><a href='https://ready4-dev.github.io/specific/reference/make_scndry_anlys_params.html'>make_scndry_anlys_params</a></span><span class='o'>(</span>candidate_predrs_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"SCARED"</span>,<span class='s'>"OASIS"</span>,<span class='s'>"GAD7"</span><span class='o'>)</span>,</span>
<span>                                                          candidate_covar_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ9"</span>, <span class='s'>"SOFAS"</span>, </span>
<span>                                                                                      <span class='s'>"d_sex_birth_s"</span>, </span>
<span>                                                                                      <span class='s'>"d_age"</span>, </span>
<span>                                                                                      <span class='s'>"d_sexual_ori_s"</span>,</span>
<span>                                                                                      <span class='s'>"d_studying_working"</span><span class='o'>)</span>,</span>
<span>                                                          prefd_covars_chr <span class='o'>=</span> <span class='s'>"PHQ9"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Report and disseminate findings

#### Create shareable models

The model objects created and saved in our working directory by the preceding steps are not suitable for public dissemination. They are both too large in file size and, more importantly, include copies of our source dataset. We can overcome these limitations by creating shareable versions of the models. Two types of shareable version are created - copies of the original model objects in which fake data overwrites the original source data and summary tables of model coefficients.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorData-methods.html'>authorData</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

#### Specify study reporting metadata

We create a `TTUSynopsis` object that contains the fields necessary to render and share reports.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>,</span>
<span>               <span class='o'>&#123;</span></span>
<span>                 <span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/metamorphoseSlot-methods.html'>metamorphoseSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"c_SpecificProject"</span><span class='o'>)</span></span>
<span>                 <span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/TTU/reference/TTUSynopsis-class.html'>TTUSynopsis</a></span><span class='o'>(</span>a_Ready4showPaths <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>a_Ready4showPaths</span>,</span>
<span>                                  b_SpecificResults <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>b_SpecificResults</span>,</span>
<span>                                  c_SpecificParameters <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>c_SpecificParameters</span>,</span>
<span>                                  d_YouthvarsProfile <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>d_YouthvarsProfile</span>,</span>
<span>                                  rmd_fl_nms_ls <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>rmd_fl_nms_ls</span><span class='o'>)</span></span>
<span>                 <span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/TTU/reference/TTUReports-class.html'>TTUReports</a></span><span class='o'>(</span>a_TTUSynopsis <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>)</span></span>
<span>                 <span class='nv'>Y</span></span>
<span>                 <span class='o'>&#125;</span></span>
<span>               <span class='o'>)</span></span></code></pre>

</div>

We add metadata relevant to the reports that we will be generating to these fields. Note that the data we supply to the Ready4useRepos object below must relate to a repository to which we have write permissions (otherwise subsequent steps will fail).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"authors_r3"</span>, <span class='nf'>ready4show</span><span class='nf'>::</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/reference/authors_tb.html'>authors_tb</a></span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"institutes_r3"</span>, <span class='nf'>ready4show</span><span class='nf'>::</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/reference/institutes_tb.html'>institutes_tb</a></span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"digits_int"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>3L</span>,<span class='m'>3L</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"outp_formats_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PDF"</span>,<span class='s'>"PDF"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"title_1L_chr"</span>, <span class='s'>"A hypothetical utility mapping study using fake data"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"correspondences_r3"</span>, old_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ9"</span>, <span class='s'>"GAD7"</span><span class='o'>)</span>, new_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ-9"</span>, <span class='s'>"GAD-7"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"e_Ready4useRepos"</span>, <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>, </span>
<span>                                                              dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/D74QMP"</span>, </span>
<span>                                                              dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> </span>
<span></span></code></pre>

</div>

<div class="highlight">

</div>

#### Author model catalogues

We download a program for generating a catalogue of models and use it to summarising the models created under each study analysis (one primary and two secondary). The catalogues are saved locally.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"Catalogue"</span>, download_tmpl_1L_lgl <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span></span></code></pre>

</div>

#### Share model catalogue

We share the catalogues that we created, uploading a copy to our study online repository. To run this step you will need write permissions to the online repository.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/shareSlot-methods.html'>shareSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Report"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"Catalogue"</span><span class='o'>)</span> </span></code></pre>

</div>

#### Share models

We share tables of coefficients and other meta-data about the models we have created by posting them to the online repository. The object we create and share is designed to be used in conjunction with the `youthu` package to make it easier to make predictions with these models using new data. Again, you will need write permissions to the online repository.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/shareSlot-methods.html'>shareSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Models"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"ingredients"</span><span class='o'>)</span></span></code></pre>

</div>

#### Author manuscript

We add some content about the manuscript we wish to author.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"background_1L_chr"</span>, <span class='s'>"Quality Adjusted Life Years (QALYs) are often used in economic evaluations, yet utility weights for deriving them are rarely directly measured in mental health services."</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"coi_1L_chr"</span>, <span class='s'>"None declared"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"conclusion_1L_chr"</span>,<span class='s'>"Nothing should be concluded from this study as it is purely hypothetical."</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"ethics_1L_chr"</span>, <span class='s'>"The study was reviewed and granted approval by no-one."</span> <span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"funding_1L_chr"</span>, <span class='s'>"The study was funded by no-one."</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"interval_chr"</span>, <span class='s'>"three months"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"keywords_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"anxiety"</span>, <span class='s'>"AQoL"</span>,<span class='s'>"depression"</span>, <span class='s'>"psychological distress"</span>, <span class='s'>"QALYs"</span>, <span class='s'>"utility mapping"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"sample_desc_1L_chr"</span>, <span class='s'>"The study sample is fake data."</span><span class='o'>)</span> <span class='o'>)</span></span></code></pre>

</div>

We create a summary of results that can be interpreted by the program that authors the manuscript.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis@abstract_args_ls"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/manufactureSlot-methods.html'>manufactureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>,<span class='s'>"d_TTUReports@a_TTUSynopsis"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"abstract_args_ls"</span>,</span>
<span>                               depnt_var_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"AQoL-6D"</span>, <span class='s'>"Adolescent AQoL Six Dimension"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/enhanceSlot-methods.html'>enhanceSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports@a_TTUSynopsis"</span>, with_1L_chr <span class='o'>=</span> <span class='s'>"results_ls"</span>,</span>
<span>                 depnt_var_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"AQoL-6D"</span>, <span class='s'>"Adolescent AQoL Six Dimension"</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

We create and save the plots that will be used in the manuscript.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Plots"</span>,</span>
<span>           depnt_var_desc_1L_chr <span class='o'>=</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>d_TTUReports</span><span class='o'>@</span><span class='nv'>a_TTUSynopsis</span><span class='o'>@</span><span class='nv'>b_SpecificResults</span><span class='o'>@</span><span class='nv'>a_SpecificShareable</span><span class='o'>@</span><span class='nv'>shareable_outp_ls</span><span class='o'>$</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>study_descs_ls</span><span class='o'>$</span><span class='nv'>health_utl_nm_1L_chr</span><span class='o'>)</span></span></code></pre>

</div>

We download a program for generating a template manuscript and run it to author a first draft of the manuscript.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Report"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"Manuscript_Auto"</span>, download_tmpl_1L_lgl <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span></span></code></pre>

</div>

We can copy the RMarkdown files that created the template manuscript to a new director (which we call "Manuscript_Submission") so that we can then manually edit those files to produce a manuscript that we can submit for publication. Note that in this example we have not made any edits to the template manuscript.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'>R.utils</span><span class='nf'>::</span><span class='nf'><a href='https://henrikbengtsson.github.io/R.utils/reference/copyDirectory.html'>copyDirectory</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste0</a></span><span class='o'>(</span><span class='nv'>A</span><span class='o'>@</span><span class='nv'>d_TTUReports</span><span class='o'>@</span><span class='nv'>a_TTUSynopsis</span><span class='o'>@</span><span class='nv'>a_Ready4showPaths</span><span class='o'>@</span><span class='nv'>outp_data_dir_1L_chr</span>,</span>
<span>                              <span class='s'>"/"</span>,</span>
<span>                              <span class='nv'>A</span><span class='o'>@</span><span class='nv'>d_TTUReports</span><span class='o'>@</span><span class='nv'>a_TTUSynopsis</span><span class='o'>@</span><span class='nv'>a_Ready4showPaths</span><span class='o'>@</span><span class='nv'>mkdn_data_dir_1L_chr</span>,</span>
<span>                              <span class='s'>"/Manuscript_Auto"</span><span class='o'>)</span>,</span>
<span>                       <span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste0</a></span><span class='o'>(</span><span class='nv'>A</span><span class='o'>@</span><span class='nv'>d_TTUReports</span><span class='o'>@</span><span class='nv'>a_TTUSynopsis</span><span class='o'>@</span><span class='nv'>a_Ready4showPaths</span><span class='o'>@</span><span class='nv'>outp_data_dir_1L_chr</span>,</span>
<span>                              <span class='s'>"/"</span>,</span>
<span>                              <span class='nv'>A</span><span class='o'>@</span><span class='nv'>d_TTUReports</span><span class='o'>@</span><span class='nv'>a_TTUSynopsis</span><span class='o'>@</span><span class='nv'>a_Ready4showPaths</span><span class='o'>@</span><span class='nv'>mkdn_data_dir_1L_chr</span>,</span>
<span>                              <span class='s'>"/Manuscript_Submission"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

</div>

Once any edits to the RMarkdown files for creating the submission manuscript have been finalised, we can run the following command to author the manuscript. The below commands will generate a Microsoft Word format manuscript and a PDF technical appendix. Unlike the template manuscript, the figures and tables are positioned after (and not within) the main body of the manuscript. Note that the Word version of the manuscript generated by these commands will require some minor formatting edits (principally to the display of tables and numbering of sections).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>,</span>
<span>               <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"a_TTUSynopsis@tables_in_body_lgl"</span>,  <span class='kc'>F</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"a_TTUSynopsis@figures_in_body_lgl"</span>, <span class='kc'>F</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                 <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"a_TTUSynopsis@outp_formats_chr"</span>, <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Word"</span>,<span class='s'>"PDF"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html'>authorSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"d_TTUReports"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"Manuscript_Submission"</span>, download_tmpl_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

</div>

### Tidy workspace

The preceding steps saved multiple objects (mostly R model objects) that have embedded within them copies of the source dataset. We can now purge all such copies from our output data directory.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>A</span>,<span class='s'>"c_SpecificProject"</span><span class='o'>)</span>,</span>
<span>       type_1L_chr <span class='o'>=</span> <span class='s'>"purge_write"</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

</div>

