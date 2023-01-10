---
title: "Explore candidate utility mapping models"
linkTitle: "Assess models"
date: "2022-12-24"
description: "Using modules from the specific R package, it is possible to undertake an exploratory utility mapping analysis. This tutorial illustrates a hypotehtical example of exploring how to map to EQ-5D health utility."
weight: 95
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
- Software - libraries (specific)
- Use - utility mapping
output: hugodown::md_document
rmd_hash: 5429b6a80b16b0f0
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the specific library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/specific/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/specific/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/specific/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

Note: **This vignette uses fake data** - it is for illustrative purposes only and should not be used to inform decision making.

The steps in this exploratory analysis workflow may need to be performed iteratively, both in order to identify the optimal model types, predictors and covariates to use and modify default values to ensure model convergence.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/'>ready4show</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/scorz/'>scorz</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'>betareg</span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/specific/'>specific</a></span><span class='o'>)</span></span></code></pre>

</div>

## Import data

We start by ingesting our data. As this example uses EQ-5D data, we import a `ScorzEuroQol5` [ready4 framework module](https://ready4-dev.github.io/ready4/articles/V_01.html) (created using the steps described in [this vignette from the scorz pacakge](https://ready4-dev.github.io/scorz/articles/V_02.html)) into a `SpecificConverter` Module and then apply the `metamorphose` method to convert it into a `SpecificModel` module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/specific/reference/SpecificConverter-class.html'>SpecificConverter</a></span><span class='o'>(</span>a_ScorzProfile <span class='o'>=</span> <span class='nf'>ready4use</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/scorz"</span>, </span>
<span>                                                                  gh_tag_1L_chr <span class='o'>=</span> <span class='s'>"Documentation_0.0"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                         <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='s'>"ymh_ScorzEuroQol5"</span>,</span>
<span>                                metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/metamorphose-methods.html'>metamorphose</a></span><span class='o'>(</span><span class='o'>)</span> </span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "SpecificModels"</span></span>
<span><span class='c'>#&gt; attr(,"package")</span></span>
<span><span class='c'>#&gt; [1] "specific"</span></span></code></pre>

</div>

## Inspect data

<div class="highlight">

</div>

The dataset we are using has a total of 1786 records at two timepoints on 1068 study participants. The first six records are reproduced below.

<div class="highlight">

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
Unique identifier
</th>
<th style="text-align:right;">
Data collection round
</th>
<th style="text-align:right;">
Date of data collection
</th>
<th style="text-align:right;">
Age
</th>
<th style="text-align:right;">
Gender (grouped)
</th>
<th style="text-align:right;">
Sex at birth
</th>
<th style="text-align:left;">
Sexual orientation
</th>
<th style="text-align:right;">
Relationship status
</th>
<th style="text-align:right;">
Aboriginal or Torres Strait Islander
</th>
<th style="text-align:right;">
Culturally And Linguistically Diverse
</th>
<th style="text-align:right;">
Region of residence (metropolitan or regional)
</th>
<th style="text-align:right;">
Education and employment status
</th>
<th style="text-align:left;">
EQ5D - Mobility domain score
</th>
<th style="text-align:right;">
EQ5D - Self-Care domain score
</th>
<th style="text-align:right;">
EQ5D - Usual Activities domain score
</th>
<th style="text-align:right;">
EQ5D - Pain / Discomfort domain score
</th>
<th style="text-align:right;">
EQ5D - Anxiety / Depression domain score
</th>
<th style="text-align:right;">
Kessler Psychological Distress - 10 Item Total Score
</th>
<th style="text-align:left;">
Overall Wellbeing Measure (Winefield et al. 2012)
</th>
<th style="text-align:right;">
EuroQol (EQ-5D) - (weighted total)
</th>
<th style="text-align:right;">
EuroQol (EQ-5D) - (unweighted total)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
BL
</td>
<td style="text-align:right;">
2019-10-22
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
Male
</td>
<td style="text-align:right;">
Male
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:right;">
In a relationship
</td>
<td style="text-align:right;">
No
</td>
<td style="text-align:right;">
No
</td>
<td style="text-align:right;">
Metro
</td>
<td style="text-align:right;">
Not studying or working
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
87
</td>
<td style="text-align:right;">
0.879
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:right;">
BL
</td>
<td style="text-align:right;">
2019-10-17
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:right;">
In a relationship
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Regional
</td>
<td style="text-align:right;">
Studying only
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
65
</td>
<td style="text-align:right;">
0.846
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:right;">
FUP
</td>
<td style="text-align:right;">
2020-02-14
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:right;">
In a relationship
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Regional
</td>
<td style="text-align:right;">
Studying only
</td>
<td style="text-align:left;">
3
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
71
</td>
<td style="text-align:right;">
0.850
</td>
<td style="text-align:right;">
7
</td>
</tr>
<tr>
<td style="text-align:left;">
3
</td>
<td style="text-align:right;">
BL
</td>
<td style="text-align:right;">
2020-02-15
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:right;">
Not in a relationship
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
Metro
</td>
<td style="text-align:right;">
Studying only
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
74
</td>
<td style="text-align:right;">
0.883
</td>
<td style="text-align:right;">
7
</td>
</tr>
<tr>
<td style="text-align:left;">
3
</td>
<td style="text-align:right;">
FUP
</td>
<td style="text-align:right;">
2020-06-14
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:right;">
Not in a relationship
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
Metro
</td>
<td style="text-align:right;">
Studying only
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
64
</td>
<td style="text-align:right;">
0.906
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
4
</td>
<td style="text-align:right;">
BL
</td>
<td style="text-align:right;">
2019-12-14
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:right;">
Female
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:right;">
In a relationship
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Yes
</td>
<td style="text-align:right;">
Metro
</td>
<td style="text-align:right;">
Not studying or working
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
40
</td>
<td style="text-align:right;">
0.796
</td>
<td style="text-align:right;">
7
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

To source dataset of `X` is contained in the `a_YouthvarsProfile` slot and is a `YouthvarsSeries` module. For more information about methods that can be used to explore this dataset, [read this vignette from the youthvars package](https://ready4-dev.github.io/youthvars/articles/V_02.html).

## Specify parameters

In preparation for exploring our dataset, we need to declare a set of model parameters in a `b_SpecificParameters` slot of `X`. This can be done in one step, or in sequential steps. In this example, we will proceed sequentially.

### Dependent variable

The dependent variable (total EQ-5D utility score) has already been specified when we imported the data from the `ScorzEuroQol5` module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@depnt_var_nm_1L_chr"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "eq5d_total_w"</span></span></code></pre>

</div>

We can now add details of the allowable range of dependent variable values.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@depnt_var_min_max_dbl"</span>,</span>
<span>               <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1</span>,<span class='m'>1</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Candidate predictors

We can now specify the names of candidate predictor variables.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@candidate_predrs_chr"</span>,</span>
<span>               new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"K10_int"</span>,<span class='s'>"Psych_well_int"</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

We next add meta-data about each candidate predictor variable in the form of a `specific_predictors` object.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>, </span>
<span>               <span class='s'>"b_SpecificParameters@predictors_lup"</span>, </span>
<span>               short_name_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"K10_int"</span>,<span class='s'>"Psych_well_int"</span><span class='o'>)</span>,</span>
<span>               long_name_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Kessler Psychological Distress - 10 Item Total Score"</span>,</span>
<span>                                 <span class='s'>"Overall Wellbeing Measure (Winefield et al. 2012)"</span><span class='o'>)</span>,</span>
<span>               min_val_dbl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>10</span>,<span class='m'>18</span><span class='o'>)</span>,</span>
<span>               max_val_dbl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>50</span>,<span class='m'>90</span><span class='o'>)</span>,</span>
<span>               class_chr <span class='o'>=</span> <span class='s'>"integer"</span>,</span>
<span>               increment_dbl <span class='o'>=</span> <span class='m'>1</span>,</span>
<span>               class_fn_chr <span class='o'>=</span> <span class='s'>"as.integer"</span>,</span>
<span>               mdl_scaling_dbl <span class='o'>=</span> <span class='m'>0.01</span>,</span>
<span>               covariate_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

