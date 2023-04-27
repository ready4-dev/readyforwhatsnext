---
title: "Authoring scientific manuscripts"
linkTitle: "Reporting"
date: "2023-01-09"
description: "Tools from the ready4show R package support authoring of scientific summaries of analyses with ready4."
weight: 92
tags:
- Programming
- Programming - literate
- Reporting
- Reporting - tutorials
- Software
- Software - libraries
- Software - libraries (ready4show)
- Status
- Status - development
categories:
- Documentation
output: hugodown::md_document
rmd_hash: fca3abb8efc9e205
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4show library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4show/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4show/blob/master/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4show/edit/master/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/'>ready4show</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/rstudio/bookdown'>bookdown</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/rstudio/rticles'>rticles</a></span><span class='o'>)</span></span></code></pre>

</div>

## Motivation

Open science workflows should ideally span an unbroken chain between data-ingest to production of a scientific summary such as a manuscript. Such extensive workflows provide an explicit means of linking all content in a scientific summary with the analysis that it reports.

## Implementation

`ready4show` includes a number of classes and methods that help integrate manuscript authoring into a reproducible workflow. These tools are principally intended for use with the [ready4 youth mental health system model](https://www.ready4-dev.com).

### Create a synopsis of the manuscript to be authored

To start with we create `X`, an instance of `Ready4showSynopsis`, a ready4 module (S4 class). We can use `X` to record metadata about the manuscript to be authored (including details about the study being summarised and the title and format of the intended output).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4show/reference/Ready4showSynopsis-class.html'>Ready4showSynopsis</a></span><span class='o'>(</span>background_1L_chr <span class='o'>=</span> <span class='s'>"Our study is entirely fictional."</span>,</span>
<span>                        coi_1L_chr <span class='o'>=</span> <span class='s'>"None declared."</span>,</span>
<span>                        conclusion_1L_chr <span class='o'>=</span> <span class='s'>"These fake results are not interesting."</span>,</span>
<span>                        digits_int <span class='o'>=</span> <span class='m'>3L</span>,</span>
<span>                        ethics_1L_chr <span class='o'>=</span> <span class='s'>"The study was reviewed and granted approval by Awesome University's Human Research Ethics Committee (1111111.1)."</span>,</span>
<span>                        funding_1L_chr <span class='o'>=</span> <span class='s'>"The study was funded by Generous Benefactor."</span>,</span>
<span>                        interval_chr <span class='o'>=</span> <span class='s'>"three months"</span>,</span>
<span>                        keywords_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"entirely"</span>,<span class='s'>"fake"</span>,<span class='s'>"do"</span>, <span class='s'>"not"</span>,<span class='s'>"cite"</span><span class='o'>)</span>,</span>
<span>                        outp_formats_chr <span class='o'>=</span> <span class='s'>"PDF"</span>,</span>
<span>                        sample_desc_1L_chr <span class='o'>=</span> <span class='s'>"The study sample is fake data that pretends to be young people aged 12 to 25 years who attended Australian primary care services for mental health related needs between November 2019 to August 2020."</span>,</span>
<span>                        title_1L_chr <span class='o'>=</span> <span class='s'>"A hypothetical study using fake data"</span><span class='o'>)</span></span></code></pre>

</div>

### Add authorship details

Authorship details can be added to slots of `X` that contain `ready4show_authors` and `ready4show_instututes` ready4 sub-modules.

As we can see from the below call to `exhibitSlot`, `X` was created with no authorship information.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"authors_r3"</span>,</span>
<span>            scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span> </span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
First-name
</th>
<th style="text-align:left;">
Middle-name
</th>
<th style="text-align:left;">
Last-name
</th>
<th style="text-align:left;">
Title
</th>
<th style="text-align:left;">
Qualifications
</th>
<th style="text-align:left;">
Institutes
</th>
<th style="text-align:left;">
Sequence Position
</th>
<th style="text-align:left;">
Corresponding
</th>
<th style="text-align:left;">
Email
</th>
<th style="text-align:left;">
Joint-first
</th>
</tr>
</thead>
<tbody>
<tr>
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

