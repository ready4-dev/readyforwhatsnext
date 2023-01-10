---
title: "Authoring model algorithms"
linkTitle: "Algorithms"
date: "2022-12-24"
description: "The ready4fun R package supports standardised approaches to code authoring that facilitate partial automation of the documenting of model algorithms."
weight: 64
categories: 
- Documentation
tags: 
- Framework - authoring tools
- Framework - authoring tools (modules)
- Framework - conventions
- Software
- Software - functions
- Software - libraries
- Software - libraries (ready4fun)
output: hugodown::md_document
rmd_hash: 481afc8d670cccda
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4fun library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4fun/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4fun/blob/master/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4fun/edit/master/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4fun/'>ready4fun</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4show/'>ready4show</a></span><span class='o'>)</span></span></code></pre>

</div>

## Motivation

The [ready4 youth mental health systems model](https://www.ready4-dev.com/) is [implemented using an object-oriented programming (OOP) approach](https://ready4-dev.github.io/ready4class/articles/V_01.html). One motivation for using OOP is the concept of "abstraction" - making things as simple as possible for end-users of `ready4` modules by exposing the minimal amount of code required to implement each method.

However, some users of the `ready4` modules will want to "look under the hood" and examine the code that implements module algorithms in much more detail. Reasons to do so include to:

-   gain detailed insight into how methods are implemented;
-   test individual sub-components ("functions") of methods as part of code verification and model validation checks;
-   re-use functions when authoring new methods.

Therefore when authoring `ready4` code libraries, it is important to ensure that "under the hood" code can be readily understood. Two ways for achieving this goal is to ensure that all functions (even those not intended for use by modeller end-users) are adequately documented and adopt a consistent house style (e.g. naming conventions). ready4fun provides workflow tools (classes, methods, functions and datasets) to achieve these goals.

## ready4fun function authoring taxonomies, abbreviations and workflow

The `ready4fun` package uses a dataset of taxonomies and abbreviations to ensure standardised function code style and documentation. A copy of this dataset (`dataset_ls`) can be downloaded from a repository associated with the [ready4 package](https://ready4-dev.github.io/ready4/) using tools from the [ready4use package](https://ready4-dev.github.io/ready4use/) package.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>dataset_ls</span> <span class='o'>&lt;-</span> <span class='nf'>ready4use</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useRepos-class.html'>Ready4useRepos</a></span><span class='o'>(</span>gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/ready4"</span>,</span>
<span>                               gh_tag_1L_chr <span class='o'>=</span> <span class='s'>"Documentation_0.0"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ingest-methods.html'>ingest</a></span><span class='o'>(</span>metadata_1L_lgl <span class='o'>=</span> <span class='kc'>F</span><span class='o'>)</span></span></code></pre>

</div>

### Function names begin with a meaningful verb

Consistent with a naming convention popular in the R development community, all `ready4` framework functions begin with a verb. Furthermore, the choice of verb is meaningful - it communicates something about the type of task a function implements. For example, all functions beginning with the word "fit" will fit a model of a specified type to a dataset. The definitions of all meaningful verbs currently used by ready4 functions (excluding methods) are stored in element `fn_types_lup` of `dataset_ls`, the key features of which are reproduced below.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>dataset_ls</span><span class='o'>$</span><span class='nv'>fn_types_lup</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/ready4fun_functions.html'>ready4fun_functions</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span>filter_cdn_1L_chr <span class='o'>=</span> <span class='s'>"!is_generic_lgl &amp; !stringr::str_detect(fn_type_nm_chr, pattern = ' ')"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>select_int <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='m'>2</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Meaningful verbs
</caption>
<thead>
<tr>
<th style="text-align:left;">
Verb
</th>
<th style="text-align:right;">
Description
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Add
</td>
<td style="text-align:right;">
Updates an object by adding data to that object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Assert
</td>
<td style="text-align:right;">
Validates that an object conforms to required condition(s). If the object does not meet all required conditions, program execution will be stopped and an error message provided.
</td>
</tr>
<tr>
<td style="text-align:left;">
Bind
</td>
<td style="text-align:right;">
Binds two objects together to create a composite object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Calculate
</td>
<td style="text-align:right;">
Performs a numeric calculation.
</td>
</tr>
<tr>
<td style="text-align:left;">
Close
</td>
<td style="text-align:right;">
Closes specified connections.
</td>
</tr>
<tr>
<td style="text-align:left;">
Extract
</td>
<td style="text-align:right;">
Extracts data from an object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Fit
</td>
<td style="text-align:right;">
Fits a model of a specified type to a dataset
</td>
</tr>
<tr>
<td style="text-align:left;">
Force
</td>
<td style="text-align:right;">
Checks if a specified local or global environmental condition is met and if not, updates the specified environment to comply with the condition.
</td>
</tr>
<tr>
<td style="text-align:left;">
Format
</td>
<td style="text-align:right;">
Modifies the format of an output.
</td>
</tr>
<tr>
<td style="text-align:left;">
Get
</td>
<td style="text-align:right;">
Retrieves a pre-existing data object from memory, local file system or online repository.
</td>
</tr>
<tr>
<td style="text-align:left;">
Import
</td>
<td style="text-align:right;">
Reads a data object in its native format and converts it to an R object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Impute
</td>
<td style="text-align:right;">
Imputes data.
</td>
</tr>
<tr>
<td style="text-align:left;">
Knit
</td>
<td style="text-align:right;">
Knits a rmarkdown file
</td>
</tr>
<tr>
<td style="text-align:left;">
Launch
</td>
<td style="text-align:right;">
Launches an application
</td>
</tr>
<tr>
<td style="text-align:left;">
Make
</td>
<td style="text-align:right;">
Creates a new R object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Plot
</td>
<td style="text-align:right;">
Plots data
</td>
</tr>
<tr>
<td style="text-align:left;">
Predict
</td>
<td style="text-align:right;">
Makes predictions from data using a specified statistical model.
</td>
</tr>
<tr>
<td style="text-align:left;">
Print
</td>
<td style="text-align:right;">
Prints output to console
</td>
</tr>
<tr>
<td style="text-align:left;">
Randomise
</td>
<td style="text-align:right;">
Randomly samples from data.
</td>
</tr>
<tr>
<td style="text-align:left;">
Read
</td>
<td style="text-align:right;">
Reads an R script into memory.
</td>
</tr>
<tr>
<td style="text-align:left;">
Remove
</td>
<td style="text-align:right;">
Edits an object, removing a specified element or elements.
</td>
</tr>
<tr>
<td style="text-align:left;">
Rename
</td>
<td style="text-align:right;">
Renames elements of an object based on a pre-speccified schema.
</td>
</tr>
<tr>
<td style="text-align:left;">
Reorder
</td>
<td style="text-align:right;">
Reorders an object to conform to a pre-specified schema.
</td>
</tr>
<tr>
<td style="text-align:left;">
Replace
</td>
<td style="text-align:right;">
Edits an object, replacing a specified element with another specified element.
</td>
</tr>
<tr>
<td style="text-align:left;">
Reset
</td>
<td style="text-align:right;">
Edits an object, overwriting the current version with a default version.
</td>
</tr>
<tr>
<td style="text-align:left;">
Rowbind
</td>
<td style="text-align:right;">
Performs custom rowbind operations on table objects.
</td>
</tr>
<tr>
<td style="text-align:left;">
Scramble
</td>
<td style="text-align:right;">
Randomly reorders an object.
</td>
</tr>
<tr>
<td style="text-align:left;">
Transform
</td>
<td style="text-align:right;">
Edits an object in such a way that core object attributes - e.g. shape, dimensions, elements, type - are altered.
</td>
</tr>
<tr>
<td style="text-align:left;">
Unload
</td>
<td style="text-align:right;">
Performs a custom detaching of a package from the search path.
</td>
</tr>
<tr>
<td style="text-align:left;">
Update
</td>
<td style="text-align:right;">
Edits an object, while preserving core object attributes.
</td>
</tr>
<tr>
<td style="text-align:left;">
Validate
</td>
<td style="text-align:right;">
Validates that an object conforms to required criteria.
</td>
</tr>
<tr>
<td style="text-align:left;">
Write
</td>
<td style="text-align:right;">
Writes a file to a specified local directory.
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

### Function inputs and outputs have meaningful suffices

The type of input (arguments) required and output (return) produced by a function can be efficiently communicated by using meaningful suffices. For example all objects ending in "\_chr" are character vectors and all objects ending in "\_int" are integer vectors. The meaningful suffices currently used by to describe objects in the ready4 framework are stored in element `seed_obj_type_lup` of `dataset_ls`, the key features of which are reproduced below.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>dataset_ls</span><span class='o'>$</span><span class='nv'>seed_obj_type_lup</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/ready4fun_objects.html'>ready4fun_objects</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>select_int <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='m'>2</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Meaningful suffices
</caption>
<thead>
<tr>
<th style="text-align:left;">
Suffix
</th>
<th style="text-align:right;">
Description
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
arr
</td>
<td style="text-align:right;">
array
</td>
</tr>
<tr>
<td style="text-align:left;">
chr
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
dbl
</td>
<td style="text-align:right;">
double
</td>
</tr>
<tr>
<td style="text-align:left;">
df
</td>
<td style="text-align:right;">
data.frame
</td>
</tr>
<tr>
<td style="text-align:left;">
dtm
</td>
<td style="text-align:right;">
date
</td>
</tr>
<tr>
<td style="text-align:left;">
env
</td>
<td style="text-align:right;">
environment
</td>
</tr>
<tr>
<td style="text-align:left;">
fct
</td>
<td style="text-align:right;">
factor
</td>
</tr>
<tr>
<td style="text-align:left;">
fn
</td>
<td style="text-align:right;">
function
</td>
</tr>
<tr>
<td style="text-align:left;">
int
</td>
<td style="text-align:right;">
integer
</td>
</tr>
<tr>
<td style="text-align:left;">
lgl
</td>
<td style="text-align:right;">
logical
</td>
</tr>
<tr>
<td style="text-align:left;">
ls
</td>
<td style="text-align:right;">
list
</td>
</tr>
<tr>
<td style="text-align:left;">
lup
</td>
<td style="text-align:right;">
lookup table
</td>
</tr>
<tr>
<td style="text-align:left;">
mat
</td>
<td style="text-align:right;">
matrix
</td>
</tr>
<tr>
<td style="text-align:left;">
mdl
</td>
<td style="text-align:right;">
model
</td>
</tr>
<tr>
<td style="text-align:left;">
plt
</td>
<td style="text-align:right;">
plot
</td>
</tr>
<tr>
<td style="text-align:left;">
prsn
</td>
<td style="text-align:right;">
person
</td>
</tr>
<tr>
<td style="text-align:left;">
r3
</td>
<td style="text-align:right;">
ready4 S3
</td>
</tr>
<tr>
<td style="text-align:left;">
r4
</td>
<td style="text-align:right;">
ready4 S4
</td>
</tr>
<tr>
<td style="text-align:left;">
rgx
</td>
<td style="text-align:right;">
regular expression
</td>
</tr>
<tr>
<td style="text-align:left;">
s3
</td>
<td style="text-align:right;">
S3
</td>
</tr>
<tr>
<td style="text-align:left;">
s4
</td>
<td style="text-align:right;">
S4
</td>
</tr>
<tr>
<td style="text-align:left;">
sf
</td>
<td style="text-align:right;">
simple features object
</td>
</tr>
<tr>
<td style="text-align:left;">
tb
</td>
<td style="text-align:right;">
tibble
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

### Consistent use of abbreviations

Further information about the purpose of a function and the nature of its inputs and outputs can be encoded by using naming conventions that make consistent use of abbreviations. A master table of the abbreviations used throughout the `ready4` framework is maintained in the `abbreviations_lup` element of `dataset_ls`. The list of abbreviations is now quite extensive and continues to grow as the `ready4` suite of software expands. The initial few entries of `abbreviations_lup` are reproduced below.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>dataset_ls</span><span class='o'>$</span><span class='nv'>abbreviations_lup</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>select_int <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='m'>2</span>,</span>
<span>          scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Abbreviations
</caption>
<thead>
<tr>
<th style="text-align:left;">
Abbreviation
</th>
<th style="text-align:right;">
Description
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
...
</td>
<td style="text-align:right;">
additional arguments
</td>
</tr>
<tr>
<td style="text-align:left;">
1L
</td>
<td style="text-align:right;">
length one
</td>
</tr>
<tr>
<td style="text-align:left;">
1L_chr
</td>
<td style="text-align:right;">
character vector of length one
</td>
</tr>
<tr>
<td style="text-align:left;">
1L_chr_ls
</td>
<td style="text-align:right;">
list of character vectors of length one
</td>
</tr>
<tr>
<td style="text-align:left;">
1L_chr_r4
</td>
<td style="text-align:right;">
ready4 S4 collection of character vectors of length one
</td>
</tr>
<tr>
<td style="text-align:left;">
1L_dbl
</td>
<td style="text-align:right;">
double vector of length one
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

### Workflow

#### Manifest

The main class exported as part of ready4fun is the [ready4 sub-module](https://ready4-dev.github.io/ready4/articles/V_01.html) `ready4fun_manifest` which is used to specify metadata (including details of the repository in which the `fn_types_lup`, `seed_obj_lup_tb` and `abbreviations_lup` objects are stored) for the functions being authored and the R package that will contain them.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>x</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/ready4fun_manifest.html'>ready4fun_manifest</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

#### Typical Usage

A `ready4fun_manifest` object is most efficiently created with the aid of the `make_pkg_desc_ls` and `make_manifest` functions rather than a direct call to the [`ready4fun_manifest()`](https://ready4-dev.github.io/ready4fun/reference/ready4fun_manifest.html) function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>## Not run</span></span>
<span><span class='nv'>x</span> <span class='o'>&lt;-</span> <span class='nf'>ready4fun</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/make_pkg_desc_ls.html'>make_pkg_desc_ls</a></span><span class='o'>(</span>pkg_title_1L_chr <span class='o'>=</span> <span class='s'>"Your Package Title"</span>,</span>
<span>                                 pkg_desc_1L_chr <span class='o'>=</span> <span class='s'>"Your Package Description."</span>,</span>
<span>                                 authors_prsn <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'>utils</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/r/utils/person.html'>person</a></span><span class='o'>(</span><span class='s'>"Author 1 Name"</span>,</span>
<span>                                                                role <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"aut"</span>, <span class='s'>"cre"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'>utils</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/r/utils/person.html'>person</a></span><span class='o'>(</span><span class='s'>"Author 2 Name"</span>, role <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"cph"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                 urls_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Package website url"</span>,</span>
<span>                                              <span class='s'>"Package source code url"</span>,</span>
<span>                                              <span class='s'>"Project website"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>ready4fun</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/make_manifest.html'>make_manifest</a></span><span class='o'>(</span>copyright_holders_chr <span class='o'>=</span> <span class='s'>"Organisation name"</span>,</span>
<span>                           custom_dmt_ls <span class='o'>=</span> <span class='nf'>ready4fun</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/make_custom_dmt_ls.html'>make_custom_dmt_ls</a></span><span class='o'>(</span>user_manual_fns_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Functions to be included in main user manual are itemised here"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                           dev_pkgs_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Any development package dependencies go here"</span><span class='o'>)</span>,</span>
<span>                           path_to_pkg_logo_1L_chr <span class='o'>=</span> <span class='s'>"Local path to package logo goes here"</span>,</span>
<span>                           piggyback_to_1L_chr <span class='o'>=</span> <span class='s'>"GitHub Release Repository to which supporting files will be uploaded"</span>,</span>
<span>                           ready4_type_1L_chr <span class='o'>=</span> <span class='s'>"authoring"</span>,</span>
<span>                           zenodo_badge_1L_chr <span class='o'>=</span> <span class='s'>"DOI badge details go here"</span><span class='o'>)</span></span></code></pre>

</div>

The main method defined for `ready4fun_manifest` is `author` which, assuming the raw undocumented function files are saved in the appropriate directories, will author an R package in which all functions are consistently documented.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>## Not run</span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span></span></code></pre>

</div>

#### Examples

The `ready4fun_manifest` sub-module and its methods along with the `make_pkg_desc_ls` and `make_manifest`functions are designed to be used as part of [the ready4pack R package authoring workflow](https://ready4-dev.github.io/ready4pack/articles/V_01.html). That vignette includes links to two examples of where the `ready4pack` workflow has been used to author R package. To illustrate how `readyfun` tools used as part of that workflow are used to document functions, we are just going to focus on [the program used to create the ready4show package](https://github.com/ready4-dev/ready4show/blob/main/data-raw/DATASET.R).

That program makes use of `ready4fun` tools that read all [undocumented package functions](https://github.com/ready4-dev/ready4show/tree/main/data-raw/fns), performs automated checks to ensure that these functions appropriately use the taxonomies and abbreviations mentioned previously (prompting authors to make specific amendments if they do not) and then rewrites these functions to the [package R directory](https://github.com/ready4-dev/ready4show/tree/main/R), appending tags (with the aid of the `sinew` package) that will generate meaningful documentation.

For example, one of the functions to be documented is the [knit_from_tmpl](https://github.com/ready4-dev/ready4show/blob/main/data-raw/fns/knit.R), which is transformed to a [version with tags](https://github.com/ready4-dev/ready4show/blob/main/R/fn_knit.R). The tags added to all functions are then used to generate the package documentation, including the package manual. Two versions of the `ready4show` package manual are generated - [a slimmed down version for end-users](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/ready4show_User.pdf) and [a more detailed inventory of contents intended for developers](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/ready4show_Developer.pdf).

## Future documentation

Detailed guidance for how to apply `ready4fun` workflow tools has yet to be prepared but will be released in 2022.

