---
title: "Dissemating citable, documented and quality assured model module libraries"
linkTitle: "Libraries"
date: "2022-12-24"
description: "ready4 supports tools to streamline the testing, description and distribution of computational model modules."
weight: 66
categories: 
- Documentation
tags: 
- Framework - authoring tools
- Framework - authoring tools (modules)
- Software
- Software - libraries
- Software - libraries (ready4pack)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: 569fe66e4279a51a

---

{{% pageinfo %}} This below section renders a vignette article from the ready4pack library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4pack/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/ready4pack/blob/master/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4pack/edit/master/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4pack/'>ready4pack</a></span><span class='o'>)</span></span></code></pre>

</div>

`ready4pack` is a toolkit for authoring collections of modules for the [ready4 youth mental health systems model](https://www.ready4-dev.com/) and disseminating them as R packages that are:

-   *Citable* (with a Zenodo generated DOI and an algorithm generated CITATION file);
-   *Community-minded* (applying deprecation conventions supported by `lifecycle`);
-   *Documented* (applying a function self-documenting algorithm that extends `sinew`, deploying a GitHub pages hosted and `pkgdown` generated website and authoring PDF manuals stored in a GitHub Release via `piggyback`);
-   *Internally consistent* implementing automated checks to ensure consistency in naming conventions, etc;
-   *Licensed* (via a `usethis` generated GPL-3 license);
-   *Quality assured* (using continuous integration via GitHub actions and R-CMD-Check); and
-   *Versioned* (applying `usethis` version increments).

`ready4pack` builds on both third party development workflow tools (such as `devtools`) and ready4 tools for authoring functions ([ready4fun](https://ready4-dev.github.io/ready4fun/articles/V_01.html)) and classes ([ready4class](https://ready4-dev.github.io/ready4class/articles/V_01.html)). `ready4pack` integrates these tools in a common workflow, while adding tools for authoring and documenting R package datasets.

A combination of the `ready4_pack_manifest` class and `author` method are used to implement this workflow. This workflow has been used to author all public versions of the ready4 R packages available in the [ready4 github repository](https://github.com/ready4-dev).

## Workflow

### Manifest

The main class exported as part of `ready4pack` is `readypack_manifest` list based [ready4 sub-module](https://ready4-dev.github.io/ready4/articles/V_01.html), that extends the [`ready4fun_manifest`](https://ready4-dev.github.io/ready4fun/articles/V_01.html) and [`ready4class_manifest`](https://ready4-dev.github.io/ready4class/articles/V_01.html) sub-modules.

### Typical usage

`readypack_manifest` sub-module is most efficiently created with the aid of the `make_pt_ready4pack_manifest` function and combines instances of the `ready4fun_manifest` and [`ready4class_constructor`](https://ready4-dev.github.io/ready4class/articles/V_01.html) sub-modules.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>x</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4pack/reference/ready4pack_manifest.html'>make_pt_ready4pack_manifest</a></span><span class='o'>(</span><span class='nf'>ready4fun</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4fun/reference/ready4fun_manifest.html'>ready4fun_manifest</a></span><span class='o'>(</span><span class='o'>)</span>,</span>
<span>                                 constructor_r3 <span class='o'>=</span> <span class='nf'>ready4class</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/ready4class/reference/ready4class_constructor.html'>ready4class_constructor</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4pack/reference/ready4pack_manifest.html'>ready4pack_manifest</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

The main method defined for `readypack_manifest` is `author` which extends the `author` method for `ready4class_manifest` to author a consistently documented R package.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>## Not run</span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/author-methods.html'>author</a></span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span></span></code></pre>

</div>

### Examples

#### Workflow example one

[The program to author and document the ready4show package](https://github.com/ready4-dev/ready4show/blob/main/data-raw/DATASET.R) is relatively simple and authors:

-   the `ready4show` package [CITATION](https://github.com/ready4-dev/ready4show/blob/main/inst/CITATION), [DESCRIPTION](https://github.com/ready4-dev/ready4show/blob/main/DESCRIPTION), [LICENSE](https://github.com/ready4-dev/ready4show/blob/main/LICENSE) and [README](https://github.com/ready4-dev/ready4show/blob/main/README.md) files;

-   [all files in the `ready4show` package R directory](https://github.com/ready4-dev/ready4show/tree/main/R);

-   the `ready4show` package [website](https://ready4-dev.github.io/ready4show/);

-   two versions of the `ready4show` package manual - [a slimmed down version for end-users](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/ready4show_User.pdf) and [a more detailed inventory of contents intended for developers](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/ready4show_Developer.pdf);

-   an [initial `ready4show` release](https://github.com/ready4-dev/ready4show/releases/tag/Documentation_0.0) for hosting supporting files, the creation of which will trigger archiving on [Zenodo with a `ready4show` package DOI](https://doi.org/10.5281/zenodo.5644569); and

-   an [R-CMD-check continuous integration](https://github.com/ready4-dev/ready4show/actions/workflows/R-CMD-check.yaml) algorithm to be implemented each time a new version of `ready4show` is pushed to the `main` branch of the GitHub source code repository.

#### Workflow example two

[The program to author and document the youthvars package](https://github.com/ready4-dev/youthvars/blob/main/data-raw/DATASET.R) is a bit more complex as it includes syntax to create package datasets. In addition to the package datasets, the algorithm creates content corresponding to the previous example, specifically:

-   the `youthvars` package [CITATION](https://github.com/ready4-dev/youthvars/blob/main/inst/CITATION), [DESCRIPTION](https://github.com/ready4-dev/youthvars/blob/main/DESCRIPTION), [LICENSE](https://github.com/ready4-dev/youthvars/blob/main/LICENSE) and [README](https://github.com/ready4-dev/youthvars/blob/main/README.md) files;

-   [all files in the `youthvars` package R directory](https://github.com/ready4-dev/youthvars/tree/main/R);

-   the `youthvars` package [website](https://ready4-dev.github.io/youthvars/);

-   two versions of the `youthvars` package manual - [a slimmed down version for end-users](https://github.com/ready4-dev/youthvars/releases/download/Documentation_0.0/youthvars_User.pdf) and [a more detailed inventory of contents intended for developers](https://github.com/ready4-dev/youthvars/releases/download/Documentation_0.0/youthvars_Developer.pdf);

-   an [initial `youthvars` release](https://github.com/ready4-dev/youthvars/releases/tag/Documentation_0.0) for hosting supporting files, the creation of which will trigger archiving on [Zenodo with a `youthvars` package DOI](https://zenodo.org/record/5646551); and

-   an [R-CMD-check continuous integration](https://github.com/ready4-dev/youthvars/actions/workflows/R-CMD-check.yaml) algorithm to be implemented each time a new version of `youthvars` is pushed to the `main` branch of the GitHub source code repository.

## Future documentation

A more detailed guide to using `ready4pack` will be created in 2023.

