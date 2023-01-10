---
title: "Authoring model data structures"
linkTitle: "Data structures"
date: "2022-12-24"
description: "The ready4class R package supports partially automated and standardised workflows for defining the data structures to be used in computational models."
weight: 62
categories: 
- Documentation
tags: 
- Framework - authoring tools
- Framework - authoring tools (modules)
- Model
- Model - modules
- Software
- Software - libraries
- Software - libraries (ready4class)
output: hugodown::md_document
rmd_hash: ad8ed2bbfcbb6261
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4class library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4class/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4class/blob/master/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4class/edit/master/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4class/'>ready4class</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/'>ready4show</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span></code></pre>

</div>

## Motivation

The [ready4 model](https://www.ready4-dev.com/) uses [object oriented programming (OOP)](https://ready4-dev.github.io/ready4/articles/V_03.html) to implement [modular approaches to computational models of mental health systems](https://ready4-dev.github.io/ready4/articles/V_01.html). That means that a standardised approach to developing modules (S4 classes) and sub-modules (S3 classes) is required. ready4class provides the tools to implement this workflow.

## Workflow

### Prototyes, constructor and manifest

The main classes exported as part of `ready4class` are `readyclass_manifest` and `ready4class_constructor`. `ready4class_pt_lup` is a tibble based [ready4 sub-module](https://ready4-dev.github.io/ready4/articles/V_01.html), which contains metadata on the prototypes of classes that can be used as sub-components of ready4 modules and sub-modules (for example a tibble based class can be used as a slot in an S4 class). When authoring ready4 R packages, you will create a `ready4class_pt_lup` instance and store it in an online repository that you have write permissions to. As you create new ready4 modules and sub-modules using `ready4class` tools, your `ready4class_pt_lup` object will be updated so that these classes can be made available to any future modules or sub-modules that you author. The `ready4class_pt_lup` sub-module recently used in workflows for authoring ready4 modules is reproduced below.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>x</span> <span class='o'>&lt;-</span> <span class='nf'>ready4use</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/ready4"</span>,</span>
<span>                               gh_tag_1L_chr <span class='o'>=</span> <span class='s'>"Documentation_0.0"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>fls_to_ingest_chr <span class='o'>=</span> <span class='s'>"prototype_lup"</span>,</span>
<span>         metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span> </span>
<span><span class='nv'>x</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Class Prototypes Lookup Table
</caption>
<thead>
<tr>
<th style="text-align:left;">
Class
</th>
<th style="text-align:right;">
Value
</th>
<th style="text-align:right;">
Namespace
</th>
<th style="text-align:right;">
Function
</th>
<th style="text-align:right;">
Default
</th>
<th style="text-align:right;">
Is Old Class
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
character
</td>
<td style="text-align:right;">
NA_character\_
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
NA_character\_
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
data.frame
</td>
<td style="text-align:right;">
data.frame()
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
data.frame()
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
integer
</td>
<td style="text-align:right;">
NA_integer\_
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
NA_integer\_
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
list
</td>
<td style="text-align:right;">
list(list())
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
list
</td>
<td style="text-align:right;">
list()
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
logical
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:right;">
NA_real\_
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
NA_real\_
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
POSIXt
</td>
<td style="text-align:right;">
.POSIXct(NA_character\_)
</td>
<td style="text-align:right;">
base
</td>
<td style="text-align:right;">
.POSIXct
</td>
<td style="text-align:right;">
NA_character\_
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
dfidx
</td>
<td style="text-align:right;">
dfidx::dfidx(dfidx())
</td>
<td style="text-align:right;">
dfidx
</td>
<td style="text-align:right;">
dfidx
</td>
<td style="text-align:right;">
dfidx()
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4Module
</td>
<td style="text-align:right;">
ready4::Ready4Module()
</td>
<td style="text-align:right;">
ready4
</td>
<td style="text-align:right;">
Ready4Module
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4Private
</td>
<td style="text-align:right;">
ready4::Ready4Private()
</td>
<td style="text-align:right;">
ready4
</td>
<td style="text-align:right;">
Ready4Private
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4Public
</td>
<td style="text-align:right;">
ready4::Ready4Public()
</td>
<td style="text-align:right;">
ready4
</td>
<td style="text-align:right;">
Ready4Public
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
sf
</td>
<td style="text-align:right;">
sf::st_sf(sf::st_sfc())
</td>
<td style="text-align:right;">
sf
</td>
<td style="text-align:right;">
st_sf
</td>
<td style="text-align:right;">
sf::st_sfc()
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
tbl_df
</td>
<td style="text-align:right;">
tibble::tibble()
</td>
<td style="text-align:right;">
tibble
</td>
<td style="text-align:right;">
tibble
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4show_authors
</td>
<td style="text-align:right;">
ready4show::ready4show_authors()
</td>
<td style="text-align:right;">
ready4show
</td>
<td style="text-align:right;">
ready4show_authors
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4show_institutes
</td>
<td style="text-align:right;">
ready4show::ready4show_institutes()
</td>
<td style="text-align:right;">
ready4show
</td>
<td style="text-align:right;">
ready4show_institutes
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4show_correspondences
</td>
<td style="text-align:right;">
ready4show::ready4show_correspondences()
</td>
<td style="text-align:right;">
ready4show
</td>
<td style="text-align:right;">
ready4show_correspondences
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4showPaths
</td>
<td style="text-align:right;">
ready4show::Ready4showPaths()
</td>
<td style="text-align:right;">
ready4show
</td>
<td style="text-align:right;">
Ready4showPaths
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4showSynopsis
</td>
<td style="text-align:right;">
ready4show::Ready4showSynopsis()
</td>
<td style="text-align:right;">
ready4show
</td>
<td style="text-align:right;">
Ready4showSynopsis
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use_distributions
</td>
<td style="text-align:right;">
ready4use::ready4use_distributions()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
ready4use_distributions
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use_dataverses
</td>
<td style="text-align:right;">
ready4use::ready4use_dataverses()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
ready4use_dataverses
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use_imports
</td>
<td style="text-align:right;">
ready4use::ready4use_imports()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
ready4use_imports
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use_mapes
</td>
<td style="text-align:right;">
ready4use::ready4use_mapes()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
ready4use_mapes
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use_dictionary
</td>
<td style="text-align:right;">
ready4use::ready4use_dictionary()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
ready4use_dictionary
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useFiles
</td>
<td style="text-align:right;">
ready4use::Ready4useFiles()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useFiles
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useRaw
</td>
<td style="text-align:right;">
ready4use::Ready4useRaw()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useRaw
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useProcessed
</td>
<td style="text-align:right;">
ready4use::Ready4useProcessed()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useProcessed
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useArguments
</td>
<td style="text-align:right;">
ready4use::Ready4useArguments()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useArguments
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useDyad
</td>
<td style="text-align:right;">
ready4use::Ready4useDyad()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useDyad
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useIngest
</td>
<td style="text-align:right;">
ready4use::Ready4useIngest()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useIngest
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useRepos
</td>
<td style="text-align:right;">
ready4use::Ready4useRepos()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useRepos
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4usePointer
</td>
<td style="text-align:right;">
ready4use::Ready4usePointer()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4usePointer
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
Ready4useRecord
</td>
<td style="text-align:right;">
ready4use::Ready4useRecord()
</td>
<td style="text-align:right;">
ready4use
</td>
<td style="text-align:right;">
Ready4useRecord
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_badges
</td>
<td style="text-align:right;">
ready4fun::ready4fun_badges()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_badges
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_abbreviations
</td>
<td style="text-align:right;">
ready4fun::ready4fun_abbreviations()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_abbreviations
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_objects
</td>
<td style="text-align:right;">
ready4fun::ready4fun_objects()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_objects
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_functions
</td>
<td style="text-align:right;">
ready4fun::ready4fun_functions()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_functions
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_executor
</td>
<td style="text-align:right;">
ready4fun::ready4fun_executor()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_executor
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_description
</td>
<td style="text-align:right;">
ready4fun::ready4fun_description()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_description
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_metadata_a
</td>
<td style="text-align:right;">
ready4fun::ready4fun_metadata_a()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_metadata_a
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_metadata_b
</td>
<td style="text-align:right;">
ready4fun::ready4fun_metadata_b()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_metadata_b
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_manifest
</td>
<td style="text-align:right;">
ready4fun::ready4fun_manifest()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_manifest
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4fun_dataset
</td>
<td style="text-align:right;">
ready4fun::ready4fun_dataset()
</td>
<td style="text-align:right;">
ready4fun
</td>
<td style="text-align:right;">
ready4fun_dataset
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4class_constructor
</td>
<td style="text-align:right;">
ready4class::ready4class_constructor()
</td>
<td style="text-align:right;">
ready4class
</td>
<td style="text-align:right;">
ready4class_constructor
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4class_pt_lup
</td>
<td style="text-align:right;">
ready4class::ready4class_pt_lup()
</td>
<td style="text-align:right;">
ready4class
</td>
<td style="text-align:right;">
ready4class_pt_lup
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4class_manifest
</td>
<td style="text-align:right;">
ready4class::ready4class_manifest()
</td>
<td style="text-align:right;">
ready4class
</td>
<td style="text-align:right;">
ready4class_manifest
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4pack_manifest
</td>
<td style="text-align:right;">
ready4pack::ready4pack_manifest()
</td>
<td style="text-align:right;">
ready4pack
</td>
<td style="text-align:right;">
ready4pack_manifest
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_aqol6d_adol
</td>
<td style="text-align:right;">
youthvars::youthvars_aqol6d_adol()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_aqol6d_adol
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_phq9
</td>
<td style="text-align:right;">
youthvars::youthvars_phq9()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_phq9
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_bads
</td>
<td style="text-align:right;">
youthvars::youthvars_bads()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_bads
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_gad7
</td>
<td style="text-align:right;">
youthvars::youthvars_gad7()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_gad7
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_oasis
</td>
<td style="text-align:right;">
youthvars::youthvars_oasis()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_oasis
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_scared
</td>
<td style="text-align:right;">
youthvars::youthvars_scared()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_scared
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_k6
</td>
<td style="text-align:right;">
youthvars::youthvars_k6()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_k6
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
youthvars_sofas
</td>
<td style="text-align:right;">
youthvars::youthvars_sofas()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
youthvars_sofas
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
YouthvarsDescriptives
</td>
<td style="text-align:right;">
youthvars::YouthvarsDescriptives()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
YouthvarsDescriptives
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
YouthvarsProfile
</td>
<td style="text-align:right;">
youthvars::YouthvarsProfile()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
YouthvarsProfile
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
YouthvarsSeries
</td>
<td style="text-align:right;">
youthvars::YouthvarsSeries()
</td>
<td style="text-align:right;">
youthvars
</td>
<td style="text-align:right;">
YouthvarsSeries
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ScorzProfile
</td>
<td style="text-align:right;">
scorz::ScorzProfile()
</td>
<td style="text-align:right;">
scorz
</td>
<td style="text-align:right;">
ScorzProfile
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ScorzAqol6
</td>
<td style="text-align:right;">
scorz::ScorzAqol6()
</td>
<td style="text-align:right;">
scorz
</td>
<td style="text-align:right;">
ScorzAqol6
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ScorzAqol6Adol
</td>
<td style="text-align:right;">
scorz::ScorzAqol6Adol()
</td>
<td style="text-align:right;">
scorz
</td>
<td style="text-align:right;">
ScorzAqol6Adol
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ScorzAqol6Adult
</td>
<td style="text-align:right;">
scorz::ScorzAqol6Adult()
</td>
<td style="text-align:right;">
scorz
</td>
<td style="text-align:right;">
ScorzAqol6Adult
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
ScorzEuroQol5
</td>
<td style="text-align:right;">
scorz::ScorzEuroQol5()
</td>
<td style="text-align:right;">
scorz
</td>
<td style="text-align:right;">
ScorzEuroQol5
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
specific_models
</td>
<td style="text-align:right;">
specific::specific_models()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
specific_models
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
specific_predictors
</td>
<td style="text-align:right;">
specific::specific_predictors()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
specific_predictors
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificParameters
</td>
<td style="text-align:right;">
specific::SpecificParameters()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificParameters
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificPrivate
</td>
<td style="text-align:right;">
specific::SpecificPrivate()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificPrivate
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificShareable
</td>
<td style="text-align:right;">
specific::SpecificShareable()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificShareable
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificResults
</td>
<td style="text-align:right;">
specific::SpecificResults()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificResults
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificProject
</td>
<td style="text-align:right;">
specific::SpecificProject()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificProject
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificInitiator
</td>
<td style="text-align:right;">
specific::SpecificInitiator()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificInitiator
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificModels
</td>
<td style="text-align:right;">
specific::SpecificModels()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificModels
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificPredictors
</td>
<td style="text-align:right;">
specific::SpecificPredictors()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificPredictors
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificFixed
</td>
<td style="text-align:right;">
specific::SpecificFixed()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificFixed
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificMixed
</td>
<td style="text-align:right;">
specific::SpecificMixed()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificMixed
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificConverter
</td>
<td style="text-align:right;">
specific::SpecificConverter()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificConverter
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
SpecificSynopsis
</td>
<td style="text-align:right;">
specific::SpecificSynopsis()
</td>
<td style="text-align:right;">
specific
</td>
<td style="text-align:right;">
SpecificSynopsis
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
TTUSynopsis
</td>
<td style="text-align:right;">
TTUSynopsis()
</td>
<td style="text-align:right;">
TTU
</td>
<td style="text-align:right;">
TTUSynopsis
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
TTUReports
</td>
<td style="text-align:right;">
TTUReports()
</td>
<td style="text-align:right;">
TTU
</td>
<td style="text-align:right;">
TTUReports
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
FALSE
</td>
</tr>
<tr>
<td style="text-align:left;">
TTUProject
</td>
<td style="text-align:right;">
TTUProject()
</td>
<td style="text-align:right;">
TTU
</td>
<td style="text-align:right;">
TTUProject
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
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

`ready4class_constructor` is another tibble based ready4 sub-module that summarises the desired features of the ready4 modules and sub-modules that you are authoring. An instance of `ready4class_constructor` is combined with a [`ready4fun_manifest` sub-module](https://ready4-dev.github.io/ready4fun/articles/V_01.html) to create a `ready4class_manifest` sub-module. Instances of `ready4class_constructor` are most efficiently created using the `make_pt_ready4class_constructor` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4class/reference/ready4class_manifest.html'>make_pt_ready4class_manifest</a></span><span class='o'>(</span><span class='nf'>ready4fun</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/ready4fun_manifest.html'>ready4fun_manifest</a></span><span class='o'>(</span><span class='o'>)</span>,</span>
<span>                                  constructor_r3 <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4class/reference/ready4class_constructor.html'>ready4class_constructor</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4class/reference/ready4class_manifest.html'>ready4class_manifest</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

### Typical use

The most important method included in `ready4class` is the `author` method for the `ready4class_manifest` sub-module, that enhances [the `author` method defined for the `ready4fun_manifest`](https://ready4-dev.github.io/ready4fun/articles/V_01.html) so that consistently documented R package classes are also generated.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>## Not run</span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>y</span><span class='o'>)</span></span></code></pre>

</div>

### Examples

`ready4class` sub-modules and methods are not intended for independent use, but instead should be deployed as part of [ready4pack R package authoring workflow](https://ready4-dev.github.io/ready4pack/articles/V_01.html).

## Future documentation

It should be noted that some `ready4class` methods require files of a standardised format to be saved in specific sub-directories of the package `data-raw` directory. Detailed instructions on how to prepare these files are not yet available, but will be outlined in documentation to be released in 2022.

