---
title: "Add metadata to datasets of individual human records"
linkTitle: "Describe data"
date: "2024-01-25"
description: "Appending appropriate metadata to datasets of individual unit records can facilitate partial automation of some modelling tasks. This tutorial describes how a module from the youthvars R package can help you to add metadata to a youth mental health dataset so that it can be more readily used by other readyforwhatsnext modules."
weight: 92
categories: 
- Documentation
tags: 
- Data - management
- Data - metadata
- Model
- Model - modules
- Model - modules (people)
- Software
- Software - libraries
- Software - libraries (youthvars)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: d5f7a039386a70da

---

{{% pageinfo %}} This below section renders a vignette article from the youthvars library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthvars/articles/V_02.html)
-   [view the source file](https://github.com/ready4-dev/youthvars/blob/main/vignettes/V_02.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthvars/edit/main/vignettes/V_02.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

Note: **This vignette is illustrated with fake data**. The dataset explored in this example should not be used to inform decision-making.

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/youthvars/'>youthvars</a></span><span class='o'>)</span></span></code></pre>

</div>

Youthvars provides two [ready4 framework modules](https://www.ready4-dev.com/docs/framework/implementation/modularity/#ready4-model-modules) - `YouthvarsProfile` and `YouthvarsSeries` that form part of the [ready4 economic model of youth mental health](https://www.ready4-dev.com/docs/model/). The ready4 modules in `youthvars` extend the [Ready4useDyad module](https://www.ready4-dev.com/docs/framework/use/authoring-data/label-data/) and can be used to help describe key structural properties of youth mental health datasets.

## Ingest data

To start we ingest `X`, a `Ready4useDyad` (dataset and data dictionary pair) that we can download from a remote repository.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'>ready4use</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>,</span>
<span>                               dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/W95KED"</span>,</span>
<span>                               dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='s'>"ymh_clinical_dyad_r4"</span>,</span>
<span>         metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

## Add metadata

If a dataset is cross-sectional or we wish to treat it as if it were (i.e., where data collection rounds are ignored) we can create `Y`, an instance of the `YouthvarsProfile` module, to add minimal metadata (the name of the unique identifier variable).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/YouthvarsProfile-class.html'>YouthvarsProfile</a></span><span class='o'>(</span>a_Ready4useDyad <span class='o'>=</span> <span class='nv'>X</span>, id_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"fkClientID"</span><span class='o'>)</span></span></code></pre>

</div>

If the temporal dimension of the dataset is important, it may be therefore preferable to instead transform `X` into a `YouthvarsSeries` module instance. `YouthvarsSeries` objects contain all of the fields of `YouthvarsProfile` objects, but also include additional fields that are specific for longitudinal datasets (e.g. `timepoint_var_nm_1L_chr` and `timepoint_vals_chr` that respectively specify the data-collection timepoint variable name and values and `participation_var_1L_chr` that specifies the desired name of a yet to be created variable that will summarise the data-collection timepoints for which each unit record supplied data).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/YouthvarsSeries-class.html'>YouthvarsSeries</a></span><span class='o'>(</span>a_Ready4useDyad <span class='o'>=</span> <span class='nv'>X</span>,</span>
<span>                     id_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"fkClientID"</span>,</span>
<span>                     participation_var_1L_chr <span class='o'>=</span> <span class='s'>"participation"</span>,</span>
<span>                     timepoint_vals_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Baseline"</span>,<span class='s'>"Follow-up"</span><span class='o'>)</span>,</span>
<span>                     timepoint_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"round"</span><span class='o'>)</span></span></code></pre>

</div>

## YouthvarsProfile methods

### Inspect data

We can now specify the variables that we would like to prepare descriptive statistics for by using the `renew` method. The variables to be profiled are specified in the `profile_chr` argument, the number of decimal digits (default = 3) of numeric values in the summary tables to be generated can be specified with `nbr_of_digits_1L_int`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>Y</span>, nbr_of_digits_1L_int <span class='o'>=</span> <span class='m'>2L</span>, profile_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_age"</span>,<span class='s'>"d_sexual_ori_s"</span>,<span class='s'>"d_studying_working"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We can now view the descriptive statistics we created in the previous step.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>profile_idx_int <span class='o'>=</span> <span class='m'>1L</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

</div>

We can also plot the distributions of selected variables in our dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/depict-methods.html'>depict</a></span><span class='o'>(</span><span class='nv'>Y</span>, var_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"c_sofas"</span><span class='o'>)</span>, labels_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"SOFAS"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div class="figure" style="text-align: center">

<img src="figs/totalscsnlfig-1.png" alt="SOFAS total scores" width="600px" />
<p class="caption">
SOFAS total scores
</p>

</div>

</div>

## YouthvarsSeries methods

### Validate data

To explore longitudinal data we need to first use the `ratify` method to ensure that `Z` has been appropriately configured for methods examining datasets reporting measures at two timepoints.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>Z</span>,</span>
<span>            type_1L_chr <span class='o'>=</span> <span class='s'>"two_timepoints"</span><span class='o'>)</span></span></code></pre>