We can add details on each author by repeated calls to the `renewSlot` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>          <span class='s'>"authors_r3"</span>,</span>
<span>          first_nm_chr <span class='o'>=</span> <span class='s'>"Alejandra"</span>,</span>
<span>          middle_nm_chr <span class='o'>=</span> <span class='s'>"Rocio"</span>,</span>
<span>          last_nm_chr <span class='o'>=</span> <span class='s'>"Scienceace"</span>,</span>
<span>          title_chr <span class='o'>=</span> <span class='s'>"Dr"</span>,</span>
<span>          qualifications_chr <span class='o'>=</span> <span class='s'>"MD, PhD"</span>,</span>
<span>          institute_chr <span class='o'>=</span> <span class='s'>"Institute_A, Institute_B"</span>,</span>
<span>          sequence_int <span class='o'>=</span> <span class='m'>1</span>,</span>
<span>          is_corresponding_lgl <span class='o'>=</span> <span class='kc'>T</span>,</span>
<span>          email_chr <span class='o'>=</span> <span class='s'>"fake_email@fake_institute.com"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"authors_r3"</span>,</span>
<span>            first_nm_chr <span class='o'>=</span> <span class='s'>"Fionn"</span>,</span>
<span>            middle_nm_chr <span class='o'>=</span> <span class='s'>"Seamus"</span>,</span>
<span>            last_nm_chr <span class='o'>=</span> <span class='s'>"Researchchamp"</span>,</span>
<span>            title_chr <span class='o'>=</span> <span class='s'>"Prof"</span>,</span>
<span>            qualifications_chr <span class='o'>=</span> <span class='s'>"MSc, PhD"</span>,</span>
<span>            institute_chr <span class='o'>=</span> <span class='s'>"Institute_C, Institute_B"</span>,</span>
<span>            sequence_int <span class='o'>=</span> <span class='m'>2</span>,</span>
<span>            email_chr <span class='o'>=</span> <span class='s'>"fake_email@unreal_institute.com"</span><span class='o'>)</span> </span></code></pre>

</div>

The updated authorship table can now be inspected.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"authors_r3"</span>,</span>
<span>              scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span> </span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
First-name
</th>
<th style="text-align:right;">
Middle-name
</th>
<th style="text-align:left;">
Last-name
</th>
<th style="text-align:right;">
Title
</th>
<th style="text-align:left;">
Qualifications
</th>
<th style="text-align:right;">
Institutes
</th>
<th style="text-align:left;">
Sequence Position
</th>
<th style="text-align:right;">
Corresponding
</th>
<th style="text-align:left;">
Email
</th>
<th style="text-align:right;">
Joint-first
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Alejandra
</td>
<td style="text-align:right;">
Rocio
</td>
<td style="text-align:left;">
Scienceace
</td>
<td style="text-align:right;">
Dr
</td>
<td style="text-align:left;">
MD, PhD
</td>
<td style="text-align:right;">
Institute_A, Institute_B
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
TRUE
</td>
<td style="text-align:left;">
<fake_email@fake>\_institute.com
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
Fionn
</td>
<td style="text-align:right;">
Seamus
</td>
<td style="text-align:left;">
Researchchamp
</td>
<td style="text-align:right;">
Prof
</td>
<td style="text-align:left;">
MSc, PhD
</td>
<td style="text-align:right;">
Institute_C, Institute_B
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
<fake_email@unreal>\_institute.com
</td>
<td style="text-align:right;">
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

</div>

We now need to add additional information for each author institute.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>          <span class='s'>"institutes_r3"</span>,</span>
<span>          short_name_chr <span class='o'>=</span> <span class='s'>"Institute_A"</span>, </span>
<span>          long_name_chr <span class='o'>=</span> <span class='s'>"Awesome University, Shanghai"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"institutes_r3"</span>,</span>
<span>            short_name_chr <span class='o'>=</span> <span class='s'>"Institute_B"</span>, </span>
<span>            long_name_chr <span class='o'>=</span> <span class='s'>"August Institution, London"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='s'>"institutes_r3"</span>,</span>
<span>            new_val_xx <span class='o'>=</span> <span class='s'>"use_renew_mthd"</span>,</span>
<span>            short_name_chr <span class='o'>=</span> <span class='s'>"Institute_C"</span>, </span>
<span>            long_name_chr <span class='o'>=</span> <span class='s'>"Highly Ranked Uni, Montreal"</span><span class='o'>)</span></span></code></pre>

