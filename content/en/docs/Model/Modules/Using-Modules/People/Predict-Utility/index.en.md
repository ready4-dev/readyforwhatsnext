---
title: "Find and deploy utility mapping models"
linkTitle: "Predict utility"
date: "2023-10-20"
description: "Using tools (soon to be formalised into ready4 modules) from the youthu R package, it is possible to find and deploy relevant utility mapping algorithms. This tutorial illustrates the main steps for predicting AQoL-6D utility from psychological and functional measures collected on clinical samples of young people."
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
rmd_hash: ebc4d6004fb1e260
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the youthu library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthu/articles/Prediction_With_Mdls.html)
-   [view the source file](https://github.com/ready4-dev/youthu/blob/main/vignettes/Prediction_With_Mdls.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthu/edit/main/vignettes/Prediction_With_Mdls.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/youthu/'>youthu</a></span><span class='o'>)</span></span></code></pre>

</div>

This vignette outlines a workflow for:

-   Searching, selecting and retrieving transfer to utility models;
-   Preparing a prediction dataset for use with a selected transfer to utility model; and
-   Applying the selected transfer to utility model to a prediction dataset to predict Quality Adjusted Life Years (QALYs).

The practical value of implementing such a workflow is discussed in the [economic analysis vignette](https://ready4-dev.github.io/youthu/articles/Economic_Analysis.html) and [a scientific manuscript](https://www.medrxiv.org/content/10.1101/2021.07.07.21260129v2.full). Note, this example uses fake data - it should should not be used to inform decision making.

## Search, select and retrieve transfer to utility models

To identify datasets that contain transfer to utility models compatible with youthu (ie those developped with the [TTU package](https://ready4-dev.github.io/TTU/index.html)), you can use the `get_ttu_dv_dss` function. The function searches specified dataverses (in the below example, the [TTU dataverse](https://dataverse.harvard.edu/dataverse/TTU)) for datasets containing output from the TTU package.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>ttu_dv_dss_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_ttu_dv_dss.html'>get_ttu_dv_dss</a></span><span class='o'>(</span><span class='s'>"TTU"</span><span class='o'>)</span></span></code></pre>

</div>

The `ttu_dv_dss_tb` table summarises some pertinent details about each dataset containing TTU models found by the preceding command. These details include a link to any scientific summary (the "Article" column) associated with a dataset.

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Transfer to Utility Datasets
</caption>
<thead>
<tr>
<th style="text-align:left;">
ID
</th>
<th style="text-align:left;">
Utility
</th>
<th style="text-align:left;">
Predictors
</th>
<th style="text-align:left;">
Article
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
aqol6dtotalw
</td>
<td style="text-align:left;">
BADS total score , GAD7 total score , K6 total score , OASIS total score , PHQ9 total score , SCARED total score, SOFAS total score
</td>
<td style="text-align:left;">
<https://doi.org/10.1101/2021.07.07.21260129>
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

To identify models that predict a specified type of health utility from one or more of a specified subset of predictors, use:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>mdls_lup</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_mdls_lup.html'>get_mdls_lup</a></span><span class='o'>(</span>ttu_dv_dss_tb <span class='o'>=</span> <span class='nv'>ttu_dv_dss_tb</span>,</span>
<span>                         utility_type_chr <span class='o'>=</span> <span class='s'>"AQoL-6D"</span>,</span>
<span>                         mdl_predrs_in_ds_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ9 total score"</span>,</span>
<span>                                                  <span class='s'>"SOFAS total score"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

The preceding command will produce a lookup table with information that includes the catalogue names of models, the predictors used in each model and the analysis that generated each one.

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Selected elements from Models Look-Up Table
</caption>
<thead>
<tr>
<th style="text-align:left;">
Catalogue reference
</th>
<th style="text-align:right;">
Predictors
</th>
<th style="text-align:right;">
Analysis
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
OASIS_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
OASIS, SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
OASIS_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
OASIS, SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
BADS_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
BADS , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
BADS_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
BADS , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
K6_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
K6 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
K6_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
K6 , SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
SCARED_SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
SCARED, SOFAS
</td>
<td style="text-align:right;">
Primary Analysis
</td>
</tr>
<tr>
<td style="text-align:left;">
SCARED_SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
SCARED, SOFAS
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
SOFAS_1_GLM_GSN_LOG
</td>
<td style="text-align:right;">
SOFAS
</td>
<td style="text-align:right;">
Secondary Analysis A
</td>
</tr>
<tr>
<td style="text-align:left;">
SOFAS_1_OLS_CLL
</td>
<td style="text-align:right;">
SOFAS
</td>
<td style="text-align:right;">
Secondary Analysis A
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

</div>

To review the summary information about the predictive performance of a specific model, use:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_dv_mdl_smrys.html'>get_dv_mdl_smrys</a></span><span class='o'>(</span><span class='nv'>mdls_lup</span>,</span>
<span>                 mdl_nms_chr <span class='o'>=</span> <span class='s'>"PHQ9_SOFAS_1_OLS_CLL"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; $PHQ9_SOFAS_1_OLS_CLL</span></span>
<span><span class='c'>#&gt;        Parameter Estimate    SE          95% CI</span></span>
<span><span class='c'>#&gt; 1 SD (Intercept)    0.348 0.017   0.312 , 0.382</span></span>
<span><span class='c'>#&gt; 2      Intercept    0.428 0.129   0.174 , 0.686</span></span>
<span><span class='c'>#&gt; 3  PHQ9 baseline   -9.115 0.249 -9.601 , -8.618</span></span>
<span><span class='c'>#&gt; 4    PHQ9 change   -7.331 0.339 -8.007 , -6.665</span></span>
<span><span class='c'>#&gt; 5 SOFAS baseline    0.960 0.172   0.616 , 1.292</span></span>
<span><span class='c'>#&gt; 6   SOFAS change    1.146 0.235   0.674 , 1.607</span></span>
<span><span class='c'>#&gt; 7             R2    0.767 0.012   0.743 , 0.788</span></span>
<span><span class='c'>#&gt; 8           RMSE    0.925 0.004   0.922 , 0.928</span></span>
<span><span class='c'>#&gt; 9          Sigma    0.406 0.012   0.384 , 0.429</span></span>
<span></span></code></pre>

</div>

More information about a selected model can be found in the online model catalogue, the link to which can be obtained with the following command:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_mdl_ctlg_url.html'>get_mdl_ctlg_url</a></span><span class='o'>(</span><span class='nv'>mdls_lup</span>,</span>
<span>                 mdl_nm_1L_chr <span class='o'>=</span> <span class='s'>"PHQ9_SOFAS_1_OLS_CLL"</span><span class='o'>)</span></span>
</code></pre>

\[1\] "<https://dataverse.harvard.edu/api/access/datafile/6484935>"

</div>

## Prepare a prediction dataset for use with a selected transfer to utility model

### Import data

You can now import and inspect the dataset you plan on using for prediction. In the below example we use fake data.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/make_fake_ds_one.html'>make_fake_ds_one</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Illustrative example of a prediction dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
UID
</th>
<th style="text-align:right;">
Timepoint
</th>
<th style="text-align:right;">
Date
</th>
<th style="text-align:right;">
PHQ_total
</th>
<th style="text-align:right;">
SOFAS_total
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Participant_1
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-05-22
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
69
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-04-07
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
60
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-06-22
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
64
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_100
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-07-29
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
76
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-02-10
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-05-05
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
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

### Confirm dataset can be used as a prediction dataset

The prediction dataset must contain variables that correspond to all the predictors of the model you intend to apply. The allowable range and required class of each predictor variable are described in the `min_val_dbl`, `max_val_dbl` and `class_chr` columns of the model predictors lookup table, which can be accessed with a call to the `get_predictors_lup` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>predictors_lup</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/get_predictors_lup.html'>get_predictors_lup</a></span><span class='o'>(</span>mdls_lup <span class='o'>=</span> <span class='nv'>mdls_lup</span>,</span>
<span>                                     mdl_nm_1L_chr <span class='o'>=</span> <span class='s'>"PHQ9_SOFAS_1_OLS_CLL"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Model predictors lookup table
</caption>
<thead>
<tr>
<th style="text-align:left;">
short_name_chr
</th>
<th style="text-align:right;">
long_name_chr
</th>
<th style="text-align:left;">
min_val_dbl
</th>
<th style="text-align:right;">
max_val_dbl
</th>
<th style="text-align:left;">
class_chr
</th>
<th style="text-align:right;">
increment_dbl
</th>
<th style="text-align:left;">
class_fn_chr
</th>
<th style="text-align:right;">
mdl_scaling_dbl
</th>
<th style="text-align:left;">
covariate_lgl
</th>
</tr>
</thead>
<tbody>
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
<tr>
<td style="text-align:left;">
SOFAS
</td>
<td style="text-align:right;">
SOFAS total score
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
youthvars::youthvars_sofas
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:left;">
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

The prediction dataset must also include both a unique client identifier variable and a measurement time-point identifier variable (which must be a `factor` with two levels). The dataset also needs to be in long format (ie where measures at different time-points for the same individual are stacked on top of each other in separate rows). We can confirm these conditions hold by creating a dataset metadata object using the `make_predn_metadata_ls` function. In creating the metadata object, the function checks that the dataset can be used in conjunction with the model specified at the `mdl_nm_1L_chr` argument. If the prediction dataset uses different variable names for the predictors to those specified in the `predictors_lup` lookup table, a named vector detailing the correspondence between the two sets of variable names needs to be passed to the `predr_vars_nms_chr` argument. Finally, if you wish to specify a preferred variable name to use for the predicted utility values when applying the model, you can do this by passing this name to the `utl_var_nm_1L_chr` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>predn_ds_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/make_predn_metadata_ls.html'>make_predn_metadata_ls</a></span><span class='o'>(</span><span class='nv'>data_tb</span>,</span>
<span>                                      id_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"UID"</span>,</span>
<span>                                      msrmnt_date_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"Date"</span>,</span>
<span>                                      predr_vars_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span>PHQ9 <span class='o'>=</span> <span class='s'>"PHQ_total"</span>,SOFAS <span class='o'>=</span> <span class='s'>"SOFAS_total"</span><span class='o'>)</span>,</span>
<span>                                      round_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"Timepoint"</span>,</span>
<span>                                      round_bl_val_1L_chr <span class='o'>=</span> <span class='s'>"Baseline"</span>,</span>
<span>                                      utl_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"AQoL6D_HU"</span>,</span>
<span>                                      mdls_lup <span class='o'>=</span> <span class='nv'>mdls_lup</span>,</span>
<span>                                      mdl_nm_1L_chr <span class='o'>=</span> <span class='s'>"PHQ9_SOFAS_1_OLS_CLL"</span><span class='o'>)</span></span></code></pre>

</div>

## Apply the selected transfer to utility model to a prediction dataset to predict Quality Adjusted Life Years (QALYs)

### Predict health utility at baseline and follow-up timepoints

To generate utility predictions we use the `add_utl_predn` function. The function needs to be supplied with the prediction dataset (the value passed to argument `data_tb`) and the validated prediction metadata object we created in the previous step.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/add_utl_predn.html'>add_utl_predn</a></span><span class='o'>(</span><span class='nv'>data_tb</span>,</span>
<span>                         predn_ds_ls <span class='o'>=</span> <span class='nv'>predn_ds_ls</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(UID, Timepoint)`</span></span>
<span></span></code></pre>

</div>

By default the `add_utl_predn` function samples model parameter values based on a table of model coefficients when making predictions and constrains predictions to an allowed range. You can override these defaults by adding additional arguments `new_data_is_1L_chr = "Predicted"` (which uses mean parameter values), `force_min_max_1L_lgl = F` (removes range constraint) and (if the source dataset makes available downloadable model objects) `make_from_tbl_1L_lgl = F`. These settings will produce different predictions. It is strongly recommended that you consult the model catalogue (see above) to understand how such decisions may affect the validity of the predicted values that will be generated.

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Prediction dataset with predicted utilities
</caption>
<thead>
<tr>
<th style="text-align:left;">
UID
</th>
<th style="text-align:right;">
Timepoint
</th>
<th style="text-align:right;">
Date
</th>
<th style="text-align:right;">
PHQ_total
</th>
<th style="text-align:right;">
SOFAS_total
</th>
<th style="text-align:right;">
AQoL6D_HU
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Participant_1
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-05-22
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
69
</td>
<td style="text-align:right;">
0.9080468
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-04-07
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
60
</td>
<td style="text-align:right;">
0.5533808
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-06-22
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
0.4006010
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_100
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-07-29
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
76
</td>
<td style="text-align:right;">
0.6809903
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-02-10
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
0.9877882
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-05-05
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
0.9602037
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

Our health utility predictions are now available for use and are summarised below.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/summary.html'>summary</a></span><span class='o'>(</span><span class='nv'>data_tb</span><span class='o'>$</span><span class='nv'>AQoL6D_HU</span><span class='o'>)</span></span>
<span><span class='c'>#&gt;    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. </span></span>
<span><span class='c'>#&gt; 0.06646 0.42781 0.63403 0.62335 0.83351 1.00000</span></span>
<span></span></code></pre>

</div>

### Calculate QALYs

The last step is to calculate Quality Adjusted Life Years, using a method assuming a linear rate of change between timepoints.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>data_tb</span> <span class='o'>&lt;-</span> <span class='nv'>data_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/add_qalys_to_ds.html'>add_qalys_to_ds</a></span><span class='o'>(</span>predn_ds_ls <span class='o'>=</span> <span class='nv'>predn_ds_ls</span>,</span>
<span>                                       include_predrs_1L_lgl <span class='o'>=</span> <span class='kc'>F</span>,</span>
<span>                                       reshape_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Prediction dataset with QALYs
</caption>
<thead>
<tr>
<th style="text-align:left;">
UID
</th>
<th style="text-align:right;">
Timepoint
</th>
<th style="text-align:right;">
Date
</th>
<th style="text-align:right;">
PHQ_total
</th>
<th style="text-align:right;">
SOFAS_total
</th>
<th style="text-align:right;">
AQoL6D_HU
</th>
<th style="text-align:left;">
AQoL6D_HU_change_dbl
</th>
<th style="text-align:right;">
duration_prd
</th>
<th style="text-align:right;">
qalys_dbl
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Participant_1
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-05-22
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
69
</td>
<td style="text-align:right;">
0.9080468
</td>
<td style="text-align:left;">
0.0000000
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:right;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-04-07
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
60
</td>
<td style="text-align:right;">
0.5533808
</td>
<td style="text-align:left;">
0.0000000
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:right;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_10
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-06-22
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
0.4006010
</td>
<td style="text-align:left;">
-0.1527798
</td>
<td style="text-align:right;">
76d 0H 0M 0S
</td>
<td style="text-align:right;">
0.0992507
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_100
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-07-29
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
76
</td>
<td style="text-align:right;">
0.6809903
</td>
<td style="text-align:left;">
0.0000000
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:right;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Baseline
</td>
<td style="text-align:right;">
2022-02-10
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
0.9877882
</td>
<td style="text-align:left;">
0.0000000
</td>
<td style="text-align:right;">
0S
</td>
<td style="text-align:right;">
0.0000000
</td>
</tr>
<tr>
<td style="text-align:left;">
Participant_1000
</td>
<td style="text-align:right;">
Follow-up
</td>
<td style="text-align:right;">
2022-05-05
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
0.9602037
</td>
<td style="text-align:left;">
-0.0275845
</td>
<td style="text-align:right;">
84d 0H 0M 0S
</td>
<td style="text-align:right;">
0.2239991
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