The `specific_predictors` object that we have added to `X` can be inspected using the `exhibitSlot` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@predictors_lup"</span>,</span>
<span>            scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
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
K10_int
</td>
<td style="text-align:right;">
Kessler Psychological Distress - 10 Item Total Score
</td>
<td style="text-align:left;">
10
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
as.integer
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
Psych_well_int
</td>
<td style="text-align:right;">
Overall Wellbeing Measure (Winefield et al. 2012)
</td>
<td style="text-align:left;">
18
</td>
<td style="text-align:right;">
90
</td>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
as.integer
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

</div>

### Covariates

We also specify the covariates that we aim to explore in conjunction with each candidate predictor.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>, </span>
<span>               <span class='s'>"b_SpecificParameters@candidate_covars_chr"</span>,</span>
<span>               new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_sex_birth_s"</span>, <span class='s'>"d_age"</span>,  <span class='s'>"d_sexual_ori_s"</span>, <span class='s'>"d_studying_working"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Descriptive variables

We also specify variables that we will use for generating descriptive statistics about the dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@descv_var_nms_chr"</span>,</span>
<span>               <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_age"</span>,<span class='s'>"Gender"</span>,<span class='s'>"d_relation_s"</span>,</span>
<span>                 <span class='s'>"d_sexual_ori_s"</span>, <span class='s'>"Region"</span>, <span class='s'>"d_studying_working"</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

