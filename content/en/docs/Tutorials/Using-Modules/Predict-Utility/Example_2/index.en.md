---
title: "Example 2: Predict health utility from psychological measures (PHQ-9 and GAD-7)"
linkTitle: "Example 2"
date: "2024-06-08"
description: "This tutorial illustrates the main steps for predicting AQoL-6D utility from two psychological measures using a longitudinal dataset in wide format."
weight: 96
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
- Software - libraries (youthu)
- Software - libraries (specific)
- Status
- Status - development
- Use
- Use - utility mapping
params:
  output_type_1L_chr: HTML
output: hugodown::md_document
rmd_hash: 549a3cd0181a6a51
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the youthu library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthu/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/youthu/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthu/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

**This vignette article is abridged and modified version of [another article on predicting Quality Adjusted Life Years with youthu](https://ready4-dev.github.io/youthu/articles/Prediction_With_Mdls.html).**

## Motivation

This article illustrates how to make QALY predictions using a dataset in wide format with no health-utility measures but containing two psychological measures (GAD-7 and PHQ-9).

## Install youthu

If not already installed it will be necessary to install the `youthu` R library. As `youthu` is not yet available on CRAN, it will be necessary to install it directly from its GitHub repository using an R package like `remotes` or `devtools`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Uncomment and run if installation is required.</span></span>
<span><span class='c'># utils::install.packages("devtools") </span></span>
<span><span class='c'># devtools::install_github("ready4-dev/youthu")</span></span></code></pre>

</div>

## Load required packages

We now load the libraries we will be using in subsequent steps. Note, both the `ready4`, `ready4show` and `ready4use` [ready4 framework](https://www.ready4-dev.com/) libraries will have been installed automatically when `youthu` was installed. The `specific` readyforwhatsnext module library and `dplyr`, `purrr`, `stringr` and `tidyr` CRAN libraries will have been installed at the same time.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/'>ready4show</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/specific/'>specific</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/youthu/'>youthu</a></span><span class='o'>)</span></span></code></pre>

</div>

## Specify data sources

We begin by specifying the sources for our data. In this example, our data sources are online repositories.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>, dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/HJXYKQ"</span>, </span>
<span>                    dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span>,</span>
<span>                    gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/youthu"</span>, gh_tag_1L_chr <span class='o'>=</span> <span class='s'>"v0.0.0.91125"</span><span class='o'>)</span></span></code></pre>

</div>

## Inspect dataset

We can now inspect the dataset we will be using to make predictions. As this is a demonstration article we are going to create a custom synthetic dataset. Our first step in doing so is to ingest a preexisting synthetic dataset (in long format) using the method explained in [another vignette article](https://ready4-dev.github.io/ready4use/articles/V_03.html)

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span><span class='nv'>X</span>, fls_to_ingest_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"ymh_phq_gad_tb"</span><span class='o'>)</span>, metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

</div>

Our resulting dataset has unique IDs for each participant (character class), timestamps for each data collection timepoint (Date class variables) and GAD-7 and PHQ-9 scores for each timepoint (integer class).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'>ready4show</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4show/reference/print_table.html'>print_table</a></span><span class='o'>(</span>caption_1L_chr <span class='o'>=</span> <span class='s'>"Dataset"</span>, output_type_1L_chr <span class='o'>=</span> <span class='s'>"HTML"</span><span class='o'>)</span> </span>
</code></pre>
<table class=" lightable-paper lightable-hover" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
fkClientID
</th>
<th style="text-align:right;">
d_interview_date_t1
</th>
<th style="text-align:right;">
d_interview_date_t2
</th>
<th style="text-align:right;">
gad7_t1
</th>
<th style="text-align:right;">
gad7_t2
</th>
<th style="text-align:right;">
phq9_t1
</th>
<th style="text-align:left;">
phq9_t2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Participant_1
</td>
<td style="text-align:right;">
2020-03-22
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_2
</td>
<td style="text-align:right;">
2020-06-15
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_3
</td>
<td style="text-align:right;">
2020-08-20
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_4
</td>
<td style="text-align:right;">
2020-05-23
</td>
<td style="text-align:right;">
2020-08-19
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
14
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_5
</td>
<td style="text-align:right;">
2020-04-05
</td>
<td style="text-align:right;">
2020-07-19
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_6
</td>
<td style="text-align:right;">
2020-06-09
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
NA
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

## Get mapping models

We retrieve details of relevant AQoL-6D mapping models for wither of the predictors we plan on using. How these models were derived is described in a [pre-print](https://doi.org/10.1101/2021.07.07.21260129) and details of model performance is included in catalogues available in an [open access data repository](https://doi.org/10.7910/DVN/DKDIB0).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>mdls_lup</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_mdls_lup.html'>get_mdls_lup</a></span><span class='o'>(</span>ttu_dv_dss_tb <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_ttu_dv_dss.html'>get_ttu_dv_dss</a></span><span class='o'>(</span><span class='s'>"TTU"</span><span class='o'>)</span>,</span>
<span>                         utility_type_chr <span class='o'>=</span> <span class='s'>"AQoL-6D"</span>,</span>
<span>                         mdl_predrs_in_ds_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"GAD7 total score"</span>, <span class='s'>"PHQ9 total score"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>mdls_lup</span><span class='o'>[</span>,<span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>2</span>,<span class='m'>5</span><span class='o'>)</span><span class='o'>]</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'>ready4show</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4show/reference/print_table.html'>print_table</a></span><span class='o'>(</span>caption_1L_chr <span class='o'>=</span> <span class='s'>"Available models"</span>, output_type_1L_chr <span class='o'>=</span> <span class='s'>"HTML"</span><span class='o'>)</span> </span>
</code></pre>
<table class=" lightable-paper lightable-hover" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
<caption>
Available models
</caption>
<thead>
<tr>
<th style="text-align:left;">
mdl_nms_chr
</th>
<th style="text-align:right;">
predrs_ls
</th>
<th style="text-align:right;">
source_chr
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
PHQ9_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
PHQ9
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
PHQ9_1_OLS_CLL
</td>
<td style="text-align:right;">
PHQ9
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
GAD7
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_1_OLS_CLL
</td>
<td style="text-align:right;">
GAD7
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
PHQ9_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
PHQ9 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
PHQ9_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
PHQ9 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
GAD7 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
GAD7 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
OASIS_PHQ9_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
OASIS, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
</td>
</tr>
<tr>
<td style="text-align:left;">
OASIS_PHQ9_1_OLS_CLL
</td>
<td style="text-align:right;">
OASIS, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_PHQ9_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
GAD7, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7_PHQ9_1_OLS_CLL
</td>
<td style="text-align:right;">
GAD7, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
</td>
</tr>
<tr>
<td style="text-align:left;">
SCARED_PHQ9_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
SCARED, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
</td>
</tr>
<tr>
<td style="text-align:left;">
SCARED_PHQ9_1_OLS_CLL
</td>
<td style="text-align:right;">
SCARED, PHQ9
</td>
<td style="text-align:right;">
Secondary Analysis B
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

We select our preferred model and retrieve summary data about the model's predictor variables.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>predictors_lup</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_predictors_lup.html'>get_predictors_lup</a></span><span class='o'>(</span>mdls_lup <span class='o'>=</span> <span class='nv'>mdls_lup</span>, mdl_nm_1L_chr <span class='o'>=</span> <span class='s'>"GAD7_PHQ9_1_OLS_CLL"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>predictors_lup</span><span class='o'>)</span></span>
</code></pre>
<table class=" lightable-paper lightable-hover" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
Description
</th>
<th style="text-align:left;">
Minimum
</th>
<th style="text-align:right;">
Maximum
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:right;">
Increment
</th>
<th style="text-align:left;">
Function
</th>
<th style="text-align:right;">
Scaling
</th>
<th style="text-align:left;">
Covariate
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
GAD7
</td>
<td style="text-align:right;">
GAD7 total score
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
youthvars::youthvars_gad7
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:left;">
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
<td style="text-align:left;">
0
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
youthvars::youthvars_phq9
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:left;">
FALSE
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

## Transform prediction dataset

To be used with the mapping models available to us, our prediction dataset needs to be in long format. We perform the necessary transformation.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/transform_ds_to_long.html'>transform_ds_to_long</a></span><span class='o'>(</span><span class='nv'>data_tb</span>, predictors_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"gad7"</span>, <span class='s'>"phq9"</span><span class='o'>)</span>,</span>
<span>                             msrmnt_date_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"d_interview_date"</span>, round_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"When"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(case_id, fkClientID, When)`</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(case_id, fkClientID, When)`</span></span>
<span></span></code></pre>

</div>

We drop records where we are missing data for either GAD7 or PHQ9 at either timepoint.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/transform_ds_to_drop_msng.html'>transform_ds_to_drop_msng</a></span><span class='o'>(</span><span class='nv'>data_tb</span>, predictors_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"gad7"</span>, <span class='s'>"phq9"</span><span class='o'>)</span>, </span>
<span>                                      uid_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"fkClientID"</span><span class='o'>)</span></span></code></pre>

</div>

We now predict AQoL-6D health utility for each case with complete data.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>predn_ds_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/make_predn_metadata_ls.html'>make_predn_metadata_ls</a></span><span class='o'>(</span><span class='nv'>data_tb</span>,</span>
<span>                                      id_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"fkClientID"</span>,</span>
<span>                                      msrmnt_date_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"d_interview_date"</span>,</span>
<span>                                      predr_vars_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span>GAD7 <span class='o'>=</span> <span class='s'>"gad7"</span>, PHQ9 <span class='o'>=</span> <span class='s'>"phq9"</span><span class='o'>)</span>,</span>
<span>                                      round_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"When"</span>,</span>
<span>                                      round_bl_val_1L_chr <span class='o'>=</span> <span class='s'>"t1"</span>,</span>
<span>                                      utl_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"AQoL6D_HU"</span>,</span>
<span>                                      mdls_lup <span class='o'>=</span> <span class='nv'>mdls_lup</span>,</span>
<span>                                      mdl_nm_1L_chr <span class='o'>=</span> <span class='s'>"GAD7_PHQ9_1_OLS_CLL"</span><span class='o'>)</span></span>
<span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/add_utl_predn.html'>add_utl_predn</a></span><span class='o'>(</span><span class='nv'>data_tb</span>, new_data_is_1L_chr <span class='o'>=</span> <span class='s'>"Predicted"</span>, predn_ds_ls <span class='o'>=</span> <span class='nv'>predn_ds_ls</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(fkClientID, When)`</span></span>
<span></span></code></pre>