</div>

The updated institutes table can now be inspected.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"institutes_r3"</span>,</span>
<span>              scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span> </span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Reference
</th>
<th style="text-align:right;">
Name
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Institute_A
</td>
<td style="text-align:right;">
Awesome University, Shanghai
</td>
</tr>
<tr>
<td style="text-align:left;">
Institute_B
</td>
<td style="text-align:right;">
August Institution, London
</td>
</tr>
<tr>
<td style="text-align:left;">
Institute_C
</td>
<td style="text-align:right;">
Highly Ranked Uni, Montreal
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

### Add correspondences

We can also add a look-up table about any changes we wish to make from the analysis code of how names of variables / parameters are presented in the manuscript text.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"correspondences_r3"</span>,</span>
<span>               old_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ9"</span>, <span class='s'>"GAD7"</span><span class='o'>)</span>,</span>
<span>               new_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"PHQ-9"</span>, <span class='s'>"GAD-7"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

These edits can now be inspected with a call to `exhibitSlot`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"correspondences_r3"</span>,</span>
<span>              scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span> <span class='c'># Add Exhibit Method</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Old name
</th>
<th style="text-align:right;">
New name
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
PHQ9
</td>
<td style="text-align:right;">
PHQ-9
</td>
</tr>
<tr>
<td style="text-align:left;">
GAD7
</td>
<td style="text-align:right;">
GAD-7
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

### Specify output directory

We now update `X` with details of the directory to which we wish to write the manuscript we are authoring and all its supporting files.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"a_Ready4showPaths@outp_data_dir_1L_chr"</span>,</span>
<span>               new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/tempfile.html'>tempdir</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

### Create dataset of literate programming files

Our next step is to copy a dataset of files that can implement a literate program to generate our manuscript. If you have a template you wish to work with, you can specify its local path using the `a_Ready4showPaths@mkdn_source_dir_1L_chr` slot of the `X`. Skip this step if you wish to use [the default markdown dataset](https://github.com/ready4-dev/ms_tmpl), which leverages popular rmarkdown toolkits such as `bookdown` and `rticles`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>## Not run</span></span>
<span><span class='c'># procureSlot(X,</span></span>
<span><span class='c'>#             "a_Ready4showPaths@mkdn_source_dir_1L_chr",</span></span>
<span><span class='c'>#             new_val_xx  = "PATH TO MARKDOWN DATASET")</span></span></code></pre>

</div>

We create the dataset copy with the `authorData` method.

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorData-methods.html'>authorData</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

Having created a local copy of the template literate program files dataset, it is now possible to manually edit the markdown files to author the manuscript. However, in this example we are skipping this step and will continue to use the unedited template in conjunction with the metadata we have specified in `X`. We combine the two to author a manuscript using the `authorReport` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorReport-methods.html'>authorReport</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span></code></pre>

</div>

If we wish, we can now ammend `X` and then rerun the `authorReport` method to generate Word and HTML versions of the manuscript.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>          <span class='s'>"outp_formats_chr"</span>,</span>
<span>          new_val_xx <span class='o'>=</span> <span class='s'>"Word"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorReport-methods.html'>authorReport</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>          <span class='s'>"outp_formats_chr"</span>,</span>
<span>          new_val_xx <span class='o'>=</span> <span class='s'>"HTML"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/authorReport-methods.html'>authorReport</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

</div>

The outputed files are as follows:

-   [PDF version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.pdf) (and [LaTeX file that generated it](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.tex))
-   [Word version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.docx)
-   [HTML version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.html)

<div class="highlight">

</div>

