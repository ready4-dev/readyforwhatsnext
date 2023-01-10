---
title: "Add a data dictionary to a dataset"
linkTitle: "Labelling"
date: "2022-12-24"
description: "Pairing a dataset with its dictionary makes it easier to interpret. This tutorial describes how a module from the ready4use R package can help you to pair a dataset and its dictionary."
weight: 92
categories: 
- Documentation
tags: 
- Data
- Data - management
- Data - metadata
- Framework
- Framework - authoring-tools
- Framework - authoring-tools (datasets)
- Software
- Software - libraries
- Software - libraries (ready4use)
output: hugodown::md_document
rmd_hash: 5cdadbe71ab9332f
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4use library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4use/articles/V_02.html)
-   [view the source file](https://github.com/ready4-dev/ready4use/blob/master/vignettes/V_02.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4use/edit/master/vignettes/V_02.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

Note: **This vignette is illustrated with fake data**. The dataset explored in this example should not be used to inform decision-making.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span></code></pre>

</div>

ready4use includes a number of tools for labeling data used in conjunction with the [ready4 open source model of youth mental health systems](https://www.ready4-dev.com).

## Create a dataset-dictionary pair

A data dictionary containts useful metadata about a dataset. We can ingest examples of a fake dataset and its data-dictionary [using the method explained in another vignette](V_01.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>objects_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>dv_nm_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span>,</span>
<span>                    dv_ds_nm_1L_chr <span class='o'>=</span> <span class='s'>"https://doi.org/10.7910/DVN/HJXYKQ"</span>,</span>
<span>                    dv_server_1L_chr <span class='o'>=</span> <span class='s'>"dataverse.harvard.edu"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

Importantly (and a requirement for subsequent steps), the data dictionary we ingest is a `ready4use_dictionary` object.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/class.html'>class</a></span><span class='o'>(</span><span class='nv'>objects_ls</span><span class='o'>$</span><span class='nv'>eq5d_ds_dict</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "ready4use_dictionary" "ready4_dictionary"    "tbl_df"              </span></span>
<span><span class='c'>#&gt; [4] "tbl"                  "data.frame"</span></span></code></pre>

</div>

We can now pair the data dictionary with its dataset in a new object `X`, a `Ready4useDyad`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useDyad-class.html'>Ready4useDyad</a></span><span class='o'>(</span>ds_tb <span class='o'>=</span> <span class='nv'>objects_ls</span><span class='o'>$</span><span class='nv'>eq5d_ds_tb</span>,</span>
<span>                   dictionary_r3 <span class='o'>=</span> <span class='nv'>objects_ls</span><span class='o'>$</span><span class='nv'>eq5d_ds_dict</span><span class='o'>)</span></span></code></pre>

</div>

## Inspect data

We can inspect `X` by printing selected information about it to console using the `exhibit` method. If we only wish to see the first or last few records, we can pass "head" or "tail" to the `display_1L_chr` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>         display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>,</span>
<span>         scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
uid
</th>
<th style="text-align:right;">
Timepoint
</th>
<th style="text-align:right;">
data_collection_dtm
</th>
<th style="text-align:right;">
d_age
</th>
<th style="text-align:right;">
Gender
</th>
<th style="text-align:right;">
d_sex_birth_s
</th>
<th style="text-align:left;">
d_sexual_ori_s
</th>
<th style="text-align:right;">
d_relation_s
</th>
<th style="text-align:right;">
d_ATSI
</th>
<th style="text-align:right;">
CALD
</th>
<th style="text-align:right;">
Region
</th>
<th style="text-align:right;">
d_studying_working
</th>
<th style="text-align:left;">
eq5dq_MO
</th>
<th style="text-align:right;">
eq5dq_SC
</th>
<th style="text-align:right;">
eq5dq_UA
</th>
<th style="text-align:right;">
eq5dq_PD
</th>
<th style="text-align:right;">
eq5dq_AD
</th>
<th style="text-align:right;">
K10_int
</th>
<th style="text-align:left;">
Psych_well_int
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

The dataset may be more meaningful if variables are labelled using the descriptive information from the data dictionary. This can be accomplished using the `renew` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>           type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>,</span>
<span>         scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

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

To remove dataset labels, use the `renew` method with "unlabel" passed to the `type_1L_chr` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>           type_1L_chr <span class='o'>=</span> <span class='s'>"unlabel"</span><span class='o'>)</span></span></code></pre>

</div>

By default, the `exhibit` method will print the dataset part of the `Ready4useDyad` instance. To inspect the data dictionary, pass "dict" to the `type_1L_chr` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>        display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>,</span>
<span>        type_1L_chr <span class='o'>=</span> <span class='s'>"dict"</span>,</span>
<span>        scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Data Dictionary
</caption>
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
Category
</th>
<th style="text-align:right;">
Description
</th>
<th style="text-align:right;">
Class
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
CALD
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
Culturally And Linguistically Diverse
</td>
<td style="text-align:right;">
factor
</td>
</tr>
<tr>
<td style="text-align:left;">
d_age
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
age
</td>
<td style="text-align:right;">
integer
</td>
</tr>
<tr>
<td style="text-align:left;">
d_ATSI
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
Aboriginal or Torres Strait Islander
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
d_relation_s
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
relationship status
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
d_sex_birth_s
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
sex at birth
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
d_sexual_ori_s
</td>
<td style="text-align:right;">
demographic
</td>
<td style="text-align:right;">
sexual orientation
</td>
<td style="text-align:right;">
factor
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