### Temporal variables

The name of the dataset variable for data collection timepoint and all of its unique values were imported when converting the `ScorzEuroQol5` module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,<span class='s'>"a_YouthvarsProfile@timepoint_var_nm_1L_chr"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "Timepoint"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,<span class='s'>"a_YouthvarsProfile@timepoint_vals_chr"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "BL"  "FUP"</span></span></code></pre>

</div>

However, we also need to specify the name of the variable that contains the datestamp for each dataset record.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@msrmnt_date_var_nm_1L_chr"</span>,</span>
<span>               <span class='s'>"data_collection_dtm"</span><span class='o'>)</span></span></code></pre>

</div>

### Candidate models

`X` was created with a default set of candidate models, stored as a `specific_models` sub-module, which can be inspected using the `exhibitSlot` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@candidate_mdls_lup"</span>,</span>
<span>            scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Model types lookup table
</caption>
<thead>
<tr>
<th style="text-align:left;">
Reference
</th>
<th style="text-align:right;">
Name
</th>
<th style="text-align:right;">
Control
</th>
<th style="text-align:right;">
Familty
</th>
<th style="text-align:right;">
Function
</th>
<th style="text-align:right;">
Start
</th>
<th style="text-align:right;">
Predict
</th>
<th style="text-align:right;">
Transformation
</th>
<th style="text-align:left;">
Binomial
</th>
<th style="text-align:right;">
Acronym (Fixed)
</th>
<th style="text-align:right;">
Acronymy (Mixed)
</th>
<th style="text-align:right;">
Type (Mixed)
</th>
<th style="text-align:right;">
With
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
OLS_NTF
</td>
<td style="text-align:right;">
Ordinary Least Squares (no transformation)
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
lm
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NTF
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
OLS
</td>
<td style="text-align:right;">
LMM
</td>
<td style="text-align:right;">
linear mixed model
</td>
<td style="text-align:right;">
no transformation
</td>
</tr>
<tr>
<td style="text-align:left;">
OLS_LOG
</td>
<td style="text-align:right;">
Ordinary Least Squares (log transformation)
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
lm
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
LOG
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
OLS
</td>
<td style="text-align:right;">
LMM
</td>
<td style="text-align:right;">
linear mixed model
</td>
<td style="text-align:right;">
log transformation
</td>
</tr>
<tr>
<td style="text-align:left;">
OLS_LOGIT
</td>
<td style="text-align:right;">
Ordinary Least Squares (logit transformation)
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
lm
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
LOGIT
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
OLS
</td>
<td style="text-align:right;">
LMM
</td>
<td style="text-align:right;">
linear mixed model
</td>
<td style="text-align:right;">
logit transformation
</td>
</tr>
<tr>
<td style="text-align:left;">
OLS_LOGLOG
</td>
<td style="text-align:right;">
Ordinary Least Squares (log log transformation)
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
lm
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
LOGLOG
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
OLS
</td>
<td style="text-align:right;">
LMM
</td>
<td style="text-align:right;">
linear mixed model
</td>
<td style="text-align:right;">
log log transformation
</td>
</tr>
<tr>
<td style="text-align:left;">
OLS_CLL
</td>
<td style="text-align:right;">
Ordinary Least Squares (complementary log log transformation)
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
lm
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
CLL
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
OLS
</td>
<td style="text-align:right;">
LMM
</td>
<td style="text-align:right;">
linear mixed model
</td>
<td style="text-align:right;">
complementary log log transformation
</td>
</tr>
<tr>
<td style="text-align:left;">
GLM_GSN_LOG
</td>
<td style="text-align:right;">
Generalised Linear Model with Gaussian distribution and log link
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
gaussian(log)
</td>
<td style="text-align:right;">
glm
</td>
<td style="text-align:right;">
-0.1,-0.1
</td>
<td style="text-align:right;">
response
</td>
<td style="text-align:right;">
NTF
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
GLM
</td>
<td style="text-align:right;">
GLMM
</td>
<td style="text-align:right;">
generalised linear mixed model
</td>
<td style="text-align:right;">
Gaussian distribution and log link
</td>
</tr>
<tr>
<td style="text-align:left;">
BET_LGT
</td>
<td style="text-align:right;">
Beta Regression Model with Binomial distribution and logit link
</td>
<td style="text-align:right;">
betareg::betareg.control
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
betareg::betareg
</td>
<td style="text-align:right;">
-0.5,-0.1,3
</td>
<td style="text-align:right;">
response
</td>
<td style="text-align:right;">
NTF
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
GLM
</td>
<td style="text-align:right;">
GLMM
</td>
<td style="text-align:right;">
generalised linear mixed model
</td>
<td style="text-align:right;">
Binomial distribution and logit link
</td>
</tr>
<tr>
<td style="text-align:left;">
BET_CLL
</td>
<td style="text-align:right;">
Beta Regression Model with Binomial distribution and complementary log log link
</td>
<td style="text-align:right;">
betareg::betareg.control
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
betareg::betareg
</td>
<td style="text-align:right;">
-0.5,-0.1,3
</td>
<td style="text-align:right;">
response
</td>
<td style="text-align:right;">
NTF
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
GLM
</td>
<td style="text-align:right;">
GLMM
</td>
<td style="text-align:right;">
generalised linear mixed model
</td>
<td style="text-align:right;">
Binomial distribution and complementary log log link
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

