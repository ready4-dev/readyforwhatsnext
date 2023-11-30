---
title: "Standardise Variable Values With Fuzzy Logic And Correspondence Tables"
linkTitle: "Standardise cost data (1)"
date: "2023-11-30"
description: "Costing health economic datasets is an activity that can involve repeated use of lookup tables. This tutorial describes how a module from the costly R package can help you to use a combination of fuzzy logic and correspondence tables to standardise variable values and thus facilitate partial automation of costing algorithms."
weight: 91
categories: 
- Documentation
tags: 
- Data - management
- Data - metadata
- Model
- Model - modules
- Model - modules (platforms)
- Software
- Software - libraries
- Software - libraries (costly)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: 09d3ac4d2c23332d
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the costly library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/costly/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/costly/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/costly/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/costly/'>costly</a></span><span class='o'>)</span></span></code></pre>

</div>

## In brief

The steps described and explained in this vignette can also be (more succinctly) accomplished with the following code.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCountries-class.html'>CostlyCountries</a></span><span class='o'>(</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"default"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"jw"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"logic"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span></span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span> </span></code></pre>

</div>

## Create project

We begin by creating `X`, an instance of the `CostlyCorrespondences` module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCorrespondences-class.html'>CostlyCorrespondences</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

## Supply seed dataset

We begin by creating a `CostlySeed` module instance that includes a dataset containing our variable of interest (in this case, countries). The dataset needs to be paired with a dataset dictionary using the `Ready4useDyad` module from the [ready4use R library](https://ready4-dev.github.io/ready4use/). You can supply a custom standards dataset (a tibble), dictionary (a ready4use_dictionary) and the concept represented by our variable of interest using a command of the following format.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># A &lt;- CostlySeed(Ready4useDyad_r4 = Ready4useDyad(ds_tb = tibble::tibble(), dictionary_r3 = ready4use_dictionary()), include_chr = c("Country"), label_1L_chr = "Country")</span></span></code></pre>

</div>

The `add_default_country_seed` function will perform the previous step using values that pair the `world.cities` dataset of the `maps` R library with an appropriate dictionary and specifies countries as the concept we will be standardising.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlySeed-class.html'>CostlySeed</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_default_country_seed.html'>add_default_country_seed</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

We can now inspect the first few records from our labelled seed dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"Ready4useDyad_r4"</span>, display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
City name
</th>
<th style="text-align:right;">
Country name
</th>
<th style="text-align:right;">
Population size
</th>
<th style="text-align:right;">
Latitude coordinate
</th>
<th style="text-align:right;">
Longitude coordinate
</th>
<th style="text-align:right;">
Is the nation's capital city
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
'Abasan al-Jadidah
</td>
<td style="text-align:right;">
Palestine
</td>
<td style="text-align:right;">
5629
</td>
<td style="text-align:right;">
31.31
</td>
<td style="text-align:right;">
34.34
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
'Abasan al-Kabirah
</td>
<td style="text-align:right;">
Palestine
</td>
<td style="text-align:right;">
18999
</td>
<td style="text-align:right;">
31.32
</td>
<td style="text-align:right;">
34.35
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
'Abdul Hakim
</td>
<td style="text-align:right;">
Pakistan
</td>
<td style="text-align:right;">
47788
</td>
<td style="text-align:right;">
30.55
</td>
<td style="text-align:right;">
72.11
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
'Abdullah-as-Salam
</td>
<td style="text-align:right;">
Kuwait
</td>
<td style="text-align:right;">
21817
</td>
<td style="text-align:right;">
29.36
</td>
<td style="text-align:right;">
47.98
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
'Abud
</td>
<td style="text-align:right;">
Palestine
</td>
<td style="text-align:right;">
2456
</td>
<td style="text-align:right;">
32.03
</td>
<td style="text-align:right;">
35.07
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
'Abwein
</td>
<td style="text-align:right;">
Palestine
</td>
<td style="text-align:right;">
3434
</td>
<td style="text-align:right;">
32.03
</td>
<td style="text-align:right;">
35.20
</td>
<td style="text-align:right;">
0
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

We can also inspect the data dictionary contained in `A`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>A</span>, <span class='s'>"Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"dict"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
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
name
</td>
<td style="text-align:right;">
City
</td>
<td style="text-align:right;">
City name
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
country.etc
</td>
<td style="text-align:right;">
Country
</td>
<td style="text-align:right;">
Country name
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
pop
</td>
<td style="text-align:right;">
Population
</td>
<td style="text-align:right;">
Population size
</td>
<td style="text-align:right;">
integer
</td>
</tr>
<tr>
<td style="text-align:left;">
lat
</td>
<td style="text-align:right;">
Latitude
</td>
<td style="text-align:right;">
Latitude coordinate
</td>
<td style="text-align:right;">
numeric
</td>
</tr>
<tr>
<td style="text-align:left;">
long
</td>
<td style="text-align:right;">
Longitude
</td>
<td style="text-align:right;">
Longitude coordinate
</td>
<td style="text-align:right;">
numeric
</td>
</tr>
<tr>
<td style="text-align:left;">
capital
</td>
<td style="text-align:right;">
Capital
</td>
<td style="text-align:right;">
Is the nation's capital city
</td>
<td style="text-align:right;">
integer
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

We now specify the dictionary category that corresponds to the variable we wish to standardise ("Country"). We need to use the same category name to label the results objects that we generate in subsequent steps.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span><span class='o'>@</span><span class='nv'>include_chr</span> <span class='o'>&lt;-</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>label_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"Country"</span></span></code></pre>

</div>

We now add `A` to `X`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='nv'>A</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"seed"</span><span class='o'>)</span></span></code></pre>

</div>

## Specify standards

We next must specify a dataset that includes the complete list of allowable variable values.

This workflow for this step is similar to that for specifying standards, except that instead of a `CostlySeed` module we use a `CostlyStandards` module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># Y &lt;- CostlyStandards(Ready4useDyad_r4 = Ready4useDyad(ds_tb = tibble::tibble(), dictionary_r3 = ready4use_dictionary()))</span></span></code></pre>

</div>

In many cases using the `ISO_3166_1` dataset from the `ISOcodes` library will be the optimal choice for the standardised form of country names. We can use the `add_country_standards` function to pair this dataset with its dictionary and create `B`, a `CostlyStandards` module instance.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>B</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyStandards-class.html'>CostlyStandards</a></span><span class='o'>(</span>Ready4useDyad_r4 <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useDyad-class.html'>Ready4useDyad</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_country_standards.html'>add_country_standards</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We can inspect the first few cases of the labelled version of the dataset in `B`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>B</span>, <span class='s'>"Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"Ready4useDyad_r4"</span>, display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
Alpabetical country code (two letters)
</th>
<th style="text-align:right;">
Alpabetical country code (three letters)
</th>
<th style="text-align:right;">
Numeric country code
</th>
<th style="text-align:right;">
Country name
</th>
<th style="text-align:right;">
Country name (official)
</th>
<th style="text-align:right;">
Country name (common alternative)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AW
</td>
<td style="text-align:right;">
ABW
</td>
<td style="text-align:right;">
533
</td>
<td style="text-align:right;">
Aruba
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
AF
</td>
<td style="text-align:right;">
AFG
</td>
<td style="text-align:right;">
004
</td>
<td style="text-align:right;">
Afghanistan
</td>
<td style="text-align:right;">
Islamic Republic of Afghanistan
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
AO
</td>
<td style="text-align:right;">
AGO
</td>
<td style="text-align:right;">
024
</td>
<td style="text-align:right;">
Angola
</td>
<td style="text-align:right;">
Republic of Angola
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
AI
</td>
<td style="text-align:right;">
AIA
</td>
<td style="text-align:right;">
660
</td>
<td style="text-align:right;">
Anguilla
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
AX
</td>
<td style="text-align:right;">
ALA
</td>
<td style="text-align:right;">
248
</td>
<td style="text-align:right;">
Åland Islands
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
AL
</td>
<td style="text-align:right;">
ALB
</td>
<td style="text-align:right;">
008
</td>
<td style="text-align:right;">
Albania
</td>
<td style="text-align:right;">
Republic of Albania
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

We can also inspect the data dictionary contained in `B`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>B</span>, <span class='s'>"Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"dict"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
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
Alpha_2
</td>
<td style="text-align:right;">
A2
</td>
<td style="text-align:right;">
Alpabetical country code (two letters)
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Alpha_3
</td>
<td style="text-align:right;">
A3
</td>
<td style="text-align:right;">
Alpabetical country code (three letters)
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Numeric
</td>
<td style="text-align:right;">
N
</td>
<td style="text-align:right;">
Numeric country code
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Name
</td>
<td style="text-align:right;">
Country
</td>
<td style="text-align:right;">
Country name
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Official_name
</td>
<td style="text-align:right;">
Official
</td>
<td style="text-align:right;">
Country name (official)
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Common_name
</td>
<td style="text-align:right;">
Common
</td>
<td style="text-align:right;">
Country name (common alternative)
</td>
<td style="text-align:right;">
character
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

