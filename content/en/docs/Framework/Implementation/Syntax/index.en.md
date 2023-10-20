---
title: "Syntax"
linkTitle: "Syntax"
date: "2023-10-20"
description: "ready4 modules use a simple and consistent syntax."
weight: 63
categories: 
- Documentation
tags: 
- Framework
- Framework - foundation
- Framework - foundation (syntax)
- Programming
- Programming - object-oriented
- Software
- Software - libraries
- Software - libraries (ready4)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: de162385352d4bd4
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4 library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4/articles/V_02.html)
-   [view the source file](https://github.com/ready4-dev/ready4/blob/main/vignettes/V_02.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4/edit/main/vignettes/V_02.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span> </span></code></pre>

</div>

## Motivation

Transparency is one of the underpinning principles of ethical modelling practice. One way to improve the transparency of computational health economic models (such as those we are developing [in youth mental health](https://www.ready4-dev.com/docs/model/)) is to ensure that the [programs implementing model analyses](https://www.ready4-dev.com/docs/model/analyses/) can be meaningfully inspected by readers with different levels of technical expertise. Even non-technical readers should be able to follow the high-level logic implemented by model algorithms. If multiple analysis programs are written using a common simplified syntax then reviewers of those programs need to contend with relatively fewer new concepts.

## Implementation

`ready4` provides a simple syntax that can be consistently applied to attach algorithms (methods) to [model modules](https://www.ready4-dev.com/docs/framework/implementation/modularity/). It does so by taking advantage of the [abstraction and polymorphism features of Object Oriented Programing](https://www.ready4-dev.com/docs/framework/implementation/paradigm/object-oriented/#transparent-computational-models) and R's use of generic functions. Generic functions don't implement algorithms themselves - their most salient features are a name and a high level description of the type of task that any method associated with that generic should perform. Whenever a developer creates a method for [classes that use R's S4 and S3 systems (the types used for model modules and sub-modules)](https://www.ready4-dev.com/docs/framework/implementation/modularity/#implementation), they can associate that method with the generic that has a description that is the best match for the algorithm being implemented.

### Available generics

A table that summarises the latest `ready4` syntax can be ingested from a periodically updated database using `get_methods_tb`.

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>x</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/get_methods_tb.html'>get_methods_tb</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

#### Core generics

`ready4` includes a number of core generic functions which describe the main types of method to be implemented by model modules. Notably, the `ready4` package does not associate methods with any of these core generics. Instead, methods are associated with these generics in [R packages of model modules](https://www.ready4-dev.com/docs/software/libraries/types/module/). A HTML table of `ready4`'s core generics and examples of methods associated with each generic can be displayed using the `print_methods` function, using the `return_1L_chr = "core"` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_methods.html'>print_methods</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>              return_1L_chr <span class='o'>=</span> <span class='s'>"core"</span>,</span>
<span>              scroll_width_1L_chr <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span> </span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Method
</th>
<th style="text-align:left;">
Purpose
</th>
<th style="text-align:left;">
Examples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/author-methods.html"> author </a>
</td>
<td style="text-align:left;">
author
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4class/articles/V_01.html" style="     ">5</a>, <a href="https://ready4-dev.github.io/ready4fun/articles/V_01.html" style="     ">6</a> , <a href="https://ready4-dev.github.io/ready4pack/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/characterize-methods.html"> characterize </a>
</td>
<td style="text-align:left;">
characterize
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/depict-methods.html"> depict </a>
</td>
<td style="text-align:left;">
depict
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/enhance-methods.html"> enhance </a>
</td>
<td style="text-align:left;">
enhance
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/exhibit-methods.html"> exhibit </a>
</td>
<td style="text-align:left;">
exhibit
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4use/articles/V_02.html" style="     ">3</a> , <a href="https://ready4-dev.github.io/ready4class/articles/V_01.html" style="     ">5</a>, <a href="https://ready4-dev.github.io/ready4fun/articles/V_01.html" style="     ">6</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/ingest-methods.html"> ingest </a>
</td>
<td style="text-align:left;">
ingest
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4use/articles/V_01.html" style="     ">2</a> , <a href="https://ready4-dev.github.io/ready4use/articles/V_02.html" style="     ">3</a> , <a href="https://ready4-dev.github.io/ready4use/articles/V_03.html" style="     ">4</a> , <a href="https://ready4-dev.github.io/ready4class/articles/V_01.html" style="     ">5</a>, <a href="https://ready4-dev.github.io/ready4fun/articles/V_01.html" style="     ">6</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/investigate-methods.html"> investigate </a>
</td>
<td style="text-align:left;">
investigate
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/manufacture-methods.html"> manufacture </a>
</td>
<td style="text-align:left;">
manufacture
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/metamorphose-methods.html"> metamorphose </a>
</td>
<td style="text-align:left;">
metamorphose
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/procure-methods.html"> procure </a>
</td>
<td style="text-align:left;">
procure
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/prognosticate-methods.html"> prognosticate </a>
</td>
<td style="text-align:left;">
prognosticate
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/ratify-methods.html"> ratify </a>
</td>
<td style="text-align:left;">
ratify
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/reckon-methods.html"> reckon </a>
</td>
<td style="text-align:left;">
reckon
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/renew-methods.html"> renew </a>
</td>
<td style="text-align:left;">
renew
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4use/articles/V_01.html" style="     ">2</a>, <a href="https://ready4-dev.github.io/ready4use/articles/V_02.html" style="     ">3</a>, <a href="https://ready4-dev.github.io/ready4fun/articles/V_01.html" style="     ">6</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/share-methods.html"> share </a>
</td>
<td style="text-align:left;">
share
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4use/articles/V_01.html" style="     ">2</a>
</td>
</tr>
</tbody>
</table>

</div>

</div>

#### Slot generics and methods

Each of the "core" generics also has a "slot" version, for use when applying a core method to a specified slot of a class. The `ready4` package associated methods for each of these "slot" generics for [the `Ready4Module` template](https://www.ready4-dev.com/docs/framework/implementation/modularity/#implementation). Two of these "slot" methods can also be used for additional purposes:

-   [procureSlot](https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html) is a "getter" method - its default behaviour is to return the value of a specified slot. If the argument `use_procure_mthd_1L_lgl = T` is included in the method call, `procureSlot` will instead apply the `procure` method to a specified slot.

-   [renewSlot](https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html) is a "setter" method - if any value other than "use_renew_mthd" (the default) is passed to the `new_val_xx` argument, that value will be assigned to the specified slot.

A HTML table of the slot generics bundled with `ready4` can be displayed using the `print_methods` function, using the `return_1L_chr = "slot"` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_methods.html'>print_methods</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>              return_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>,</span>
<span>              scroll_width_1L_chr <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Method
</th>
<th style="text-align:left;">
Purpose
</th>
<th style="text-align:left;">
Examples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/authorSlot-methods.html"> authorSlot </a>
</td>
<td style="text-align:left;">
authorSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/characterizeSlot-methods.html"> characterizeSlot </a>
</td>
<td style="text-align:left;">
characterizeSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/depictSlot-methods.html"> depictSlot </a>
</td>
<td style="text-align:left;">
depictSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/enhanceSlot-methods.html"> enhanceSlot </a>
</td>
<td style="text-align:left;">
enhanceSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html"> exhibitSlot </a>
</td>
<td style="text-align:left;">
exhibitSlot
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4show/articles/V_01.html" style="     ">1</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/ingestSlot-methods.html"> ingestSlot </a>
</td>
<td style="text-align:left;">
ingestSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/investigateSlot-methods.html"> investigateSlot </a>
</td>
<td style="text-align:left;">
investigateSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/manufactureSlot-methods.html"> manufactureSlot </a>
</td>
<td style="text-align:left;">
manufactureSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/metamorphoseSlot-methods.html"> metamorphoseSlot </a>
</td>
<td style="text-align:left;">
metamorphoseSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html"> procureSlot </a>
</td>
<td style="text-align:left;">
procureSlot
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4show/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/ready4/articles/V_01.html" style="     ">8</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/prognosticateSlot-methods.html"> prognosticateSlot </a>
</td>
<td style="text-align:left;">
prognosticateSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/ratifySlot-methods.html"> ratifySlot </a>
</td>
<td style="text-align:left;">
ratifySlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/reckonSlot-methods.html"> reckonSlot </a>
</td>
<td style="text-align:left;">
reckonSlot
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html"> renewSlot </a>
</td>
<td style="text-align:left;">
renewSlot
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4show/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/ready4/articles/V_01.html" style="     ">8</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/shareSlot-methods.html"> shareSlot </a>
</td>
<td style="text-align:left;">
shareSlot
</td>
<td style="text-align:left;">
</td>
</tr>
</tbody>
</table>

</div>

</div>

#### Extended `author` generics

Finally, there are a small number of other generics that are more general extensions of the core functions. Currently, these extended generics are all variants on the `author` generics, with each one specifying the type of output to be authored by the method. The `ready4` package does not include methods for any of these extended generics. A HTML table of the extended generics bundled with `ready4` can be displayed using the `print_methods` function, using the `return_1L_chr = "extended"` argument.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_methods.html'>print_methods</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>              exclude_mthds_for_chr <span class='o'>=</span> <span class='s'>"Ready4Module"</span>,</span>
<span>              return_1L_chr <span class='o'>=</span> <span class='s'>"extended"</span>,</span>
<span>              scroll_width_1L_chr <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Method
</th>
<th style="text-align:left;">
Purpose
</th>
<th style="text-align:left;">
Examples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/authorClasses-methods.html"> authorClasses </a>
</td>
<td style="text-align:left;">
authorClasses
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/authorData-methods.html"> authorData </a>
</td>
<td style="text-align:left;">
authorData
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4show/articles/V_01.html" style="     ">1</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/authorFunctions-methods.html"> authorFunctions </a>
</td>
<td style="text-align:left;">
authorFunctions
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4/reference/authorReport-methods.html"> authorReport </a>
</td>
<td style="text-align:left;">
authorReport
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/ready4show/articles/V_01.html" style="     ">1</a>
</td>
</tr>
</tbody>
</table>

</div>

</div>