We can choose to select just a subset of these to explore using the `renewSlot` method. As this is an illustrative example, we have restricted the models we will explore to just four types, passing the relevant row numbers to the `slice_indcs_int` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@candidate_mdls_lup"</span>,</span>
<span>               slice_indcs_int <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1L</span>,<span class='m'>5L</span>,<span class='m'>7L</span>,<span class='m'>8L</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Other parameters

Depending on the type of analysis we plan on undertaking, we can also specify parameters such as the number of folds to use in cross validation, the maximum number of model runs to allow and a seed to ensure reproducibility of results. In this case we are going to use the default values generated when we first created `X`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@folds_1L_int"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 10</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@max_mdl_runs_1L_int"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 300</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@seed_1L_int"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 1234</span></span></code></pre>

</div>

## Model testing

Before we start to use the data stored in `X` to undertake modelling, we must first validate that it contains all necessary (and internally consistent) data by using the `ratify` method. The call to `ratify` will update any variable names that are likely to cause problems when generating reports (e.g. through inclusion of characters like "\_" in the variable name that can cause problems when rendering LaTeX documents).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

### Set-up workspace

We add details of the directory to which we will write all output. In this example we create a temporary directory ([`tempdir()`](https://rdrr.io/r/base/tempfile.html)), but in practice this would be an existing directory on your local machine.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"paths_chr"</span>,</span>
<span>               <span class='nf'><a href='https://rdrr.io/r/base/tempfile.html'>tempdir</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

It can be useful to save fake data (useful for demonstrating the generalisability and replicability of an analysis) and real data (required for write-up and reproducibility) is distinctly labelled directories. By default, `X` is created with a flag to save all output in a sub-directory "Real". As we are using fake data, we can override this value.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"b_SpecificParameters@fake_1L_lgl"</span>,</span>
<span>               <span class='kc'>T</span><span class='o'>)</span></span></code></pre>

</div>

We can now write a number of sub-directories to our specified output directory.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            what_1L_chr <span class='o'>=</span> <span class='s'>"workspace"</span><span class='o'>)</span></span></code></pre>