We can now specifying both the concept (from the "Category" column of the data dictionary) that specifies allowable values for our target variable and all concepts we plan to use for fuzzy logic matching (described below).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>B</span><span class='o'>@</span><span class='nv'>label_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"Country"</span></span>
<span><span class='nv'>B</span><span class='o'>@</span><span class='nv'>include_chr</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Country"</span>, <span class='s'>"Official"</span>,<span class='s'>"Common"</span>,<span class='s'>"A3"</span>,<span class='s'>"A2"</span><span class='o'>)</span></span></code></pre>

</div>

We now add `B` to `X`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='nv'>B</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"standards"</span><span class='o'>)</span></span></code></pre>

</div>

## Compare variable of interest values from seed and standards dataset.

To identify any disparities between the variable of interest in our seed and standards datasets we can use the `ratify` method. Supplying the value "identity" ensures that the output will differ from input only in the slot reserved for results.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='s'>"identity"</span><span class='o'>)</span></span></code></pre>

</div>

We can now identify the values from our seed dataset variable of interest that were not in our standard values.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span></code></pre>

</div>

We can also identify standard values that were not present in the seed dataset variable of interest.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Absent_Values</span></span>
<span><span class='c'>#&gt;  [1] "Åland Islands"                                "Antarctica"                                  </span></span>
<span><span class='c'>#&gt;  [3] "Bolivia, Plurinational State of"              "Bonaire, Sint Eustatius and Saba"            </span></span>
<span><span class='c'>#&gt;  [5] "Bouvet Island"                                "British Indian Ocean Territory"              </span></span>
<span><span class='c'>#&gt;  [7] "Brunei Darussalam"                            "Cabo Verde"                                  </span></span>
<span><span class='c'>#&gt;  [9] "Christmas Island"                             "Cocos (Keeling) Islands"                     </span></span>
<span><span class='c'>#&gt; [11] "Congo, The Democratic Republic of the"        "Côte d'Ivoire"                               </span></span>
<span><span class='c'>#&gt; [13] "Curaçao"                                      "Czechia"                                     </span></span>
<span><span class='c'>#&gt; [15] "Eswatini"                                     "Falkland Islands (Malvinas)"                 </span></span>
<span><span class='c'>#&gt; [17] "French Southern Territories"                  "Guernsey"                                    </span></span>
<span><span class='c'>#&gt; [19] "Heard Island and McDonald Islands"            "Holy See (Vatican City State)"               </span></span>
<span><span class='c'>#&gt; [21] "Hong Kong"                                    "Iran, Islamic Republic of"                   </span></span>
<span><span class='c'>#&gt; [23] "Korea, Democratic People's Republic of"       "Korea, Republic of"                          </span></span>
<span><span class='c'>#&gt; [25] "Lao People's Democratic Republic"             "Macao"                                       </span></span>
<span><span class='c'>#&gt; [27] "Micronesia, Federated States of"              "Moldova, Republic of"                        </span></span>
<span><span class='c'>#&gt; [29] "Palestine, State of"                          "Réunion"                                     </span></span>
<span><span class='c'>#&gt; [31] "Russian Federation"                           "Saint Barthélemy"                            </span></span>
<span><span class='c'>#&gt; [33] "Saint Helena, Ascension and Tristan da Cunha" "Saint Martin (French part)"                  </span></span>
<span><span class='c'>#&gt; [35] "Saint Vincent and the Grenadines"             "Sint Maarten (Dutch part)"                   </span></span>
<span><span class='c'>#&gt; [37] "South Georgia and the South Sandwich Islands" "Syrian Arab Republic"                        </span></span>
<span><span class='c'>#&gt; [39] "Taiwan, Province of China"                    "Tanzania, United Republic of"                </span></span>
<span><span class='c'>#&gt; [41] "Timor-Leste"                                  "Turks and Caicos Islands"                    </span></span>
<span><span class='c'>#&gt; [43] "United Kingdom"                               "United States"                               </span></span>
<span><span class='c'>#&gt; [45] "United States Minor Outlying Islands"         "Venezuela, Bolivarian Republic of"           </span></span>
<span><span class='c'>#&gt; [47] "Viet Nam"                                     "Virgin Islands, British"                     </span></span>
<span><span class='c'>#&gt; [49] "Virgin Islands, U.S."</span></span>
<span></span></code></pre>

</div>

## Standardise variable values

We can explore the extent to which we can use fuzzy logic to reconcile some of these discrepancies. To identify the types of fuzzy logic algorithms we could use, run the following command to explore the relevant part of the documentation from the `stringdist` library.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># help("stringdist-metrics", package=stringdist)</span></span></code></pre>

</div>

In this case, we have chosen the Jaro, or Jaro-Winkler distance method ("jw").

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"jw"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"logic"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='kc'>NULL</span><span class='o'>)</span></span></code></pre>

</div>

This method will replace every previously invalid seed dataset variable value with the best available match identified by the selected fuzzy logic algorithm.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span>
<span><span class='c'>#&gt; character(0)</span></span>
<span></span></code></pre>

</div>

However, some of the replacements will be spurious as can be seen by inspecting the record of the replacements made.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Correspondences</span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'># A tibble: 41 × 2</span></span></span>
<span><span class='c'>#&gt;    old_nms_chr               new_nms_chr                          </span></span>
<span><span class='c'>#&gt;    <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                     <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                                </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 1</span> Azores                    Timor-Leste                          </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 2</span> Bolivia                   Bolivia, Plurinational State of      </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 3</span> British Virgin Islands    Virgin Islands, British              </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 4</span> Brunei                    Brunei Darussalam                    </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 5</span> Canary Islands            Åland Islands                        </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 6</span> Cape Verde                Cabo Verde                           </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 7</span> Congo Democratic Republic Congo, The Democratic Republic of the</span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 8</span> Czech Republic            Czechia                              </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 9</span> East Timor                Eswatini                             </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'>10</span> Easter Island             Christmas Island                     </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'># ℹ 31 more rows</span></span></span>
<span></span></code></pre>

</div>

For each of the incorrect correspondences, we will need to manually specify correct values. We can do this using the `ready4show_correspondences` sub-module.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># a &lt;- ready4show::renew.ready4show_correspondences(ready4show::ready4show_correspondences(), </span></span>
<span><span class='c'>#         old_nms_chr = c("old_name_1", "old_name_2", "etc...."), new_nms_chr = c("new_name_1", "new_name_2", "etc...."))</span></span></code></pre>

</div>

The `make_country_correspondences` can be used as a shortcut for creating the alternative correspondences for this specific example.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>a</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/make_country_correspondences.html'>make_country_correspondences</a></span><span class='o'>(</span><span class='s'>"cities"</span><span class='o'>)</span></span></code></pre>

</div>

We can inspect the values of this correspondence table.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span><span class='nv'>a</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
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
Azores
</td>
<td style="text-align:right;">
Portugal
</td>
</tr>
<tr>
<td style="text-align:left;">
Canary Islands
</td>
<td style="text-align:right;">
Spain
</td>
</tr>
<tr>
<td style="text-align:left;">
Easter Island
</td>
<td style="text-align:right;">
Chile
</td>
</tr>
<tr>
<td style="text-align:left;">
East Timor
</td>
<td style="text-align:right;">
Timor-Leste
</td>
</tr>
<tr>
<td style="text-align:left;">
Ivory Coast
</td>
<td style="text-align:right;">
Côte d'Ivoire
</td>
</tr>
<tr>
<td style="text-align:left;">
Kosovo
</td>
<td style="text-align:right;">
Kosovo
</td>
</tr>
<tr>
<td style="text-align:left;">
Madeira
</td>
<td style="text-align:right;">
Portugal
</td>
</tr>
<tr>
<td style="text-align:left;">
Netherlands Antilles
</td>
<td style="text-align:right;">
Bonaire, Sint Eustatius and Saba
</td>
</tr>
<tr>
<td style="text-align:left;">
Sicily
</td>
<td style="text-align:right;">
Italy
</td>
</tr>
<tr>
<td style="text-align:left;">
Vatican City
</td>
<td style="text-align:right;">
Holy See (Vatican City State)
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

When the ratify method was used to apply the fuzzy logic algorithm in a previous step, `X` was modified so that this logic is by default switched off for future calls to `ratify`. If we had created a new correspondence table that specified replacements for all invalid values, this would not be a problem. However, in this example we are only specifying correspondences where the fuzzy logic algorithm failed, so we need to again supply our desired fuzzy logic value.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"jw"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"logic"</span><span class='o'>)</span> </span></code></pre>

</div>

We now rerun our ratify method (which in this example will combine fuzzy logic with lookups from the manually created correspondences table).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='nv'>a</span><span class='o'>)</span></span></code></pre>

</div>

We once again inspect results.