</div>

Finally, we derive QALY predictions from the health utility measures at both time-points.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nv'>data_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/add_qalys_to_ds.html'>add_qalys_to_ds</a></span><span class='o'>(</span>predn_ds_ls <span class='o'>=</span> <span class='nv'>predn_ds_ls</span>, include_predrs_1L_lgl <span class='o'>=</span> <span class='kc'>F</span>, reshape_1L_lgl <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>ready4show</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4show/reference/print_table.html'>print_table</a></span><span class='o'>(</span>caption_1L_chr <span class='o'>=</span> <span class='s'>"Final dataset"</span>, output_type_1L_chr <span class='o'>=</span> <span class='s'>"HTML"</span>,</span>
<span>                          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Final dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
fkClientID
</th>
<th style="text-align:right;">
d_interview_date_t1
</th>
<th style="text-align:right;">
d_interview_date_t2
</th>
<th style="text-align:right;">
gad7_t1
</th>
<th style="text-align:right;">
gad7_t2
</th>
<th style="text-align:right;">
phq9_t1
</th>
<th style="text-align:left;">
phq9_t2
</th>
<th style="text-align:right;">
AQoL6D_HU_t1
</th>
<th style="text-align:right;">
AQoL6D_HU_t2
</th>
<th style="text-align:right;">
AQoL6D_HU_change_dbl_t1
</th>
<th style="text-align:right;">
AQoL6D_HU_change_dbl_t2
</th>
<th style="text-align:right;">
duration_prd_t1
</th>
<th style="text-align:left;">
duration_prd_t2
</th>
<th style="text-align:right;">
qalys_dbl_t1
</th>
<th style="text-align:right;">
qalys_dbl_t2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
2020-08-05
</td>
<td style="text-align:right;">
2020-11-07
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
18
</td>
<td style="text-align:right;">
0.3891806
</td>
<td style="text-align:right;">
0.6342526
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.2450720
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
94d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.1316943
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
2020-09-06
</td>
<td style="text-align:right;">
2020-12-20
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:right;">
0.6609298
</td>
<td style="text-align:right;">
0.2963083
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
-0.3646215
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
105d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.1375907
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1001
</td>
<td style="text-align:right;">
2020-07-05
</td>
<td style="text-align:right;">
2020-10-15
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
16
</td>
<td style="text-align:right;">
0.5324127
</td>
<td style="text-align:right;">
0.6192971
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.0868844
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
102d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.1608137
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1003
</td>
<td style="text-align:right;">
2020-05-18
</td>
<td style="text-align:right;">
2020-08-12
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:right;">
0.5630164
</td>
<td style="text-align:right;">
0.8584193
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.2954030
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
86d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.1673422
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1005
</td>
<td style="text-align:right;">
2020-05-09
</td>
<td style="text-align:right;">
2020-08-25
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
9
</td>
<td style="text-align:right;">
0.5090272
</td>
<td style="text-align:right;">
0.7799675
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.2709403
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
108d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.1905701
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1006
</td>
<td style="text-align:right;">
2020-05-29
</td>
<td style="text-align:right;">
2020-08-25
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
17
</td>
<td style="text-align:right;">
0.2969778
</td>
<td style="text-align:right;">
0.2734973
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
-0.0234805
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:left;">
88d 0H 0M 0S
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.0687225
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

