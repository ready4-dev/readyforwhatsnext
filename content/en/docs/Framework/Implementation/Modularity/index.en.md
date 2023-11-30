---
title: "Modularity"
linkTitle: "Modularity"
date: "2023-11-30"
description: "ready4 supports a modular approach to computational model development."
weight: 62
categories: 
- Documentation
tags: 
- Framework
- Framework - foundation
- Framework - foundation (modularity)
- Software
- Software - libraries
- Software - libraries (ready4)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: 6e4877d09d026d7b

---

{{% pageinfo %}} This below section renders a vignette article from the ready4 library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span> </span></code></pre>

</div>

## Motivation

A potentially attractive approach to modelling complex health systems is to begin with a relatively simple computational model and to progressively extend its scope and sophistication. Such an approach could be described as "modular" if it is possible to readily combine multiple discrete modelling projects (potentially developed by different modelling teams) that each independently describe distinct aspects of the system being modelled. The `ready4` package provides foundational elements of a software framework to support the development of modular and open-source computational health economic models using R.

## Implementation

Modular model development is enabled by the [encapsulation and inheritance features of Object Oriented Programming (OOP)](https://www.ready4-dev.com/docs/framework/implementation/paradigm/object-oriented/). Specifically, `ready4` uses two of R's systems for implementing OOP - S3 and S4. An in-depth explanation of R's different class system is beyond the scope of this article, but is explored in [Hadley Wickham's Advanced R handbook](https://adv-r.hadley.nz/oo.html). However, it is useful to know some very high level information about S3 and S4 classes:

-   S4 classes are frequently said to be "formal", "strict" or "rigorous". The elements of an S4 class are called slots and the type of data that each slot is allowed to contain is specified in the class definition. An S4 class can be comprised of slots that contain different types of data (e.g. a slot that contains a character vector and another slot that contains tabular data).

-   S3 classes are often described as "simple", "informal" and "flexible". S3 objects attach an attribute label to base type objects (e.g. a character vector, a data.frame, a list), which in turn is used to work out what methods should be applied to the class.

### ready4 Model Modules

As we use the term, a "model module" is comprised of both a data-structure (or "class") and algorithms (or "methods") that are associated with that data-structure. A model module can be used to model a discrete component of a health economic system. Model modules can be created from a template - the `ready4` package's `Ready4Module` class.

We can create an object (`X`) from the `Ready4Module` template using the following command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/Ready4Module-class.html'>Ready4Module</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

However, if we inspect `X` we can see it is of limited use as it contains no data other than an empty element called `dissemination_1L_chr`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/utils/str.html'>str</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Formal class 'Ready4Module' [package "ready4"] with 1 slot</span></span>
<span><span class='c'>#&gt;   ..@ dissemination_1L_chr: chr NA</span></span>
<span></span></code></pre>

</div>

The `Ready4Module` class is therefore not intended to be called directly. Instead, the purpose of `Ready4Module` is to be the parent class of other templates for creating model modules. `Ready4Module` and all of its child-classes (ie all model module templates) are "S4" classes.

<div class="card border-primary mb-3" style="max-width: 20rem;">

<div class="card-header">

**ready4 Concept**

</div>

<div class="card-body">

<div class="card-title">

#### Module

</div>

An instance of `Ready4Module` (or classes that inherit from `Ready4Module`) and its associated methods.

</div>

</div>

### ready4 Model Sub-modules

In ready4, S3 classes are principally used to help define the structural properties of slots (array elements) of model modules and the methods that can be applied to these slots. S3 classes created for these purposes are called **sub-modules**.

<div class="card border-primary mb-3" style="max-width: 20rem;">

<div class="card-header">

**ready4 Concept**

</div>

<div class="card-body">

<div class="card-title">

#### Sub-Module

</div>

An instance of an informal (S3) class and its associated methods that describes, validates and applies algorithms to a slot of a Module.

</div>

</div>

### Module and Sub-module Methods

All methods associated with modules and sub-modules adopt [a common syntax](https://www.ready4-dev.com/docs/framework/implementation/syntax/). However, the algorithms implemented by each command in that syntax will vary depending on which module it is applied to. A limited number of methods are defined for the `Ready4Module` template which by default are inherited by all other module templates. Currently, the only methods defined for `Ready4Module` are [slot-methods](https://www.ready4-dev.com/docs/framework/implementation/syntax/#slot-generics-and-methods) and these can be itemised using the `get_methods` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/get_methods.html'>get_methods</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='c'>#&gt;  [1] "authorSlot"        "characterizeSlot"  "depictSlot"        "enhanceSlot"       "exhibitSlot"       "ingestSlot"       </span></span>
<span><span class='c'>#&gt;  [7] "investigateSlot"   "manufactureSlot"   "metamorphoseSlot"  "procureSlot"       "prognosticateSlot" "ratifySlot"       </span></span>
<span><span class='c'>#&gt; [13] "reckonSlot"        "renewSlot"         "shareSlot"</span></span>
<span></span></code></pre>

</div>

Developers using the extended ready4 software framework can use our [module authoring tools](https://www.ready4-dev.com/docs/framework/use/authoring-modules/) to add new methods or overwrite inherited default methods.