Our correspondences table looks better.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Correspondences</span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'># A tibble: 41 × 2</span></span></span>
<span><span class='c'>#&gt;    old_nms_chr               new_nms_chr                          </span></span>
<span><span class='c'>#&gt;    <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                     <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                                </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 1</span> Azores                    Portugal                             </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 2</span> Bolivia                   Bolivia, Plurinational State of      </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 3</span> British Virgin Islands    Virgin Islands, British              </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 4</span> Brunei                    Brunei Darussalam                    </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 5</span> Canary Islands            Spain                                </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 6</span> Cape Verde                Cabo Verde                           </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 7</span> Congo Democratic Republic Congo, The Democratic Republic of the</span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 8</span> Czech Republic            Czechia                              </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'> 9</span> East Timor                Timor-Leste                          </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'>10</span> Easter Island             Chile                                </span></span>
<span><span class='c'>#&gt; <span style='color: #555555;'># ℹ 31 more rows</span></span></span>
<span></span></code></pre>

</div>

There is still a value that is not included in our standards.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span>
<span><span class='c'>#&gt; [1] "Kosovo"</span></span>
<span></span></code></pre>

</div>

We can rerun the `ratify` method to force the removal of any record that is not included in our standards dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='s'>"identity"</span><span class='o'>)</span></span></code></pre>

</div>

No invalid values remain.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span>
<span><span class='c'>#&gt; character(0)</span></span>
<span></span></code></pre>

</div>

However, there are also a some values from our standards dataset that are not represented in the results dataset values.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Validation</span><span class='o'>$</span><span class='nv'>Absent_Values</span></span>
<span><span class='c'>#&gt;  [1] "Åland Islands"                                "Antarctica"                                  </span></span>
<span><span class='c'>#&gt;  [3] "Bouvet Island"                                "British Indian Ocean Territory"              </span></span>
<span><span class='c'>#&gt;  [5] "Christmas Island"                             "Cocos (Keeling) Islands"                     </span></span>
<span><span class='c'>#&gt;  [7] "Curaçao"                                      "French Southern Territories"                 </span></span>
<span><span class='c'>#&gt;  [9] "Heard Island and McDonald Islands"            "Hong Kong"                                   </span></span>
<span><span class='c'>#&gt; [11] "Macao"                                        "Sint Maarten (Dutch part)"                   </span></span>
<span><span class='c'>#&gt; [13] "South Georgia and the South Sandwich Islands" "United States Minor Outlying Islands"</span></span>
<span></span></code></pre>

</div>

Whether this is a problem or not depends on the intended purposes of the standardised dataset we are creating. We could choose to rerun the previous steps after making edits to either or both of the standards dataset (e.g. we could delete any superfluous, outdated or incorrect records or use an entirely new standards dataset) and seed dataset (e.g. adding new records or recategorising existing records so that there are corresponding values for every missing standard value). In this case we are going to assume that the above missing values are not a cause for concern for the valid use of our updated dataset for it intended purposes. We can now create a new object `Y`, using our results dataset's `Ready4useDyad` module instance.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Lookup</span></span></code></pre>

</div>