</div>

### Descriptives

The first set of outputs we write to our output directories is a set of descriptive tables and plots.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            what_1L_chr <span class='o'>=</span> <span class='s'>"descriptives"</span>,</span>
<span>            digits_1L_int <span class='o'>=</span> <span class='m'>3L</span><span class='o'>)</span></span></code></pre>

</div>

### Model comparisons

The `investigate` method can now be used to compare the candidate models we have specified earlier. In so doing it will transform `X` into a `SpecificPredictors` object.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigate-methods.html'>investigate</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>                 depnt_var_max_val_1L_dbl <span class='o'>=</span> <span class='m'>0.99</span>,</span>
<span>                 session_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/utils/sessionInfo.html'>sessionInfo</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "SpecificPredictors"</span></span>
<span><span class='c'>#&gt; attr(,"package")</span></span>
<span><span class='c'>#&gt; [1] "specific"</span></span></code></pre>

</div>

The `investigate` method will write each model to be tested to a new sub-directory of our output directory.

<div class="highlight">

</div>

<div class="highlight">

</div>

The `investigate` method also outputs a table summarising the performance of each of the candidate models.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"mdl_cmprsn"</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span></span>
<span>        <span class='o'>)</span> </span>
</code></pre>
<table class=" lightable-paper lightable-hover" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
<caption>
Comparison of candidate models using highest correlated predictor
</caption>
<thead>
<tr>
<th style="empty-cells: hide;" colspan="1">
</th>
<th style="padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3">

<div style="TRUE">

Training model fit (averaged over 10 folds)

</div>

</th>
<th style="padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3">

<div style="TRUE">

Testing model fit (averaged over 10 folds)

</div>

</th>
</tr>
<tr>
<th style="text-align:left;">
Model
</th>
<th style="text-align:right;">
R-Squared
</th>
<th style="text-align:right;">
RMSE
</th>
<th style="text-align:right;">
MAE
</th>
<th style="text-align:left;">
R-Squared
</th>
<th style="text-align:right;">
RMSE
</th>
<th style="text-align:right;">
MAE
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Beta Regression Model with Binomial distribution and logit link
</td>
<td style="text-align:right;">
0.4318533
</td>
<td style="text-align:right;">
0.0742448
</td>
<td style="text-align:right;">
0.0587307
</td>
<td style="text-align:left;">
0.4128497
</td>
<td style="text-align:right;">
0.0741236
</td>
<td style="text-align:right;">
0.0587733
</td>
</tr>
<tr>
<td style="text-align:left;">
Beta Regression Model with Binomial distribution and complementary log log link
</td>
<td style="text-align:right;">
0.4174181
</td>
<td style="text-align:right;">
0.0751836
</td>
<td style="text-align:right;">
0.0593447
</td>
<td style="text-align:left;">
0.3996947
</td>
<td style="text-align:right;">
0.0750880
</td>
<td style="text-align:right;">
0.0594047
</td>
</tr>
<tr>
<td style="text-align:left;">
Ordinary Least Squares (no transformation)
</td>
<td style="text-align:right;">
0.4106104
</td>
<td style="text-align:right;">
0.0756222
</td>
<td style="text-align:right;">
0.0596955
</td>
<td style="text-align:left;">
0.3933147
</td>
<td style="text-align:right;">
0.0755461
</td>
<td style="text-align:right;">
0.0597672
</td>
</tr>
<tr>
<td style="text-align:left;">
Ordinary Least Squares (complementary log log transformation)
</td>
<td style="text-align:right;">
0.4105040
</td>
<td style="text-align:right;">
0.0756284
</td>
<td style="text-align:right;">
0.0597793
</td>
<td style="text-align:left;">
0.3913360
</td>
<td style="text-align:right;">
0.0755268
</td>
<td style="text-align:right;">
0.0598295
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

