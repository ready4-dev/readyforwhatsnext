---
title: "Modules"
linkTitle: "Modules"
date: "2022-12-24"
description: "ready4 supports a modular approach to computational model development."
weight: 62
categories: 
- Documentation
tags: 
- Framework
- ready4 (library)
output: hugodown::md_document
rmd_hash: 9ce644e9b78dff37

---

{{% pageinfo %}} This below section renders a vignette article from the ready4 library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='s'><a href='https://ready4-dev.github.io/ready4/'>"ready4"</a></span><span class='o'>)</span> </span></code></pre>

</div>

## Motivation

A potentially attractive approach to modelling complex youth mental health systems is to begin with a relatively simple computational model and to progressively extend its scope and sophistication. Such an approach could be described as "modular" if it is possible to readily combine multiple discrete modelling projects (potentially developed by different modelling teams) that each independently describe distinct aspects of the system being modelled. This modular and collaborative approach is being used in the development of [ready4 - an open source health economic model of the systems shaping mental health and wellbeing in young people](https://www.ready4-dev.com). The `ready4` package provides the foundational tools to support the development and application of the ready4 modular model.

## Implementation

The ready4 model is being implemented in R and its modular nature is enabled by the [encapsulation and inheritance features of Object Oriented Programming (OOP)](https://ready4-dev.github.io/ready4/articles/V_03.html). Specifically, ready4 uses two of R's systems for implementing OOP - S3 and S4. An in-depth explanation of R's different class system is beyond the scope of this article, but is explored in [Hadley Wickham's Advanced R handbook](https://adv-r.hadley.nz/oo.html). However, it is useful to know some very high level information about S3 and S4 classes:

-   S4 classes are frequently said to be "formal", "strict" or "rigorous". The elements of an S4 class are called slots and the type of data that each slot is allowed to contain is specified in the class definition. An S4 class can be comprised of slots that contain different types of data (e.g. a slot that contains a character vector and another slot that contains tabular data).

-   S3 classes are often described as "simple", "informal" and "flexible". S3 objects attach an attribute label to base type objects (e.g. a character vector, a data.frame, a list), which in turn is used to work out what methods should be applied to the class.

### ready4 Model Modules

A ready4 model module is a data-structure and associated algorithms that is used to model a discrete component of a system relevant to young people's mental health. Each ready4 model module is created using the `ready4` package's `Ready4Module` class. We can create an instance (`X`) of `Ready4Module` using the following command.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'>ready4</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/Ready4Module-class.html'>Ready4Module</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

However, if we inspect `X` we can see it is of limited use as it contains no data other than an empty element called `dissemination_1L_chr`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/utils/str.html'>str</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Formal class 'Ready4Module' [package "ready4"] with 1 slot</span></span>
<span><span class='c'>#&gt;   ..@ dissemination_1L_chr: chr NA</span></span></code></pre>

</div>

The `Ready4Module` class is therefore not intended to be called directly. Instead, the purpose of `Ready4Module` is to be the parent-class of all ready4 model modules. `Ready4Module` and all of its child-classes (ie all ready4 model modules) are "S4" classes.

<div class="card border-primary mb-3" style="max-width: 20rem;">

<div class="card-header">

**ready4 Concept**

</div>

<div class="card-body">

<div class="card-title">

#### Module

</div>

A formal (S4) `Ready4Module` child-class and its associated methods used to implement a discrete sub-component of the ready4 youth mental health model.

</div>

</div>

`ready4` includes two child classes of `Ready4Module`. These are `Ready4Public` and `Ready4Private` and both are almost as minimally informative as their parent (the only difference being that their instances have the values "Public" or "Private" assigned to the `dissemination_1L_chr` slot).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/Ready4Public-class.html'>Ready4Public</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://rdrr.io/r/utils/str.html'>str</a></span><span class='o'>(</span><span class='nv'>Y</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Formal class 'Ready4Public' [package "ready4"] with 1 slot</span></span>
<span><span class='c'>#&gt;   ..@ dissemination_1L_chr: chr "Public"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Z</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/Ready4Private-class.html'>Ready4Private</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://rdrr.io/r/utils/str.html'>str</a></span><span class='o'>(</span><span class='nv'>Z</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Formal class 'Ready4Private' [package "ready4"] with 1 slot</span></span>
<span><span class='c'>#&gt;   ..@ dissemination_1L_chr: chr "Private"</span></span></code></pre>

</div>

Like the `Ready4Module` class they inherit from, the purpose of `Ready4Public` and `Ready4Private` is to be used as parent classes. Using either of `Ready4Public` and `Ready4Private` can be a potentially efficient way of partially automating access policies for model data. If **all** the data contained in a module can **always** be shared publicly, it may be convenient to note this by using a module that has been created as a child-class of `Ready4Public`. Similarly, if at least some of the data contained in a module will always be unsuitable for public dissemination, it can be useful to use a module that is a child of `Ready4Private`. When the dissemination policy for data contained in a module will vary depending on user or context, it is more appropriate to use a module that inherits from `Ready4Module` without being a child of either `Ready4Public` and `Ready4Private`. In this latest case, users may choose to add descriptive information about the data access policy themselves using the `renewSlot` method. The dissemination policy can be inspected with the `procureSlot` method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>               <span class='s'>"dissemination_1L_chr"</span>,</span>
<span>               <span class='s'>"Staff and students of research institutes"</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/procureSlot-methods.html'>procureSlot</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>            <span class='s'>"dissemination_1L_chr"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "Staff and students of research institutes"</span></span></code></pre>

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

An informal (S3) class and its associated methods that describes, validates and applies algorithms to a slot of a ready4 module.

</div>

</div>

### Module and Sub-module Methods

All methods associated with ready4 modules and sub-modules adopt [a common syntax](https://ready4-dev.github.io/ready4/articles/V_02.html). However, the algorithms implemented by each command in that syntax will vary depending on which module it is applied to. A limited number of methods are defined at the level of the `Ready4Module` parent class and are therefore inherited by all ready4 modules. Currently, the only methods defined for `Ready4Module` are [slot-methods](https://ready4-dev.github.io/ready4/articles/V_02.html#slot-generics-and-methods) and these can be itemised using the `get_methods` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/get_methods.html'>get_methods</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='c'>#&gt;  [1] "authorSlot"        "characterizeSlot"  "depictSlot"       </span></span>
<span><span class='c'>#&gt;  [4] "enhanceSlot"       "exhibitSlot"       "ingestSlot"       </span></span>
<span><span class='c'>#&gt;  [7] "investigateSlot"   "manufactureSlot"   "metamorphoseSlot" </span></span>
<span><span class='c'>#&gt; [10] "procureSlot"       "prognosticateSlot" "ratifySlot"       </span></span>
<span><span class='c'>#&gt; [13] "reckonSlot"        "renewSlot"         "shareSlot"</span></span></code></pre>

</div>