We can inspect the records for cases corresponding to capital cities from our new dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>Y</span>,<span class='s'>"ds_tb"</span>,<span class='nv'>Y</span><span class='o'>@</span><span class='nv'>ds_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>capital</span><span class='o'>==</span><span class='m'>1</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span>type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
City name
</th>
<th style="text-align:right;">
Country name
</th>
<th style="text-align:right;">
Population size
</th>
<th style="text-align:right;">
Latitude coordinate
</th>
<th style="text-align:right;">
Longitude coordinate
</th>
<th style="text-align:right;">
Is the nation's capital city
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
'Amman
</td>
<td style="text-align:right;">
Jordan
</td>
<td style="text-align:right;">
1303197
</td>
<td style="text-align:right;">
31.95
</td>
<td style="text-align:right;">
35.93
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Abu Dhabi
</td>
<td style="text-align:right;">
United Arab Emirates
</td>
<td style="text-align:right;">
619316
</td>
<td style="text-align:right;">
24.48
</td>
<td style="text-align:right;">
54.37
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Abuja
</td>
<td style="text-align:right;">
Nigeria
</td>
<td style="text-align:right;">
178462
</td>
<td style="text-align:right;">
9.18
</td>
<td style="text-align:right;">
7.17
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Accra
</td>
<td style="text-align:right;">
Ghana
</td>
<td style="text-align:right;">
2029143
</td>
<td style="text-align:right;">
5.56
</td>
<td style="text-align:right;">
-0.20
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Adamstown
</td>
<td style="text-align:right;">
Pitcairn
</td>
<td style="text-align:right;">
51
</td>
<td style="text-align:right;">
-25.05
</td>
<td style="text-align:right;">
-130.10
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Addis Abeba
</td>
<td style="text-align:right;">
Ethiopia
</td>
<td style="text-align:right;">
2823167
</td>
<td style="text-align:right;">
9.03
</td>
<td style="text-align:right;">
38.74
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Agana
</td>
<td style="text-align:right;">
Guam
</td>
<td style="text-align:right;">
1041
</td>
<td style="text-align:right;">
13.47
</td>
<td style="text-align:right;">
144.75
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Algiers
</td>
<td style="text-align:right;">
Algeria
</td>
<td style="text-align:right;">
2029936
</td>
<td style="text-align:right;">
36.77
</td>
<td style="text-align:right;">
3.04
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Alofi
</td>
<td style="text-align:right;">
Niue
</td>
<td style="text-align:right;">
627
</td>
<td style="text-align:right;">
-19.05
</td>
<td style="text-align:right;">
-169.92
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Amsterdam
</td>
<td style="text-align:right;">
Netherlands
</td>
<td style="text-align:right;">
744159
</td>
<td style="text-align:right;">
52.37
</td>
<td style="text-align:right;">
4.89
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Andorra la Vella
</td>
<td style="text-align:right;">
Andorra
</td>
<td style="text-align:right;">
20314
</td>
<td style="text-align:right;">
42.51
</td>
<td style="text-align:right;">
1.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ankara
</td>
<td style="text-align:right;">
Turkey
</td>
<td style="text-align:right;">
3579706
</td>
<td style="text-align:right;">
39.93
</td>
<td style="text-align:right;">
32.85
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Antananarivo
</td>
<td style="text-align:right;">
Madagascar
</td>
<td style="text-align:right;">
1463754
</td>
<td style="text-align:right;">
-18.89
</td>
<td style="text-align:right;">
47.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Apia
</td>
<td style="text-align:right;">
Samoa
</td>
<td style="text-align:right;">
40805
</td>
<td style="text-align:right;">
-13.83
</td>
<td style="text-align:right;">
-171.76
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Asgabat
</td>
<td style="text-align:right;">
Turkmenistan
</td>
<td style="text-align:right;">
823013
</td>
<td style="text-align:right;">
37.95
</td>
<td style="text-align:right;">
58.38
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Asmara
</td>
<td style="text-align:right;">
Eritrea
</td>
<td style="text-align:right;">
578860
</td>
<td style="text-align:right;">
15.33
</td>
<td style="text-align:right;">
38.94
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Astana
</td>
<td style="text-align:right;">
Kazakhstan
</td>
<td style="text-align:right;">
351343
</td>
<td style="text-align:right;">
51.17
</td>
<td style="text-align:right;">
71.47
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Asuncion
</td>
<td style="text-align:right;">
Paraguay
</td>
<td style="text-align:right;">
507574
</td>
<td style="text-align:right;">
-25.30
</td>
<td style="text-align:right;">
-57.63
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Athens
</td>
<td style="text-align:right;">
Greece
</td>
<td style="text-align:right;">
725049
</td>
<td style="text-align:right;">
37.98
</td>
<td style="text-align:right;">
23.73
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Avarua
</td>
<td style="text-align:right;">
Cook Islands
</td>
<td style="text-align:right;">
13645
</td>
<td style="text-align:right;">
-21.20
</td>
<td style="text-align:right;">
-159.76
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Baghdad
</td>
<td style="text-align:right;">
Iraq
</td>
<td style="text-align:right;">
5753612
</td>
<td style="text-align:right;">
33.33
</td>
<td style="text-align:right;">
44.44
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bairiki
</td>
<td style="text-align:right;">
Kiribati
</td>
<td style="text-align:right;">
45982
</td>
<td style="text-align:right;">
1.33
</td>
<td style="text-align:right;">
172.99
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Baku
</td>
<td style="text-align:right;">
Azerbaijan
</td>
<td style="text-align:right;">
1118725
</td>
<td style="text-align:right;">
40.39
</td>
<td style="text-align:right;">
49.86
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bamako
</td>
<td style="text-align:right;">
Mali
</td>
<td style="text-align:right;">
1342519
</td>
<td style="text-align:right;">
12.65
</td>
<td style="text-align:right;">
-7.99
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bandar Seri Begawan
</td>
<td style="text-align:right;">
Brunei Darussalam
</td>
<td style="text-align:right;">
67077
</td>
<td style="text-align:right;">
4.93
</td>
<td style="text-align:right;">
114.95
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bangkok
</td>
<td style="text-align:right;">
Thailand
</td>
<td style="text-align:right;">
4935988
</td>
<td style="text-align:right;">
13.73
</td>
<td style="text-align:right;">
100.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bangui
</td>
<td style="text-align:right;">
Central African Republic
</td>
<td style="text-align:right;">
547668
</td>
<td style="text-align:right;">
4.36
</td>
<td style="text-align:right;">
18.56
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Banjul
</td>
<td style="text-align:right;">
Gambia
</td>
<td style="text-align:right;">
34388
</td>
<td style="text-align:right;">
13.46
</td>
<td style="text-align:right;">
-16.60
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Basse-Terre
</td>
<td style="text-align:right;">
Guadeloupe
</td>
<td style="text-align:right;">
11298
</td>
<td style="text-align:right;">
16.00
</td>
<td style="text-align:right;">
-61.72
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Basseterre
</td>
<td style="text-align:right;">
Saint Kitts and Nevis
</td>
<td style="text-align:right;">
12883
</td>
<td style="text-align:right;">
17.31
</td>
<td style="text-align:right;">
-62.73
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bayrut
</td>
<td style="text-align:right;">
Lebanon
</td>
<td style="text-align:right;">
1273440
</td>
<td style="text-align:right;">
33.88
</td>
<td style="text-align:right;">
35.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Beijing
</td>
<td style="text-align:right;">
China
</td>
<td style="text-align:right;">
7602069
</td>
<td style="text-align:right;">
39.93
</td>
<td style="text-align:right;">
116.40
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Belgrade
</td>
<td style="text-align:right;">
Serbia
</td>
<td style="text-align:right;">
1113589
</td>
<td style="text-align:right;">
44.83
</td>
<td style="text-align:right;">
20.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Belmopan
</td>
<td style="text-align:right;">
Belize
</td>
<td style="text-align:right;">
14590
</td>
<td style="text-align:right;">
17.25
</td>
<td style="text-align:right;">
-88.79
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Berlin
</td>
<td style="text-align:right;">
Germany
</td>
<td style="text-align:right;">
3378275
</td>
<td style="text-align:right;">
52.52
</td>
<td style="text-align:right;">
13.38
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bern
</td>
<td style="text-align:right;">
Switzerland
</td>
<td style="text-align:right;">
120596
</td>
<td style="text-align:right;">
46.95
</td>
<td style="text-align:right;">
7.44
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Biskek
</td>
<td style="text-align:right;">
Kyrgyzstan
</td>
<td style="text-align:right;">
915625
</td>
<td style="text-align:right;">
42.87
</td>
<td style="text-align:right;">
74.57
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bissau
</td>
<td style="text-align:right;">
Guinea-Bissau
</td>
<td style="text-align:right;">
404119
</td>
<td style="text-align:right;">
11.87
</td>
<td style="text-align:right;">
-15.60
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bogota
</td>
<td style="text-align:right;">
Colombia
</td>
<td style="text-align:right;">
7235084
</td>
<td style="text-align:right;">
4.63
</td>
<td style="text-align:right;">
-74.09
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Brasilia
</td>
<td style="text-align:right;">
Brazil
</td>
<td style="text-align:right;">
2260541
</td>
<td style="text-align:right;">
-15.78
</td>
<td style="text-align:right;">
-47.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bratislava
</td>
<td style="text-align:right;">
Slovakia
</td>
<td style="text-align:right;">
422452
</td>
<td style="text-align:right;">
48.16
</td>
<td style="text-align:right;">
17.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Brazzaville
</td>
<td style="text-align:right;">
Congo
</td>
<td style="text-align:right;">
1326975
</td>
<td style="text-align:right;">
-4.25
</td>
<td style="text-align:right;">
15.26
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bridgetown
</td>
<td style="text-align:right;">
Barbados
</td>
<td style="text-align:right;">
98725
</td>
<td style="text-align:right;">
13.11
</td>
<td style="text-align:right;">
-59.61
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Brussels
</td>
<td style="text-align:right;">
Belgium
</td>
<td style="text-align:right;">
1031925
</td>
<td style="text-align:right;">
50.83
</td>
<td style="text-align:right;">
4.33
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bucharest
</td>
<td style="text-align:right;">
Romania
</td>
<td style="text-align:right;">
1862930
</td>
<td style="text-align:right;">
44.44
</td>
<td style="text-align:right;">
26.10
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Budapest
</td>
<td style="text-align:right;">
Hungary
</td>
<td style="text-align:right;">
1700019
</td>
<td style="text-align:right;">
47.51
</td>
<td style="text-align:right;">
19.08
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Buenos Aires
</td>
<td style="text-align:right;">
Argentina
</td>
<td style="text-align:right;">
11595183
</td>
<td style="text-align:right;">
-34.61
</td>
<td style="text-align:right;">
-58.37
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Bujumbura
</td>
<td style="text-align:right;">
Burundi
</td>
<td style="text-align:right;">
336561
</td>
<td style="text-align:right;">
-3.37
</td>
<td style="text-align:right;">
29.35
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Cairo
</td>
<td style="text-align:right;">
Egypt
</td>
<td style="text-align:right;">
7836243
</td>
<td style="text-align:right;">
30.06
</td>
<td style="text-align:right;">
31.25
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Canberra
</td>
<td style="text-align:right;">
Australia
</td>
<td style="text-align:right;">
324736
</td>
<td style="text-align:right;">
-35.31
</td>
<td style="text-align:right;">
149.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Caracas
</td>
<td style="text-align:right;">
Venezuela, Bolivarian Republic of
</td>
<td style="text-align:right;">
1808937
</td>
<td style="text-align:right;">
10.54
</td>
<td style="text-align:right;">
-66.93
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Castries
</td>
<td style="text-align:right;">
Saint Lucia
</td>
<td style="text-align:right;">
12904
</td>
<td style="text-align:right;">
14.03
</td>
<td style="text-align:right;">
-60.98
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Cayenne
</td>
<td style="text-align:right;">
French Guiana
</td>
<td style="text-align:right;">
62926
</td>
<td style="text-align:right;">
4.92
</td>
<td style="text-align:right;">
-52.34
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Charlotte Amalie
</td>
<td style="text-align:right;">
Virgin Islands, U.S.
</td>
<td style="text-align:right;">
10415
</td>
<td style="text-align:right;">
18.35
</td>
<td style="text-align:right;">
-64.94
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Chisinau
</td>
<td style="text-align:right;">
Moldova, Republic of
</td>
<td style="text-align:right;">
623671
</td>
<td style="text-align:right;">
47.03
</td>
<td style="text-align:right;">
28.83
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Cockburn Town
</td>
<td style="text-align:right;">
Turks and Caicos Islands
</td>
<td style="text-align:right;">
174
</td>
<td style="text-align:right;">
21.46
</td>
<td style="text-align:right;">
-71.14
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Colombo
</td>
<td style="text-align:right;">
Sri Lanka
</td>
<td style="text-align:right;">
649496
</td>
<td style="text-align:right;">
6.93
</td>
<td style="text-align:right;">
79.85
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Conakry
</td>
<td style="text-align:right;">
Guinea
</td>
<td style="text-align:right;">
1970382
</td>
<td style="text-align:right;">
9.55
</td>
<td style="text-align:right;">
-13.67
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Copenhagen
</td>
<td style="text-align:right;">
Denmark
</td>
<td style="text-align:right;">
1091978
</td>
<td style="text-align:right;">
55.68
</td>
<td style="text-align:right;">
12.57
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dakar
</td>
<td style="text-align:right;">
Senegal
</td>
<td style="text-align:right;">
2406598
</td>
<td style="text-align:right;">
14.72
</td>
<td style="text-align:right;">
-17.48
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Damascus
</td>
<td style="text-align:right;">
Syrian Arab Republic
</td>
<td style="text-align:right;">
1580909
</td>
<td style="text-align:right;">
33.50
</td>
<td style="text-align:right;">
36.32
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dhaka
</td>
<td style="text-align:right;">
Bangladesh
</td>
<td style="text-align:right;">
6724976
</td>
<td style="text-align:right;">
23.70
</td>
<td style="text-align:right;">
90.39
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dili
</td>
<td style="text-align:right;">
Timor-Leste
</td>
<td style="text-align:right;">
163305
</td>
<td style="text-align:right;">
-8.57
</td>
<td style="text-align:right;">
125.58
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dodoma
</td>
<td style="text-align:right;">
Tanzania, United Republic of
</td>
<td style="text-align:right;">
188150
</td>
<td style="text-align:right;">
-6.17
</td>
<td style="text-align:right;">
35.74
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Doha
</td>
<td style="text-align:right;">
Qatar
</td>
<td style="text-align:right;">
351381
</td>
<td style="text-align:right;">
25.30
</td>
<td style="text-align:right;">
51.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Douglas
</td>
<td style="text-align:right;">
Isle of Man
</td>
<td style="text-align:right;">
25621
</td>
<td style="text-align:right;">
54.15
</td>
<td style="text-align:right;">
-4.48
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dublin
</td>
<td style="text-align:right;">
Ireland
</td>
<td style="text-align:right;">
1030431
</td>
<td style="text-align:right;">
53.33
</td>
<td style="text-align:right;">
-6.25
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dushanbe
</td>
<td style="text-align:right;">
Tajikistan
</td>
<td style="text-align:right;">
538456
</td>
<td style="text-align:right;">
38.57
</td>
<td style="text-align:right;">
68.78
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Dzaoudzi
</td>
<td style="text-align:right;">
Mayotte
</td>
<td style="text-align:right;">
14558
</td>
<td style="text-align:right;">
-12.77
</td>
<td style="text-align:right;">
45.25
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Fakaofo
</td>
<td style="text-align:right;">
Tokelau
</td>
<td style="text-align:right;">
267
</td>
<td style="text-align:right;">
-9.38
</td>
<td style="text-align:right;">
-171.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Fort-de-France
</td>
<td style="text-align:right;">
Martinique
</td>
<td style="text-align:right;">
89233
</td>
<td style="text-align:right;">
14.60
</td>
<td style="text-align:right;">
-61.08
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Freetown
</td>
<td style="text-align:right;">
Sierra Leone
</td>
<td style="text-align:right;">
818709
</td>
<td style="text-align:right;">
8.49
</td>
<td style="text-align:right;">
-13.24
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Gaborone
</td>
<td style="text-align:right;">
Botswana
</td>
<td style="text-align:right;">
214412
</td>
<td style="text-align:right;">
-24.65
</td>
<td style="text-align:right;">
25.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
George Town
</td>
<td style="text-align:right;">
Cayman Islands
</td>
<td style="text-align:right;">
30570
</td>
<td style="text-align:right;">
19.28
</td>
<td style="text-align:right;">
-81.39
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Georgetown
</td>
<td style="text-align:right;">
Guyana
</td>
<td style="text-align:right;">
236878
</td>
<td style="text-align:right;">
6.79
</td>
<td style="text-align:right;">
-58.16
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Gibraltar
</td>
<td style="text-align:right;">
Gibraltar
</td>
<td style="text-align:right;">
26404
</td>
<td style="text-align:right;">
36.14
</td>
<td style="text-align:right;">
-5.35
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Guatemala
</td>
<td style="text-align:right;">
Guatemala
</td>
<td style="text-align:right;">
1010253
</td>
<td style="text-align:right;">
14.63
</td>
<td style="text-align:right;">
-90.55
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ha Noi
</td>
<td style="text-align:right;">
Viet Nam
</td>
<td style="text-align:right;">
1452055
</td>
<td style="text-align:right;">
21.03
</td>
<td style="text-align:right;">
105.84
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Hamilton
</td>
<td style="text-align:right;">
Bermuda
</td>
<td style="text-align:right;">
889
</td>
<td style="text-align:right;">
32.30
</td>
<td style="text-align:right;">
-64.79
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Harare
</td>
<td style="text-align:right;">
Zimbabwe
</td>
<td style="text-align:right;">
1575127
</td>
<td style="text-align:right;">
-17.82
</td>
<td style="text-align:right;">
31.05
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Havanna
</td>
<td style="text-align:right;">
Cuba
</td>
<td style="text-align:right;">
2163132
</td>
<td style="text-align:right;">
23.13
</td>
<td style="text-align:right;">
-82.39
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Helsinki
</td>
<td style="text-align:right;">
Finland
</td>
<td style="text-align:right;">
558341
</td>
<td style="text-align:right;">
60.17
</td>
<td style="text-align:right;">
24.94
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Honiara
</td>
<td style="text-align:right;">
Solomon Islands
</td>
<td style="text-align:right;">
57410
</td>
<td style="text-align:right;">
-9.43
</td>
<td style="text-align:right;">
159.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Islamabad
</td>
<td style="text-align:right;">
Pakistan
</td>
<td style="text-align:right;">
794431
</td>
<td style="text-align:right;">
33.72
</td>
<td style="text-align:right;">
73.06
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Jakarta
</td>
<td style="text-align:right;">
Indonesia
</td>
<td style="text-align:right;">
8556798
</td>
<td style="text-align:right;">
-6.18
</td>
<td style="text-align:right;">
106.83
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Jamestown
</td>
<td style="text-align:right;">
Saint Helena, Ascension and Tristan da Cunha
</td>
<td style="text-align:right;">
603
</td>
<td style="text-align:right;">
-15.92
</td>
<td style="text-align:right;">
-5.71
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Jerusalem
</td>
<td style="text-align:right;">
Israel
</td>
<td style="text-align:right;">
731731
</td>
<td style="text-align:right;">
31.78
</td>
<td style="text-align:right;">
35.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Jibuti
</td>
<td style="text-align:right;">
Djibouti
</td>
<td style="text-align:right;">
633884
</td>
<td style="text-align:right;">
11.56
</td>
<td style="text-align:right;">
43.15
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kabul
</td>
<td style="text-align:right;">
Afghanistan
</td>
<td style="text-align:right;">
3120963
</td>
<td style="text-align:right;">
34.53
</td>
<td style="text-align:right;">
69.17
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kampala
</td>
<td style="text-align:right;">
Uganda
</td>
<td style="text-align:right;">
1403619
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
32.58
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kathmandu
</td>
<td style="text-align:right;">
Nepal
</td>
<td style="text-align:right;">
822930
</td>
<td style="text-align:right;">
27.71
</td>
<td style="text-align:right;">
85.31
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Khartoum
</td>
<td style="text-align:right;">
Sudan
</td>
<td style="text-align:right;">
2090001
</td>
<td style="text-align:right;">
15.58
</td>
<td style="text-align:right;">
32.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kiev
</td>
<td style="text-align:right;">
Ukraine
</td>
<td style="text-align:right;">
2491404
</td>
<td style="text-align:right;">
50.43
</td>
<td style="text-align:right;">
30.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kigali
</td>
<td style="text-align:right;">
Rwanda
</td>
<td style="text-align:right;">
800003
</td>
<td style="text-align:right;">
-1.94
</td>
<td style="text-align:right;">
30.06
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kingston
</td>
<td style="text-align:right;">
Jamaica
</td>
<td style="text-align:right;">
585300
</td>
<td style="text-align:right;">
17.99
</td>
<td style="text-align:right;">
-76.80
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kingston
</td>
<td style="text-align:right;">
Norfolk Island
</td>
<td style="text-align:right;">
890
</td>
<td style="text-align:right;">
-29.03
</td>
<td style="text-align:right;">
168.05
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kingstown
</td>
<td style="text-align:right;">
Saint Vincent and the Grenadines
</td>
<td style="text-align:right;">
18160
</td>
<td style="text-align:right;">
13.16
</td>
<td style="text-align:right;">
-61.23
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kinshasa
</td>
<td style="text-align:right;">
Congo, The Democratic Republic of the
</td>
<td style="text-align:right;">
8096254
</td>
<td style="text-align:right;">
-4.31
</td>
<td style="text-align:right;">
15.32
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Koror
</td>
<td style="text-align:right;">
Palau
</td>
<td style="text-align:right;">
11458
</td>
<td style="text-align:right;">
7.35
</td>
<td style="text-align:right;">
134.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Kuala Lumpur
</td>
<td style="text-align:right;">
Malaysia
</td>
<td style="text-align:right;">
1482359
</td>
<td style="text-align:right;">
3.16
</td>
<td style="text-align:right;">
101.71
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Libreville
</td>
<td style="text-align:right;">
Gabon
</td>
<td style="text-align:right;">
591356
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
9.45
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Lilongwe
</td>
<td style="text-align:right;">
Malawi
</td>
<td style="text-align:right;">
683477
</td>
<td style="text-align:right;">
-13.97
</td>
<td style="text-align:right;">
33.80
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Lima
</td>
<td style="text-align:right;">
Peru
</td>
<td style="text-align:right;">
7857121
</td>
<td style="text-align:right;">
-12.07
</td>
<td style="text-align:right;">
-77.05
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Lisbon
</td>
<td style="text-align:right;">
Portugal
</td>
<td style="text-align:right;">
508209
</td>
<td style="text-align:right;">
38.72
</td>
<td style="text-align:right;">
-9.14
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ljubljana
</td>
<td style="text-align:right;">
Slovenia
</td>
<td style="text-align:right;">
254188
</td>
<td style="text-align:right;">
46.06
</td>
<td style="text-align:right;">
14.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Lome
</td>
<td style="text-align:right;">
Togo
</td>
<td style="text-align:right;">
737751
</td>
<td style="text-align:right;">
6.17
</td>
<td style="text-align:right;">
1.35
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
London
</td>
<td style="text-align:right;">
United Kingdom
</td>
<td style="text-align:right;">
7489022
</td>
<td style="text-align:right;">
51.52
</td>
<td style="text-align:right;">
-0.10
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Longyearbyen
</td>
<td style="text-align:right;">
Svalbard and Jan Mayen
</td>
<td style="text-align:right;">
1263
</td>
<td style="text-align:right;">
78.21
</td>
<td style="text-align:right;">
15.61
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Luanda
</td>
<td style="text-align:right;">
Angola
</td>
<td style="text-align:right;">
2875277
</td>
<td style="text-align:right;">
-8.82
</td>
<td style="text-align:right;">
13.24
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Lusaka
</td>
<td style="text-align:right;">
Zambia
</td>
<td style="text-align:right;">
1306577
</td>
<td style="text-align:right;">
-15.42
</td>
<td style="text-align:right;">
28.29
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Luxemburg
</td>
<td style="text-align:right;">
Luxembourg
</td>
<td style="text-align:right;">
76380
</td>
<td style="text-align:right;">
49.62
</td>
<td style="text-align:right;">
6.12
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Madrid
</td>
<td style="text-align:right;">
Spain
</td>
<td style="text-align:right;">
3146804
</td>
<td style="text-align:right;">
40.42
</td>
<td style="text-align:right;">
-3.71
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Malabo
</td>
<td style="text-align:right;">
Equatorial Guinea
</td>
<td style="text-align:right;">
161409
</td>
<td style="text-align:right;">
3.74
</td>
<td style="text-align:right;">
8.79
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Male
</td>
<td style="text-align:right;">
Maldives
</td>
<td style="text-align:right;">
87154
</td>
<td style="text-align:right;">
4.17
</td>
<td style="text-align:right;">
73.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Managua
</td>
<td style="text-align:right;">
Nicaragua
</td>
<td style="text-align:right;">
990417
</td>
<td style="text-align:right;">
12.15
</td>
<td style="text-align:right;">
-86.27
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Manama
</td>
<td style="text-align:right;">
Bahrain
</td>
<td style="text-align:right;">
147894
</td>
<td style="text-align:right;">
26.21
</td>
<td style="text-align:right;">
50.58
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Manila
</td>
<td style="text-align:right;">
Philippines
</td>
<td style="text-align:right;">
10546511
</td>
<td style="text-align:right;">
14.62
</td>
<td style="text-align:right;">
120.97
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Maputo
</td>
<td style="text-align:right;">
Mozambique
</td>
<td style="text-align:right;">
1220167
</td>
<td style="text-align:right;">
-25.95
</td>
<td style="text-align:right;">
32.57
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Maseru
</td>
<td style="text-align:right;">
Lesotho
</td>
<td style="text-align:right;">
116268
</td>
<td style="text-align:right;">
-29.31
</td>
<td style="text-align:right;">
27.49
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Mata'utu
</td>
<td style="text-align:right;">
Wallis and Futuna
</td>
<td style="text-align:right;">
1310
</td>
<td style="text-align:right;">
-13.28
</td>
<td style="text-align:right;">
-176.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Mbabane
</td>
<td style="text-align:right;">
Eswatini
</td>
<td style="text-align:right;">
78740
</td>
<td style="text-align:right;">
-26.32
</td>
<td style="text-align:right;">
31.14
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Mexico City
</td>
<td style="text-align:right;">
Mexico
</td>
<td style="text-align:right;">
8659409
</td>
<td style="text-align:right;">
19.43
</td>
<td style="text-align:right;">
-99.14
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Minsk
</td>
<td style="text-align:right;">
Belarus
</td>
<td style="text-align:right;">
1747482
</td>
<td style="text-align:right;">
53.91
</td>
<td style="text-align:right;">
27.55
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Mogadishu
</td>
<td style="text-align:right;">
Somalia
</td>
<td style="text-align:right;">
2723378
</td>
<td style="text-align:right;">
2.05
</td>
<td style="text-align:right;">
45.33
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Monaco-Ville
</td>
<td style="text-align:right;">
Monaco
</td>
<td style="text-align:right;">
975
</td>
<td style="text-align:right;">
43.74
</td>
<td style="text-align:right;">
7.42
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Monrovia
</td>
<td style="text-align:right;">
Liberia
</td>
<td style="text-align:right;">
954458
</td>
<td style="text-align:right;">
6.31
</td>
<td style="text-align:right;">
-10.80
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Montevideo
</td>
<td style="text-align:right;">
Uruguay
</td>
<td style="text-align:right;">
1271664
</td>
<td style="text-align:right;">
-34.87
</td>
<td style="text-align:right;">
-56.17
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Moroni
</td>
<td style="text-align:right;">
Comoros
</td>
<td style="text-align:right;">
43704
</td>
<td style="text-align:right;">
-11.74
</td>
<td style="text-align:right;">
43.23
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Moscow
</td>
<td style="text-align:right;">
Russian Federation
</td>
<td style="text-align:right;">
10472629
</td>
<td style="text-align:right;">
55.75
</td>
<td style="text-align:right;">
37.62
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Muscat
</td>
<td style="text-align:right;">
Oman
</td>
<td style="text-align:right;">
24122
</td>
<td style="text-align:right;">
23.61
</td>
<td style="text-align:right;">
58.54
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
N'Djamena
</td>
<td style="text-align:right;">
Chad
</td>
<td style="text-align:right;">
737281
</td>
<td style="text-align:right;">
12.11
</td>
<td style="text-align:right;">
15.05
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nairobi
</td>
<td style="text-align:right;">
Kenya
</td>
<td style="text-align:right;">
2864667
</td>
<td style="text-align:right;">
-1.29
</td>
<td style="text-align:right;">
36.82
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nassau
</td>
<td style="text-align:right;">
Bahamas
</td>
<td style="text-align:right;">
231519
</td>
<td style="text-align:right;">
25.06
</td>
<td style="text-align:right;">
-77.33
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ni Dilli
</td>
<td style="text-align:right;">
India
</td>
<td style="text-align:right;">
321883
</td>
<td style="text-align:right;">
28.60
</td>
<td style="text-align:right;">
77.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Niamey
</td>
<td style="text-align:right;">
Niger
</td>
<td style="text-align:right;">
801297
</td>
<td style="text-align:right;">
13.52
</td>
<td style="text-align:right;">
2.12
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nicosia
</td>
<td style="text-align:right;">
Cyprus
</td>
<td style="text-align:right;">
202488
</td>
<td style="text-align:right;">
35.16
</td>
<td style="text-align:right;">
33.38
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nicosia
</td>
<td style="text-align:right;">
Cyprus
</td>
<td style="text-align:right;">
42372
</td>
<td style="text-align:right;">
35.18
</td>
<td style="text-align:right;">
33.37
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nouakchott
</td>
<td style="text-align:right;">
Mauritania
</td>
<td style="text-align:right;">
731242
</td>
<td style="text-align:right;">
18.09
</td>
<td style="text-align:right;">
-15.98
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Noumea
</td>
<td style="text-align:right;">
New Caledonia
</td>
<td style="text-align:right;">
94751
</td>
<td style="text-align:right;">
-22.27
</td>
<td style="text-align:right;">
166.44
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nuku'alofa
</td>
<td style="text-align:right;">
Tonga
</td>
<td style="text-align:right;">
23733
</td>
<td style="text-align:right;">
-21.14
</td>
<td style="text-align:right;">
-175.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Nuuk
</td>
<td style="text-align:right;">
Greenland
</td>
<td style="text-align:right;">
15243
</td>
<td style="text-align:right;">
64.18
</td>
<td style="text-align:right;">
-51.73
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Oranjestad
</td>
<td style="text-align:right;">
Aruba
</td>
<td style="text-align:right;">
30710
</td>
<td style="text-align:right;">
12.53
</td>
<td style="text-align:right;">
-70.03
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Oslo
</td>
<td style="text-align:right;">
Norway
</td>
<td style="text-align:right;">
821445
</td>
<td style="text-align:right;">
59.91
</td>
<td style="text-align:right;">
10.75
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ottawa
</td>
<td style="text-align:right;">
Canada
</td>
<td style="text-align:right;">
885542
</td>
<td style="text-align:right;">
45.42
</td>
<td style="text-align:right;">
-75.71
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ouagadougou
</td>
<td style="text-align:right;">
Burkina Faso
</td>
<td style="text-align:right;">
1119775
</td>
<td style="text-align:right;">
12.37
</td>
<td style="text-align:right;">
-1.53
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Pago Pago
</td>
<td style="text-align:right;">
American Samoa
</td>
<td style="text-align:right;">
4180
</td>
<td style="text-align:right;">
-14.24
</td>
<td style="text-align:right;">
-170.72
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Palikir
</td>
<td style="text-align:right;">
Micronesia, Federated States of
</td>
<td style="text-align:right;">
4552
</td>
<td style="text-align:right;">
6.92
</td>
<td style="text-align:right;">
158.16
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Panama
</td>
<td style="text-align:right;">
Panama
</td>
<td style="text-align:right;">
406070
</td>
<td style="text-align:right;">
8.97
</td>
<td style="text-align:right;">
-79.53
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Papeete
</td>
<td style="text-align:right;">
French Polynesia
</td>
<td style="text-align:right;">
26400
</td>
<td style="text-align:right;">
-17.52
</td>
<td style="text-align:right;">
-149.56
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Paramaribo
</td>
<td style="text-align:right;">
Suriname
</td>
<td style="text-align:right;">
224925
</td>
<td style="text-align:right;">
5.85
</td>
<td style="text-align:right;">
-55.20
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Paris
</td>
<td style="text-align:right;">
France
</td>
<td style="text-align:right;">
2141839
</td>
<td style="text-align:right;">
48.86
</td>
<td style="text-align:right;">
2.34
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Phnum Penh
</td>
<td style="text-align:right;">
Cambodia
</td>
<td style="text-align:right;">
1673131
</td>
<td style="text-align:right;">
11.57
</td>
<td style="text-align:right;">
104.92
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Port Louis
</td>
<td style="text-align:right;">
Mauritius
</td>
<td style="text-align:right;">
156760
</td>
<td style="text-align:right;">
-20.17
</td>
<td style="text-align:right;">
57.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Port Moresby
</td>
<td style="text-align:right;">
Papua New Guinea
</td>
<td style="text-align:right;">
289861
</td>
<td style="text-align:right;">
-9.48
</td>
<td style="text-align:right;">
147.18
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Port Stanley
</td>
<td style="text-align:right;">
Falkland Islands (Malvinas)
</td>
<td style="text-align:right;">
2269
</td>
<td style="text-align:right;">
-51.70
</td>
<td style="text-align:right;">
-57.82
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Port of Spain
</td>
<td style="text-align:right;">
Trinidad and Tobago
</td>
<td style="text-align:right;">
49764
</td>
<td style="text-align:right;">
10.66
</td>
<td style="text-align:right;">
-61.51
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Port-au-Prince
</td>
<td style="text-align:right;">
Haiti
</td>
<td style="text-align:right;">
1277104
</td>
<td style="text-align:right;">
18.54
</td>
<td style="text-align:right;">
-72.34
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Porto Novo
</td>
<td style="text-align:right;">
Benin
</td>
<td style="text-align:right;">
238199
</td>
<td style="text-align:right;">
6.48
</td>
<td style="text-align:right;">
2.63
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Prague
</td>
<td style="text-align:right;">
Czechia
</td>
<td style="text-align:right;">
1168374
</td>
<td style="text-align:right;">
50.08
</td>
<td style="text-align:right;">
14.43
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Praia
</td>
<td style="text-align:right;">
Cabo Verde
</td>
<td style="text-align:right;">
117342
</td>
<td style="text-align:right;">
14.93
</td>
<td style="text-align:right;">
-23.54
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Pretoria
</td>
<td style="text-align:right;">
South Africa
</td>
<td style="text-align:right;">
1687779
</td>
<td style="text-align:right;">
-25.73
</td>
<td style="text-align:right;">
28.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Pyongyang
</td>
<td style="text-align:right;">
Korea, Democratic People's Republic of
</td>
<td style="text-align:right;">
2992272
</td>
<td style="text-align:right;">
39.02
</td>
<td style="text-align:right;">
125.75
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Quito
</td>
<td style="text-align:right;">
Ecuador
</td>
<td style="text-align:right;">
1399814
</td>
<td style="text-align:right;">
-0.19
</td>
<td style="text-align:right;">
-78.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Rabat
</td>
<td style="text-align:right;">
Morocco
</td>
<td style="text-align:right;">
1688738
</td>
<td style="text-align:right;">
34.02
</td>
<td style="text-align:right;">
-6.84
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Rangoon
</td>
<td style="text-align:right;">
Myanmar
</td>
<td style="text-align:right;">
4572948
</td>
<td style="text-align:right;">
16.79
</td>
<td style="text-align:right;">
96.15
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Reykjavik
</td>
<td style="text-align:right;">
Iceland
</td>
<td style="text-align:right;">
114576
</td>
<td style="text-align:right;">
64.14
</td>
<td style="text-align:right;">
-21.92
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Riga
</td>
<td style="text-align:right;">
Latvia
</td>
<td style="text-align:right;">
738386
</td>
<td style="text-align:right;">
56.97
</td>
<td style="text-align:right;">
24.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Rita
</td>
<td style="text-align:right;">
Marshall Islands
</td>
<td style="text-align:right;">
21270
</td>
<td style="text-align:right;">
7.12
</td>
<td style="text-align:right;">
171.06
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Riyadh
</td>
<td style="text-align:right;">
Saudi Arabia
</td>
<td style="text-align:right;">
4328067
</td>
<td style="text-align:right;">
24.65
</td>
<td style="text-align:right;">
46.77
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Road Town
</td>
<td style="text-align:right;">
Virgin Islands, British
</td>
<td style="text-align:right;">
8613
</td>
<td style="text-align:right;">
18.43
</td>
<td style="text-align:right;">
-64.63
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Rome
</td>
<td style="text-align:right;">
Italy
</td>
<td style="text-align:right;">
2561181
</td>
<td style="text-align:right;">
41.89
</td>
<td style="text-align:right;">
12.50
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Roseau
</td>
<td style="text-align:right;">
Dominica
</td>
<td style="text-align:right;">
16577
</td>
<td style="text-align:right;">
15.30
</td>
<td style="text-align:right;">
-61.39
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint George's
</td>
<td style="text-align:right;">
Grenada
</td>
<td style="text-align:right;">
4315
</td>
<td style="text-align:right;">
12.06
</td>
<td style="text-align:right;">
-61.74
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Helier
</td>
<td style="text-align:right;">
Jersey
</td>
<td style="text-align:right;">
28910
</td>
<td style="text-align:right;">
49.19
</td>
<td style="text-align:right;">
-2.11
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint John's
</td>
<td style="text-align:right;">
Antigua and Barbuda
</td>
<td style="text-align:right;">
25321
</td>
<td style="text-align:right;">
17.11
</td>
<td style="text-align:right;">
-61.85
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Peter Port
</td>
<td style="text-align:right;">
Guernsey
</td>
<td style="text-align:right;">
16702
</td>
<td style="text-align:right;">
49.47
</td>
<td style="text-align:right;">
-2.55
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint-Denis
</td>
<td style="text-align:right;">
Réunion
</td>
<td style="text-align:right;">
137787
</td>
<td style="text-align:right;">
-20.87
</td>
<td style="text-align:right;">
55.46
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint-Pierre
</td>
<td style="text-align:right;">
Saint Pierre and Miquelon
</td>
<td style="text-align:right;">
6254
</td>
<td style="text-align:right;">
46.79
</td>
<td style="text-align:right;">
-56.18
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San Jose
</td>
<td style="text-align:right;">
Costa Rica
</td>
<td style="text-align:right;">
32187
</td>
<td style="text-align:right;">
10.97
</td>
<td style="text-align:right;">
-85.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San Jose
</td>
<td style="text-align:right;">
Costa Rica
</td>
<td style="text-align:right;">
339588
</td>
<td style="text-align:right;">
9.93
</td>
<td style="text-align:right;">
-84.08
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San Juan
</td>
<td style="text-align:right;">
Puerto Rico
</td>
<td style="text-align:right;">
417154
</td>
<td style="text-align:right;">
18.44
</td>
<td style="text-align:right;">
-66.13
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San Marino
</td>
<td style="text-align:right;">
San Marino
</td>
<td style="text-align:right;">
4624
</td>
<td style="text-align:right;">
43.94
</td>
<td style="text-align:right;">
12.43
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San Salvador
</td>
<td style="text-align:right;">
El Salvador
</td>
<td style="text-align:right;">
534409
</td>
<td style="text-align:right;">
13.69
</td>
<td style="text-align:right;">
-89.19
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
San'a
</td>
<td style="text-align:right;">
Yemen
</td>
<td style="text-align:right;">
1921589
</td>
<td style="text-align:right;">
15.38
</td>
<td style="text-align:right;">
44.21
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Santiago
</td>
<td style="text-align:right;">
Chile
</td>
<td style="text-align:right;">
4893495
</td>
<td style="text-align:right;">
-33.46
</td>
<td style="text-align:right;">
-70.64
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Santo Domingo
</td>
<td style="text-align:right;">
Dominican Republic
</td>
<td style="text-align:right;">
2253437
</td>
<td style="text-align:right;">
18.48
</td>
<td style="text-align:right;">
-69.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Sao Tome
</td>
<td style="text-align:right;">
Sao Tome and Principe
</td>
<td style="text-align:right;">
63772
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
6.73
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Sarajevo
</td>
<td style="text-align:right;">
Bosnia and Herzegovina
</td>
<td style="text-align:right;">
737350
</td>
<td style="text-align:right;">
43.85
</td>
<td style="text-align:right;">
18.38
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Singapore
</td>
<td style="text-align:right;">
Singapore
</td>
<td style="text-align:right;">
3601745
</td>
<td style="text-align:right;">
1.30
</td>
<td style="text-align:right;">
103.85
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Skopje
</td>
<td style="text-align:right;">
North Macedonia
</td>
<td style="text-align:right;">
477493
</td>
<td style="text-align:right;">
42.00
</td>
<td style="text-align:right;">
21.47
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Sofia
</td>
<td style="text-align:right;">
Bulgaria
</td>
<td style="text-align:right;">
1166143
</td>
<td style="text-align:right;">
42.69
</td>
<td style="text-align:right;">
23.31
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Seoul
</td>
<td style="text-align:right;">
Korea, Republic of
</td>
<td style="text-align:right;">
10409345
</td>
<td style="text-align:right;">
37.56
</td>
<td style="text-align:right;">
126.99
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Stockholm
</td>
<td style="text-align:right;">
Sweden
</td>
<td style="text-align:right;">
1260712
</td>
<td style="text-align:right;">
59.33
</td>
<td style="text-align:right;">
18.07
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Sucre
</td>
<td style="text-align:right;">
Bolivia, Plurinational State of
</td>
<td style="text-align:right;">
232669
</td>
<td style="text-align:right;">
-19.06
</td>
<td style="text-align:right;">
-65.26
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Susupe
</td>
<td style="text-align:right;">
Northern Mariana Islands
</td>
<td style="text-align:right;">
2402
</td>
<td style="text-align:right;">
15.14
</td>
<td style="text-align:right;">
145.70
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Taipei
</td>
<td style="text-align:right;">
Taiwan, Province of China
</td>
<td style="text-align:right;">
2491662
</td>
<td style="text-align:right;">
25.02
</td>
<td style="text-align:right;">
121.45
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tallinn
</td>
<td style="text-align:right;">
Estonia
</td>
<td style="text-align:right;">
392386
</td>
<td style="text-align:right;">
59.44
</td>
<td style="text-align:right;">
24.74
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tashkent
</td>
<td style="text-align:right;">
Uzbekistan
</td>
<td style="text-align:right;">
1967879
</td>
<td style="text-align:right;">
41.31
</td>
<td style="text-align:right;">
69.30
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tbilisi
</td>
<td style="text-align:right;">
Georgia
</td>
<td style="text-align:right;">
1038343
</td>
<td style="text-align:right;">
41.72
</td>
<td style="text-align:right;">
44.79
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tegucigalpa
</td>
<td style="text-align:right;">
Honduras
</td>
<td style="text-align:right;">
872403
</td>
<td style="text-align:right;">
14.09
</td>
<td style="text-align:right;">
-87.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tehran
</td>
<td style="text-align:right;">
Iran, Islamic Republic of
</td>
<td style="text-align:right;">
7160094
</td>
<td style="text-align:right;">
35.67
</td>
<td style="text-align:right;">
51.43
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
The Valley
</td>
<td style="text-align:right;">
Anguilla
</td>
<td style="text-align:right;">
1435
</td>
<td style="text-align:right;">
18.22
</td>
<td style="text-align:right;">
-63.05
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Thimphu
</td>
<td style="text-align:right;">
Bhutan
</td>
<td style="text-align:right;">
74175
</td>
<td style="text-align:right;">
27.48
</td>
<td style="text-align:right;">
89.70
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tirana
</td>
<td style="text-align:right;">
Albania
</td>
<td style="text-align:right;">
380403
</td>
<td style="text-align:right;">
41.33
</td>
<td style="text-align:right;">
19.82
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tokyo
</td>
<td style="text-align:right;">
Japan
</td>
<td style="text-align:right;">
8372440
</td>
<td style="text-align:right;">
35.67
</td>
<td style="text-align:right;">
139.77
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Torshavn
</td>
<td style="text-align:right;">
Faroe Islands
</td>
<td style="text-align:right;">
13313
</td>
<td style="text-align:right;">
62.03
</td>
<td style="text-align:right;">
-6.80
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tripoli
</td>
<td style="text-align:right;">
Libya
</td>
<td style="text-align:right;">
1164634
</td>
<td style="text-align:right;">
32.87
</td>
<td style="text-align:right;">
13.18
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Tunis
</td>
<td style="text-align:right;">
Tunisia
</td>
<td style="text-align:right;">
693294
</td>
<td style="text-align:right;">
36.84
</td>
<td style="text-align:right;">
10.22
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Ulaanbaatar
</td>
<td style="text-align:right;">
Mongolia
</td>
<td style="text-align:right;">
862842
</td>
<td style="text-align:right;">
47.93
</td>
<td style="text-align:right;">
106.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vaduz
</td>
<td style="text-align:right;">
Liechtenstein
</td>
<td style="text-align:right;">
5248
</td>
<td style="text-align:right;">
47.14
</td>
<td style="text-align:right;">
9.53
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vaiaku
</td>
<td style="text-align:right;">
Tuvalu
</td>
<td style="text-align:right;">
4835
</td>
<td style="text-align:right;">
-8.52
</td>
<td style="text-align:right;">
179.20
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Valletta
</td>
<td style="text-align:right;">
Malta
</td>
<td style="text-align:right;">
6748
</td>
<td style="text-align:right;">
35.91
</td>
<td style="text-align:right;">
14.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vatican City
</td>
<td style="text-align:right;">
Holy See (Vatican City State)
</td>
<td style="text-align:right;">
767
</td>
<td style="text-align:right;">
41.90
</td>
<td style="text-align:right;">
12.46
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Victoria
</td>
<td style="text-align:right;">
Seychelles
</td>
<td style="text-align:right;">
22611
</td>
<td style="text-align:right;">
-4.62
</td>
<td style="text-align:right;">
55.45
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vienna
</td>
<td style="text-align:right;">
Austria
</td>
<td style="text-align:right;">
1570976
</td>
<td style="text-align:right;">
48.22
</td>
<td style="text-align:right;">
16.37
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vientiane
</td>
<td style="text-align:right;">
Lao People's Democratic Republic
</td>
<td style="text-align:right;">
199863
</td>
<td style="text-align:right;">
17.97
</td>
<td style="text-align:right;">
102.61
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vila
</td>
<td style="text-align:right;">
Vanuatu
</td>
<td style="text-align:right;">
37141
</td>
<td style="text-align:right;">
-17.74
</td>
<td style="text-align:right;">
168.31
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Vilnius
</td>
<td style="text-align:right;">
Lithuania
</td>
<td style="text-align:right;">
542014
</td>
<td style="text-align:right;">
54.70
</td>
<td style="text-align:right;">
25.27
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Warsaw
</td>
<td style="text-align:right;">
Poland
</td>
<td style="text-align:right;">
1634441
</td>
<td style="text-align:right;">
52.26
</td>
<td style="text-align:right;">
21.02
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Washington
</td>
<td style="text-align:right;">
United States
</td>
<td style="text-align:right;">
548359
</td>
<td style="text-align:right;">
38.91
</td>
<td style="text-align:right;">
-77.02
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Wellington
</td>
<td style="text-align:right;">
New Zealand
</td>
<td style="text-align:right;">
182254
</td>
<td style="text-align:right;">
-41.28
</td>
<td style="text-align:right;">
174.78
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Willemstad
</td>
<td style="text-align:right;">
Bonaire, Sint Eustatius and Saba
</td>
<td style="text-align:right;">
98339
</td>
<td style="text-align:right;">
12.10
</td>
<td style="text-align:right;">
-68.93
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Windhoek
</td>
<td style="text-align:right;">
Namibia
</td>
<td style="text-align:right;">
277349
</td>
<td style="text-align:right;">
-22.56
</td>
<td style="text-align:right;">
17.09
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Yamoussoukro
</td>
<td style="text-align:right;">
Côte d'Ivoire
</td>
<td style="text-align:right;">
200103
</td>
<td style="text-align:right;">
6.82
</td>
<td style="text-align:right;">
-5.28
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Yaounde
</td>
<td style="text-align:right;">
Cameroon
</td>
<td style="text-align:right;">
1344617
</td>
<td style="text-align:right;">
3.87
</td>
<td style="text-align:right;">
11.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Yaren
</td>
<td style="text-align:right;">
Nauru
</td>
<td style="text-align:right;">
4587
</td>
<td style="text-align:right;">
-0.55
</td>
<td style="text-align:right;">
166.91
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Yerevan
</td>
<td style="text-align:right;">
Armenia
</td>
<td style="text-align:right;">
1090537
</td>
<td style="text-align:right;">
40.17
</td>
<td style="text-align:right;">
44.52
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Zagreb
</td>
<td style="text-align:right;">
Croatia
</td>
<td style="text-align:right;">
700717
</td>
<td style="text-align:right;">
45.80
</td>
<td style="text-align:right;">
15.97
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
al-'Ayun
</td>
<td style="text-align:right;">
Western Sahara
</td>
<td style="text-align:right;">
188084
</td>
<td style="text-align:right;">
27.16
</td>
<td style="text-align:right;">
-13.20
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
al-Kuwayt
</td>
<td style="text-align:right;">
Kuwait
</td>
<td style="text-align:right;">
63596
</td>
<td style="text-align:right;">
29.38
</td>
<td style="text-align:right;">
47.99
</td>
<td style="text-align:right;">
1
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