We can now identify the highest performing model in each category of candidate model based on the testing R<sup>2</sup> statistic.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procure-methods.html'>procure</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"prefd_mdls"</span><span class='o'>)</span> <span class='c'># Fix for NA_ returns (one option within ctg)</span></span>
<span><span class='c'>#&gt; [1] "BET_LGT" "OLS_NTF"</span></span></code></pre>

</div>

We can override these automated selections and instead incorporate other considerations (possibly based on judgments informed by visual inspection of the plots and the desirability of constraining predictions to a maximum value of one). We do this in the following command, specifying new preferred model types, in descending order of preference.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>           new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"BET_LGT"</span>, <span class='s'>"OLS_CLL"</span><span class='o'>)</span>,</span>
<span>           type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>           what_1L_chr <span class='o'>=</span> <span class='s'>"prefd_mdls"</span><span class='o'>)</span></span></code></pre>

</div>

### Use most preferred model to compare all candidate predictors

We can now compare all of our candidate predictors (with and without candidate covariates) using the most preferred model type.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigate-methods.html'>investigate</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "SpecificFixed"</span></span>
<span><span class='c'>#&gt; attr(,"package")</span></span>
<span><span class='c'>#&gt; [1] "specific"</span></span></code></pre>

</div>

Now, we compare the performance of single predictor models of our preferred model type (in our case, a Beta Regression Model with Binomial distribution and logit link) for each candidate predictor. The last call to the `investigate` saved the tested models along with model plots in a sub-directory of our output directory. These results are also viewable as a table.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"predr_cmprsn"</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>        scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Comparison of all candidate predictors using preferred model
</caption>
<thead>
<tr>
<th style="text-align:left;">
predr_chr
</th>
<th style="text-align:right;">
%IncMSE
</th>
<th style="text-align:left;">
IncNodePurity
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
K10
</td>
<td style="text-align:right;">
0.0066197
</td>
<td style="text-align:left;">
3.888246
</td>
</tr>
<tr>
<td style="text-align:left;">
Psychwell
</td>
<td style="text-align:right;">
0.0011094
</td>
<td style="text-align:left;">
2.342784
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

The most recent call to the `investigate` method also saved single predictor R model objects (one for each candidate predictors) along with the two plots for each model in a sub-directory of our output directory. The performance of each single predictor model can also be summarised in a table.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"fxd_sngl_cmprsn"</span><span class='o'>)</span></span>
</code></pre>
<table class=" lightable-paper lightable-hover" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;">
<caption>
Preferred single predictor model performance by candidate predictor
</caption>
<thead>
<tr>
<th style="empty-cells: hide;" colspan="1">
</th>
<th style="padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3">

<div style="TRUE">

Training model fit (averaged over 10 folds)

</div>

</th>
<th style="padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3">

<div style="TRUE">

Testing model fit (averaged over 10 folds)

</div>

</th>
</tr>
<tr>
<th style="text-align:left;">
Model
</th>
<th style="text-align:right;">
R-Squared
</th>
<th style="text-align:left;">
RMSE
</th>
<th style="text-align:right;">
MAE
</th>
<th style="text-align:left;">
R-Squared
</th>
<th style="text-align:right;">
RMSE
</th>
<th style="text-align:left;">
MAE
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
K10
</td>
<td style="text-align:right;">
0.4318533
</td>
<td style="text-align:left;">
0.0742448
</td>
<td style="text-align:right;">
0.0587307
</td>
<td style="text-align:left;">
0.4128497
</td>
<td style="text-align:right;">
0.0741236
</td>
<td style="text-align:left;">
0.0587733
</td>
</tr>
<tr>
<td style="text-align:left;">
Psychwell
</td>
<td style="text-align:right;">
0.1507472
</td>
<td style="text-align:left;">
0.0907813
</td>
<td style="text-align:right;">
0.0699606
</td>
<td style="text-align:left;">
0.1341090
</td>
<td style="text-align:right;">
0.0909203
</td>
<td style="text-align:left;">
0.0700686
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