</div>

### Inspect data

We can now specify the variables that we would like to prepare descriptive statistics for using the `renew` method. The variables to be profiled are specified in arguments beginning with "compare\_". Use `compare_ptcpn_chr` to compare variables based on whether cases reported data at one or both timepoints and `compare_by_time_chr` to compare the summary statistics of variables by timepoints, e.g at baseline and follow-up. If you wish these comparisons to report p values, then use the `compare_ptcpn_with_test_chr` and `compare_by_time_with_test_chr` arguments.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>Z</span>,</span>
<span>           compare_by_time_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_age"</span>,<span class='s'>"d_sexual_ori_s"</span>,<span class='s'>"d_studying_working"</span><span class='o'>)</span>,</span>
<span>           compare_by_time_with_test_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"k6_total"</span>, <span class='s'>"phq9_total"</span>, <span class='s'>"bads_total"</span><span class='o'>)</span>,</span>
<span>           compare_ptcpn_with_test_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"k6_total"</span>, <span class='s'>"phq9_total"</span>, <span class='s'>"bads_total"</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

The tables generated in the preceding step can be inspected using the `exhibit` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>profile_idx_int <span class='o'>=</span> <span class='m'>1L</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>profile_idx_int <span class='o'>=</span> <span class='m'>2L</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>profile_idx_int <span class='o'>=</span> <span class='m'>3L</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

</div>

The `depict` method can create plots, comparing numeric variables by timepoint.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/depict-methods.html'>depict</a></span><span class='o'>(</span><span class='nv'>Z</span>,</span>
<span>       type_1L_chr <span class='o'>=</span> <span class='s'>"by_time"</span>,</span>
<span>       var_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"c_sofas"</span><span class='o'>)</span>,</span>
<span>       label_fill_1L_chr <span class='o'>=</span> <span class='s'>"Time"</span>,<span class='c'>#</span></span>
<span>       labels_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"SOFAS"</span><span class='o'>)</span>,<span class='c'>#</span></span>
<span>       y_label_1L_chr <span class='o'>=</span> <span class='s'>""</span><span class='o'>)</span></span>
</code></pre>

<div class="figure" style="text-align: center">

<img src="figs/totalsfig-1.png" alt="SOFAS total scores by data collection round" width="600px" />
<p class="caption">
SOFAS total scores by data collection round
</p>

</div>

</div>

## Share data

**If and only if the dataset you are working with is appropriate for public dissemination (e.g. is synthetic data), you can use the following workflow for sharing it.** We can share the dataset we created for this example using the `share` method, specifying the repository to which we wish to publish the dataset (and for which we have write permissions) in a ([Ready4useRepos object](https://ready4-dev.github.io/ready4use/articles/V_01.html)).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>A <- Ready4useRepos(gh_repo_1L_chr = "ready4-dev/youthvars", # Replace with your repository 
                          gh_tag_1L_chr = "Documentation_0.0"), # (need write permissions).
A <- share(A,
           obj_to_share_xx = Z,
           fl_nm_1L_chr = "ymh_YouthvarsSeries")
</code></pre>

</div>

`Z` is now available for download as the file `ymh_YouthvarsSeries.RDS` from the ["Documentation_0.0" release of the youthvars package](https://github.com/ready4-dev/youthvars/releases/tag/Documentation_0.0).