Updated versions of each of the models in the previous step (this time with covariates added) are saved to a new subdirectory of the output directory and we can summarise the performance of each of the updated models, along with all signficant model terms, in a table.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"fxd_full_cmprsn"</span>,</span>
<span>        scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We can now identify which, if any, of the candidate covariates we previously specified are significant predictors in any of the models.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procure-methods.html'>procure</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"results"</span>,</span>
<span>        what_1L_chr <span class='o'>=</span> <span class='s'>"signt_covars"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] NA</span></span></code></pre>

</div>

We can override the covariates to select, potentially because we want to select only covariates that are significant for all or most of the models. However, in the below example we have opted not to do so and continue to use no covariates as selected by the algorithm in the previous step.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># X &lt;- renew(X,</span></span>
<span><span class='c'>#             new_val_xx = c("COVARIATE OF YOUR CHOICE", "ANOTHER COVARIATE"),</span></span>
<span><span class='c'>#                                               type_1L_chr = "results",</span></span>
<span><span class='c'>#                                   what_1L_chr = "prefd_covars")</span></span></code></pre>

</div>

### Test preferred model with preferred covariates for each candidate predictor

We now conclude our model testing by rerunning the previous step, except confining our covariates to those we prefer.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigate-methods.html'>investigate</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "SpecificMixed"</span></span>
<span><span class='c'>#&gt; attr(,"package")</span></span>
<span><span class='c'>#&gt; [1] "specific"</span></span></code></pre>

</div>

The previous call to the `write_mdls_with_covars_cmprsn` function saves the tested models along with two plots for each model in the "E_Predrs_W\_Covars_Sngl_Mdl_Cmprsn" sub-directory of "Output".

## Apply preferred model types and predictors to longitudinal data

The next main step is to use the preferred model types and covariates identified from the preceding analysis of cross-sectional data in longitudinal analysis.

### Longitudinal mixed modelling

Prior to undertaking longitudinal mixed modelling, we need to check the appropriateness of the default values for modelling parameters that are stored in `X`. These include the number of model iterations, and any custom control parameters and priors (by default, empty lists).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@iters_1L_int"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 4000</span></span></code></pre>

</div>

In many cases there will be no need to specify any custom control parameters or priors and using the defaults may speed up execution.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@control_ls"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [[1]]</span></span>
<span><span class='c'>#&gt; list()</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"b_SpecificParameters@prior_ls"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [[1]]</span></span>
<span><span class='c'>#&gt; list()</span></span></code></pre>

</div>

However, in this example using the default control parameters would result in warning messages suggesting a change to the adapt_delta control value (default = 0.8). Modifying the `adapt_delta` control parameter value can address this issue.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>             slot_nm_1L_chr <span class='o'>=</span> <span class='s'>"b_SpecificParameters@control_ls"</span>,</span>
<span>             new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>adapt_delta <span class='o'>=</span> <span class='m'>0.99</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/investigate-methods.html'>investigate</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "SpecificMixed"</span></span>
<span><span class='c'>#&gt; attr(,"package")</span></span>
<span><span class='c'>#&gt; [1] "specific"</span></span></code></pre>

</div>

The last call to `investigate` function wrote the models it tests to a sub-directory of the output directory along with plots for each model.

## Create shareable outputs

The model objects created by the preceding analysis are not suitable for sharing as they contain duplicates of the source dataset. To create model objects that can be shared (where dataset copies are replaced with fake data) use the `authorData` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorData-methods.html'>authorData</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

## Purge dataset copies

For the purposes of efficient computation, multiple objects containing copies of the source dataset were saved to our output directory during the analysis process. We therefore need to delete all of these copies by supplying "purge_write" to the `type_1L_chr` argument of the `author` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>       type_1L_chr <span class='o'>=</span> <span class='s'>"purge_write"</span><span class='o'>)</span></span></code></pre>

</div>

<!-- ## Share output -->
<!-- We can now publicly share our dataset and its associated metadata, using `Ready4useRepos` and its `share` method [as described in a vignette from the ready4use package](https://ready4-dev.github.io/ready4use/articles/V_01.html). -->

<div class="highlight">

</div>

A copy of the module `X` is available for download as the file `eq5d_ttu_SpecificMixed.RDS` from the ["Documentation_0.0" release of the specific package](https://github.com/ready4-dev/specific/releases/tag/Documentation_0.0).

