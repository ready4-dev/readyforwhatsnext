---
title: "Standardise Variable Values With Lookup Codes"
linkTitle: "Standardise values (2)"
date: "2024-06-08"
description: "This tutorial describes how a module from the costly R package can help you to use lookup codes to standardise variable values and thus facilitate partial automation of costing algorithms."
weight: 92
categories: 
- Documentation
tags: 
- Data - management
- Data - metadata
- Model
- Model - modules
- Model - modules (programs)
- Software
- Software - libraries
- Software - libraries (costly)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: 37a2a59aff99d9c2
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the costly library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/costly/articles/V_02.html)
-   [view the source file](https://github.com/ready4-dev/costly/blob/main/vignettes/V_02.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/costly/edit/main/vignettes/V_02.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4use/'>ready4use</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/costly/'>costly</a></span><span class='o'>)</span></span></code></pre>

</div>

Note. Parts of the workflow described in this article are common to steps explained in more detail in the article outlining the workflow using [fuzzy logic and correspondence tables](V_01.html).

## In brief

The steps described and explained in this vignette can also be (more succinctly) accomplished with the following code.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCountries-class.html'>CostlyCountries</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>,</span>
<span>           new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_default_currency_seed.html'>add_default_currency_seed</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>CostlySeed_r4</span>, include_1L_chr <span class='o'>=</span> <span class='s'>"Country"</span><span class='o'>)</span>, </span>
<span>           what_1L_chr <span class='o'>=</span> <span class='s'>"seed"</span><span class='o'>)</span></span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"jw"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"logic"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/make_country_correspondences.html'>make_country_correspondences</a></span><span class='o'>(</span><span class='s'>"currencies"</span><span class='o'>)</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"correspondences"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span><span class='o'>)</span></span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCurrencies-class.html'>CostlyCurrencies</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>Y</span>, new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_default_currency_seed.html'>add_default_currency_seed</a></span><span class='o'>(</span><span class='nv'>Y</span><span class='o'>@</span><span class='nv'>CostlySeed_r4</span>,</span>
<span>                                                     Ready4useDyad_r4 <span class='o'>=</span> <span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Lookup</span><span class='o'>)</span>, </span>
<span>           what_1L_chr <span class='o'>=</span> <span class='s'>"seed"</span><span class='o'>)</span></span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>Y</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Lookup"</span><span class='o'>)</span></span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>Y</span>, <span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span> </span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>Y</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Lookup"</span><span class='o'>)</span></span></code></pre>

</div>

## Create project

We begin by creating `X`, a `CostlyCorrespondences` module instance.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCorrespondences-class.html'>CostlyCorrespondences</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

## Supply seed dataset

We next create a `CostlySeed` module instance that includes a dataset containing our variable of interest (in this case, countries). The dataset needs to be paired with a dataset dictionary using the `Ready4useDyad` module from the [ready4use R library](https://ready4-dev.github.io/ready4use/). You can supply a custom standards dataset (a tibble), dictionary (a ready4use_dictionary) and the concept represented by our variable of interest using a command of the following format.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># A &lt;- CostlySeed(Ready4useDyad_r4 = Ready4useDyad(ds_tb = tibble::tibble(), dictionary_r3 = ready4use_dictionary()), include_chr = c("Country"), label_1L_chr = "Country")</span></span></code></pre>

</div>

The `add_default_country_seed` function will perform the previous step using values that pair the `world.cities` dataset of the `maps` R library with an appropriate dictionary and specifies countries as the concept we will be standardising.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlySeed-class.html'>CostlySeed</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_default_currency_seed.html'>add_default_currency_seed</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

We now add `A` to a new `CostlyCorrespondences` module instance `Y`, which we use to standardise the country concept variable using a [fuzzy logic And correspondence tables workflow](V_01.html).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>A</span><span class='o'>@</span><span class='nv'>include_chr</span> <span class='o'>&lt;-</span> <span class='nv'>A</span><span class='o'>@</span><span class='nv'>label_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"Country"</span></span>
<span><span class='nv'>Y</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyCountries-class.html'>CostlyCountries</a></span><span class='o'>(</span>CostlySeed_r4 <span class='o'>=</span> <span class='nv'>A</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='s'>"jw"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"logic"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span>new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/make_country_correspondences.html'>make_country_correspondences</a></span><span class='o'>(</span><span class='s'>"currencies"</span><span class='o'>)</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"correspondences"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

We now update `X` with the results `Ready4useDyad` from `Y` (a seed dataset for which country names have been standardised).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlySeed-class.html'>CostlySeed</a></span><span class='o'>(</span>Ready4useDyad_r4 <span class='o'>=</span> <span class='nv'>Y</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Country_Output_Lookup</span><span class='o'>)</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"seed"</span><span class='o'>)</span> <span class='c'># </span></span></code></pre>

</div>

We can now inspect the first few records from our labelled seed dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"CostlySeed_r4@Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"CostlySeed_r4@Ready4useDyad_r4"</span>, display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
Country name
</th>
<th style="text-align:right;">
Currency name
</th>
<th style="text-align:right;">
Currency symbol
</th>
<th style="text-align:right;">
Currency alphabetical ISO code (three letter)
</th>
<th style="text-align:right;">
Currency's fractional unit
</th>
<th style="text-align:right;">
Number of fractional units in basic unit
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Afghanistan
</td>
<td style="text-align:right;">
Afghan afghani
</td>
<td style="text-align:right;">
؋‎
</td>
<td style="text-align:right;">
AFN
</td>
<td style="text-align:right;">
Pul
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Albania
</td>
<td style="text-align:right;">
Albanian lek
</td>
<td style="text-align:right;">
Lek
</td>
<td style="text-align:right;">
ALL
</td>
<td style="text-align:right;">
Qintar
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Algeria
</td>
<td style="text-align:right;">
Algerian dinar
</td>
<td style="text-align:right;">
DA
</td>
<td style="text-align:right;">
DZD
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Andorra
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Angola
</td>
<td style="text-align:right;">
Angolan kwanza
</td>
<td style="text-align:right;">
Kz
</td>
<td style="text-align:right;">
AOA
</td>
<td style="text-align:right;">
Cêntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Anguilla
</td>
<td style="text-align:right;">
Eastern Caribbean dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
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

We can also inspect the seed dataset's dictionary.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='s'>"CostlySeed_r4@Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"dict"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
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
State / Territory\[1\]
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
Currency\[1\]\[2\]
</td>
<td style="text-align:right;">
Currency
</td>
<td style="text-align:right;">
Currency name
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Symbol\[D\] orAbbrev.\[3\]
</td>
<td style="text-align:right;">
Symbol
</td>
<td style="text-align:right;">
Currency symbol
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
ISO code\[2\]
</td>
<td style="text-align:right;">
A3
</td>
<td style="text-align:right;">
Currency alphabetical ISO code (three letter)
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Fractionalunit
</td>
<td style="text-align:right;">
Fractional
</td>
<td style="text-align:right;">
Currency's fractional unit
</td>
<td style="text-align:right;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Numberto basic
</td>
<td style="text-align:right;">
Number
</td>
<td style="text-align:right;">
Number of fractional units in basic unit
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

We specify the seed dataset concept that we are looking to standardise and the concept that we will use to lookup replacement values from the standards dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>CostlySeed_r4</span><span class='o'>@</span><span class='nv'>label_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"Currency"</span></span>
<span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>CostlySeed_r4</span><span class='o'>@</span><span class='nv'>match_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"A3"</span></span></code></pre>

</div>

## Specify standards

We can now create `B`, a `CostlyStandards` module instance that includes a dataset specifying the complete list of allowable variable values. In many cases using the `ISO_4217` dataset from the `ISOcodes` library will be the optimal source of standardised names for currencies. Using the `add_currency_standards` function will pair this dataset with a dictionary.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>B</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/CostlyStandards-class.html'>CostlyStandards</a></span><span class='o'>(</span>Ready4useDyad_r4 <span class='o'>=</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4use/reference/Ready4useDyad-class.html'>Ready4useDyad</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://ready4-dev.github.io/costly/reference/add_currency_standards.html'>add_currency_standards</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

We can inspect the first few cases of the labelled version of the standards dataset in `B`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renewSlot-methods.html'>renewSlot</a></span><span class='o'>(</span><span class='nv'>B</span>, <span class='s'>"Ready4useDyad_r4"</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibitSlot-methods.html'>exhibitSlot</a></span><span class='o'>(</span><span class='s'>"Ready4useDyad_r4"</span>, display_1L_chr <span class='o'>=</span> <span class='s'>"head"</span>, scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
Alpabetical currency code (three letters)
</th>
<th style="text-align:right;">
Numeric currency code
</th>
<th style="text-align:right;">
Currency name
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
AED
</td>
<td style="text-align:right;">
784
</td>
<td style="text-align:right;">
UAE Dirham
</td>
</tr>
<tr>
<td style="text-align:left;">
AFN
</td>
<td style="text-align:right;">
971
</td>
<td style="text-align:right;">
Afghani
</td>
</tr>
<tr>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:right;">
008
</td>
<td style="text-align:right;">
Lek
</td>
</tr>
<tr>
<td style="text-align:left;">
AMD
</td>
<td style="text-align:right;">
051
</td>
<td style="text-align:right;">
Armenian Dram
</td>
</tr>
<tr>
<td style="text-align:left;">
ANG
</td>
<td style="text-align:right;">
532
</td>
<td style="text-align:right;">
Netherlands Antillean Guilder
</td>
</tr>
<tr>
<td style="text-align:left;">
AOA
</td>
<td style="text-align:right;">
973
</td>
<td style="text-align:right;">
Kwanza
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

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
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
<th style="text-align:left;">
Class
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Letter
</td>
<td style="text-align:right;">
A3
</td>
<td style="text-align:right;">
Alpabetical currency code (three letters)
</td>
<td style="text-align:left;">
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
Numeric currency code
</td>
<td style="text-align:left;">
character
</td>
</tr>
<tr>
<td style="text-align:left;">
Currency
</td>
<td style="text-align:right;">
Currency
</td>
<td style="text-align:right;">
Currency name
</td>
<td style="text-align:left;">
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

We can now specifying both the concept ("Currency") that specifies allowable values for our target variable and the concepts we plan to use for lookup matching (described below).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'>#B@include_chr &lt;- c("Currency", "Letter")</span></span>
<span><span class='nv'>B</span><span class='o'>@</span><span class='nv'>label_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"Currency"</span></span>
<span><span class='nv'>B</span><span class='o'>@</span><span class='nv'>match_1L_chr</span> <span class='o'>&lt;-</span> <span class='s'>"A3"</span></span></code></pre>

</div>

We now add `B` to `X`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='nv'>B</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"standards"</span><span class='o'>)</span></span></code></pre>

</div>

## Compare variable of interest values from seed and standards dataset.

Currently, the majority of our currency names need to be standardised. In many cases this may be due to something as simple as the use of lower case.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, new_val_xx <span class='o'>=</span> <span class='s'>"identity"</span><span class='o'>)</span></span>
<span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Currency_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span>
<span><span class='c'>#&gt;   [1] "Afghan afghani"                          "Albanian lek"                            "Algerian dinar"                          "Angolan kwanza"                          "Argentine peso"                         </span></span>
<span><span class='c'>#&gt;   [6] "Armenian dram"                           "Aruban florin"                           "Australian dollar"                       "Azerbaijani manat"                       "Bahamian dollar"                        </span></span>
<span><span class='c'>#&gt;  [11] "Bahraini dinar"                          "Bangladeshi taka"                        "Barbadian dollar"                        "Belarusian ruble"                        "Belize dollar"                          </span></span>
<span><span class='c'>#&gt;  [16] "Bermudian dollar"                        "Bhutanese ngultrum"                      "Bitcoin[4]"                              "Bolivian boliviano"                      "Bosnia and Herzegovina convertible mark"</span></span>
<span><span class='c'>#&gt;  [21] "Botswana pula"                           "Brazilian real"                          "Brunei dollar"                           "Bulgarian lev"                           "Burmese kyat"                           </span></span>
<span><span class='c'>#&gt;  [26] "Burundian franc"                         "Cambodian riel"                          "Canadian dollar"                         "Cape Verdean escudo"                     "Cayman Islands dollar"                  </span></span>
<span><span class='c'>#&gt;  [31] "Central African CFA franc"               "CFP franc"                               "Chilean peso"                            "Colombian peso"                          "Comorian franc"                         </span></span>
<span><span class='c'>#&gt;  [36] "Congolese franc"                         "Cook Islands dollar"                     "Costa Rican colón"                       "Cuban peso"                              "Czech koruna"                           </span></span>
<span><span class='c'>#&gt;  [41] "Danish krone"                            "Djiboutian franc"                        "Dominican peso"                          "Eastern Caribbean dollar"                "Egyptian pound"                         </span></span>
<span><span class='c'>#&gt;  [46] "Eritrean nakfa"                          "Ethiopian birr"                          "Falkland Islands pound"                  "Faroese króna"                           "Fijian dollar"                          </span></span>
<span><span class='c'>#&gt;  [51] "Gambian dalasi"                          "Georgian lari"                           "Ghanaian cedi"                           "Gibraltar pound"                         "Guatemalan quetzal"                     </span></span>
<span><span class='c'>#&gt;  [56] "Guernsey pound"                          "Guinean franc"                           "Guyanese dollar"                         "Haitian gourde"                          "Honduran lempira"                       </span></span>
<span><span class='c'>#&gt;  [61] "Hong Kong dollar"                        "Hungarian forint"                        "Icelandic króna"                         "Indian rupee"                            "Indonesian rupiah"                      </span></span>
<span><span class='c'>#&gt;  [66] "Iranian rial"                            "Iraqi dinar"                             "Israeli new shekel"                      "Jamaican dollar"                         "Japanese yen"                           </span></span>
<span><span class='c'>#&gt;  [71] "Jersey pound"                            "Jordanian dinar"                         "Kazakhstani tenge"                       "Kenyan shilling"                         "Kiribati dollar[E]"                     </span></span>
<span><span class='c'>#&gt;  [76] "Kuwaiti dinar"                           "Kyrgyz som"                              "Lao kip"                                 "Lebanese pound"                          "Lesotho loti"                           </span></span>
<span><span class='c'>#&gt;  [81] "Liberian dollar"                         "Libyan dinar"                            "Macanese pataca"                         "Macedonian denar"                        "Malagasy ariary"                        </span></span>
<span><span class='c'>#&gt;  [86] "Malawian kwacha"                         "Malaysian ringgit"                       "Maldivian rufiyaa"                       "Manx pound"                              "Mauritanian ouguiya"                    </span></span>
<span><span class='c'>#&gt;  [91] "Mauritian rupee"                         "Mexican peso"                            "Moldovan leu"                            "Mongolian tögrög"                        "Moroccan dirham"                        </span></span>
<span><span class='c'>#&gt;  [96] "Mozambican metical"                      "Namibian dollar"                         "Nepalese rupee"                          "Netherlands Antillean guilder"           "New Taiwan dollar"                      </span></span>
<span><span class='c'>#&gt; [101] "New Zealand dollar"                      "Nicaraguan córdoba"                      "Nigerian naira"                          "Niue dollar[E]"                          "North Korean won"                       </span></span>
<span><span class='c'>#&gt; [106] "Norwegian krone"                         "Omani rial"                              "Pakistani rupee"                         "Panamanian balboa"                       "Papua New Guinean kina"                 </span></span>
<span><span class='c'>#&gt; [111] "Paraguayan guaraní"                      "Peruvian sol"                            "Philippine peso"                         "Pitcairn Islands dollar[E]"              "Polish złoty"                           </span></span>
<span><span class='c'>#&gt; [116] "Qatari riyal"                            "Renminbi"                                "Romanian leu"                            "Russian ruble"                           "Rwandan franc"                          </span></span>
<span><span class='c'>#&gt; [121] "Sahrawi peseta"                          "Saint Helena pound"                      "Samoan tālā"                             "São Tomé and Príncipe dobra"             "Saudi riyal"                            </span></span>
<span><span class='c'>#&gt; [126] "Serbian dinar"                           "Seychellois rupee"                       "Sierra Leonean leone"                    "Singapore dollar"                        "Solomon Islands dollar"                 </span></span>
<span><span class='c'>#&gt; [131] "Somali shilling"                         "South African rand"                      "South Korean won"                        "South Sudanese pound"                    "Sri Lankan rupee"                       </span></span>
<span><span class='c'>#&gt; [136] "Sterling"                                "Sudanese pound"                          "Surinamese dollar"                       "Swazi lilangeni"                         "Swedish krona"                          </span></span>
<span><span class='c'>#&gt; [141] "Swiss franc"                             "Syrian pound"                            "Tajikistani somoni"                      "Tanzanian shilling"                      "Thai baht"                              </span></span>
<span><span class='c'>#&gt; [146] "Tongan paʻanga[K]"                       "Trinidad and Tobago dollar"              "Tunisian dinar"                          "Turkish lira"                            "Turkmenistani manat"                    </span></span>
<span><span class='c'>#&gt; [151] "Tuvaluan dollar"                         "Ugandan shilling"                        "Ukrainian hryvnia"                       "United Arab Emirates dirham"             "United States dollar"                   </span></span>
<span><span class='c'>#&gt; [156] "United States dollar[F]"                 "Uruguayan peso"                          "Uzbekistani sum"                         "Vanuatu vatu"                            "Venezuelan digital bolívar"             </span></span>
<span><span class='c'>#&gt; [161] "Venezuelan sovereign bolívar"            "Vietnamese đồng"                         "West African CFA franc"                  "Yemeni rial"                             "Zambian kwacha"                         </span></span>
<span><span class='c'>#&gt; [166] "Zimbabwe gold"                           "Zimbabwean dollar"</span></span>
<span></span></code></pre>

</div>

Standardised currency names not currently present in our seed dataset are as follows.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Currency_Output_Validation</span><span class='o'>$</span><span class='nv'>Absent_Values</span></span>
<span><span class='c'>#&gt;   [1] "ADB Unit of Account"                                               "Afghani"                                                           "Algerian Dinar"                                                   </span></span>
<span><span class='c'>#&gt;   [4] "Argentine Peso"                                                    "Armenian Dram"                                                     "Aruban Florin"                                                    </span></span>
<span><span class='c'>#&gt;   [7] "Australian Dollar"                                                 "Azerbaijan Manat"                                                  "Bahamian Dollar"                                                  </span></span>
<span><span class='c'>#&gt;  [10] "Bahraini Dinar"                                                    "Baht"                                                              "Balboa"                                                           </span></span>
<span><span class='c'>#&gt;  [13] "Barbados Dollar"                                                   "Belarusian Ruble"                                                  "Belize Dollar"                                                    </span></span>
<span><span class='c'>#&gt;  [16] "Bermudian Dollar"                                                  "Bolívar Soberano"                                                  "Boliviano"                                                        </span></span>
<span><span class='c'>#&gt;  [19] "Bond Markets Unit European Composite Unit (EURCO)"                 "Bond Markets Unit European Monetary Unit (E.M.U.-6)"               "Bond Markets Unit European Unit of Account 17 (E.U.A.-17)"        </span></span>
<span><span class='c'>#&gt;  [22] "Bond Markets Unit European Unit of Account 9 (E.U.A.-9)"           "Brazilian Real"                                                    "Brunei Dollar"                                                    </span></span>
<span><span class='c'>#&gt;  [25] "Bulgarian Lev"                                                     "Burundi Franc"                                                     "Cabo Verde Escudo"                                                </span></span>
<span><span class='c'>#&gt;  [28] "Canadian Dollar"                                                   "Cayman Islands Dollar"                                             "CFA Franc BCEAO"                                                  </span></span>
<span><span class='c'>#&gt;  [31] "CFA Franc BEAC"                                                    "CFP Franc"                                                         "Chilean Peso"                                                     </span></span>
<span><span class='c'>#&gt;  [34] "Codes specifically reserved for testing purposes"                  "Colombian Peso"                                                    "Comorian Franc"                                                   </span></span>
<span><span class='c'>#&gt;  [37] "Congolese Franc"                                                   "Convertible Mark"                                                  "Cordoba Oro"                                                      </span></span>
<span><span class='c'>#&gt;  [40] "Costa Rican Colon"                                                 "Cuban Peso"                                                        "Czech Koruna"                                                     </span></span>
<span><span class='c'>#&gt;  [43] "Dalasi"                                                            "Danish Krone"                                                      "Denar"                                                            </span></span>
<span><span class='c'>#&gt;  [46] "Djibouti Franc"                                                    "Dobra"                                                             "Dominican Peso"                                                   </span></span>
<span><span class='c'>#&gt;  [49] "Dong"                                                              "East Caribbean Dollar"                                             "Egyptian Pound"                                                   </span></span>
<span><span class='c'>#&gt;  [52] "El Salvador Colon"                                                 "Ethiopian Birr"                                                    "Falkland Islands Pound"                                           </span></span>
<span><span class='c'>#&gt;  [55] "Fiji Dollar"                                                       "Forint"                                                            "Ghana Cedi"                                                       </span></span>
<span><span class='c'>#&gt;  [58] "Gibraltar Pound"                                                   "Gold"                                                              "Gourde"                                                           </span></span>
<span><span class='c'>#&gt;  [61] "Guarani"                                                           "Guinean Franc"                                                     "Guyana Dollar"                                                    </span></span>
<span><span class='c'>#&gt;  [64] "Hong Kong Dollar"                                                  "Hryvnia"                                                           "Iceland Krona"                                                    </span></span>
<span><span class='c'>#&gt;  [67] "Indian Rupee"                                                      "Iranian Rial"                                                      "Iraqi Dinar"                                                      </span></span>
<span><span class='c'>#&gt;  [70] "Jamaican Dollar"                                                   "Jordanian Dinar"                                                   "Kenyan Shilling"                                                  </span></span>
<span><span class='c'>#&gt;  [73] "Kina"                                                              "Kuna"                                                              "Kuwaiti Dinar"                                                    </span></span>
<span><span class='c'>#&gt;  [76] "Kwanza"                                                            "Kyat"                                                              "Lao Kip"                                                          </span></span>
<span><span class='c'>#&gt;  [79] "Lari"                                                              "Lebanese Pound"                                                    "Lek"                                                              </span></span>
<span><span class='c'>#&gt;  [82] "Lempira"                                                           "Leone"                                                             "Liberian Dollar"                                                  </span></span>
<span><span class='c'>#&gt;  [85] "Libyan Dinar"                                                      "Lilangeni"                                                         "Loti"                                                             </span></span>
<span><span class='c'>#&gt;  [88] "Malagasy Ariary"                                                   "Malawi Kwacha"                                                     "Malaysian Ringgit"                                                </span></span>
<span><span class='c'>#&gt;  [91] "Mauritius Rupee"                                                   "Mexican Peso"                                                      "Mexican Unidad de Inversion (UDI)"                                </span></span>
<span><span class='c'>#&gt;  [94] "Moldovan Leu"                                                      "Moroccan Dirham"                                                   "Mozambique Metical"                                               </span></span>
<span><span class='c'>#&gt;  [97] "Mvdol"                                                             "Naira"                                                             "Nakfa"                                                            </span></span>
<span><span class='c'>#&gt; [100] "Namibia Dollar"                                                    "Nepalese Rupee"                                                    "Netherlands Antillean Guilder"                                    </span></span>
<span><span class='c'>#&gt; [103] "New Israeli Sheqel"                                                "New Taiwan Dollar"                                                 "New Zealand Dollar"                                               </span></span>
<span><span class='c'>#&gt; [106] "Ngultrum"                                                          "North Korean Won"                                                  "Norwegian Krone"                                                  </span></span>
<span><span class='c'>#&gt; [109] "Ouguiya"                                                           "Pa’anga"                                                           "Pakistan Rupee"                                                   </span></span>
<span><span class='c'>#&gt; [112] "Palladium"                                                         "Pataca"                                                            "Peso Convertible"                                                 </span></span>
<span><span class='c'>#&gt; [115] "Peso Uruguayo"                                                     "Philippine Peso"                                                   "Platinum"                                                         </span></span>
<span><span class='c'>#&gt; [118] "Pound Sterling"                                                    "Pula"                                                              "Qatari Rial"                                                      </span></span>
<span><span class='c'>#&gt; [121] "Quetzal"                                                           "Rand"                                                              "Rial Omani"                                                       </span></span>
<span><span class='c'>#&gt; [124] "Riel"                                                              "Romanian Leu"                                                      "Rufiyaa"                                                          </span></span>
<span><span class='c'>#&gt; [127] "Rupiah"                                                            "Russian Ruble"                                                     "Rwanda Franc"                                                     </span></span>
<span><span class='c'>#&gt; [130] "Saint Helena Pound"                                                "Saudi Riyal"                                                       "SDR (Special Drawing Right)"                                      </span></span>
<span><span class='c'>#&gt; [133] "Serbian Dinar"                                                     "Seychelles Rupee"                                                  "Silver"                                                           </span></span>
<span><span class='c'>#&gt; [136] "Singapore Dollar"                                                  "Sol"                                                               "Solomon Islands Dollar"                                           </span></span>
<span><span class='c'>#&gt; [139] "Som"                                                               "Somali Shilling"                                                   "Somoni"                                                           </span></span>
<span><span class='c'>#&gt; [142] "South Sudanese Pound"                                              "Sri Lanka Rupee"                                                   "Sucre"                                                            </span></span>
<span><span class='c'>#&gt; [145] "Sudanese Pound"                                                    "Surinam Dollar"                                                    "Swedish Krona"                                                    </span></span>
<span><span class='c'>#&gt; [148] "Swiss Franc"                                                       "Syrian Pound"                                                      "Taka"                                                             </span></span>
<span><span class='c'>#&gt; [151] "Tala"                                                              "Tanzanian Shilling"                                                "Tenge"                                                            </span></span>
<span><span class='c'>#&gt; [154] "The codes assigned for transactions where no currency is involved" "Trinidad and Tobago Dollar"                                        "Tugrik"                                                           </span></span>
<span><span class='c'>#&gt; [157] "Tunisian Dinar"                                                    "Turkish Lira"                                                      "Turkmenistan New Manat"                                           </span></span>
<span><span class='c'>#&gt; [160] "UAE Dirham"                                                        "Uganda Shilling"                                                   "Unidad de Fomento"                                                </span></span>
<span><span class='c'>#&gt; [163] "Unidad de Valor Real"                                              "Unidad Previsional"                                                "Uruguay Peso en Unidades Indexadas (UI)"                          </span></span>
<span><span class='c'>#&gt; [166] "US Dollar"                                                         "US Dollar (Next day)"                                              "Uzbekistan Sum"                                                   </span></span>
<span><span class='c'>#&gt; [169] "Vatu"                                                              "WIR Euro"                                                          "WIR Franc"                                                        </span></span>
<span><span class='c'>#&gt; [172] "Won"                                                               "Yemeni Rial"                                                       "Yen"                                                              </span></span>
<span><span class='c'>#&gt; [175] "Yuan Renminbi"                                                     "Zambian Kwacha"                                                    "Zimbabwe Dollar"                                                  </span></span>
<span><span class='c'>#&gt; [178] "Zloty"</span></span>
<span></span></code></pre>

</div>

## Standardise variable values

We standardise the target variable values, specifying that we are using the lookup codes method and not the fuzzy-logic / correspondences method.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Lookup"</span><span class='o'>)</span></span></code></pre>

</div>

This significantly reduces the umber of non-standard values for our target variable.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Currency_Output_Validation</span><span class='o'>$</span><span class='nv'>Invalid_Values</span></span>
<span><span class='c'>#&gt;  [1] "Bitcoin[4]"                 "Cook Islands dollar"        "Faroese króna"              "Guernsey pound"             "Jersey pound"               "Kiribati dollar[E]"         "Manx pound"                 "Niue dollar[E]"            </span></span>
<span><span class='c'>#&gt;  [9] "Pitcairn Islands dollar[E]" "Sahrawi peseta"             "Tuvaluan dollar"            "Zimbabwe gold"              "Zimbabwean dollar"</span></span>
<span></span></code></pre>

</div>

<div class="highlight">

</div>

If we wish we can remove the non-standardised values.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span><span class='nv'>X</span>, <span class='kc'>T</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"slot"</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"force"</span><span class='o'>)</span> </span>
<span><span class='nv'>X</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/ratify-methods.html'>ratify</a></span><span class='o'>(</span><span class='nv'>X</span>, type_1L_chr <span class='o'>=</span> <span class='s'>"Lookup"</span><span class='o'>)</span></span></code></pre>

</div>

We can no inspect our results a dataset for which the country names and currency names now conform to ISO standards.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>X</span><span class='o'>@</span><span class='nv'>results_ls</span><span class='o'>$</span><span class='nv'>Currency_Output_Lookup</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/renew-methods.html'>renew</a></span><span class='o'>(</span>type_1L_chr <span class='o'>=</span> <span class='s'>"label"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/exhibit-methods.html'>exhibit</a></span><span class='o'>(</span>scroll_box_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class=" lightable-paper lightable-hover lightable-paper" style="color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; color: black; font-family: &quot;Arial Narrow&quot;, arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;">
<caption>
Dataset
</caption>
<thead>
<tr>
<th style="text-align:left;">
Country name
</th>
<th style="text-align:right;">
Currency name
</th>
<th style="text-align:right;">
Currency symbol
</th>
<th style="text-align:right;">
Currency alphabetical ISO code (three letter)
</th>
<th style="text-align:right;">
Currency's fractional unit
</th>
<th style="text-align:right;">
Number of fractional units in basic unit
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Afghanistan
</td>
<td style="text-align:right;">
Afghani
</td>
<td style="text-align:right;">
؋‎
</td>
<td style="text-align:right;">
AFN
</td>
<td style="text-align:right;">
Pul
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Albania
</td>
<td style="text-align:right;">
Lek
</td>
<td style="text-align:right;">
Lek
</td>
<td style="text-align:right;">
ALL
</td>
<td style="text-align:right;">
Qintar
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Algeria
</td>
<td style="text-align:right;">
Algerian Dinar
</td>
<td style="text-align:right;">
DA
</td>
<td style="text-align:right;">
DZD
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Andorra
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Angola
</td>
<td style="text-align:right;">
Kwanza
</td>
<td style="text-align:right;">
Kz
</td>
<td style="text-align:right;">
AOA
</td>
<td style="text-align:right;">
Cêntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Anguilla
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Antigua and Barbuda
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Argentina
</td>
<td style="text-align:right;">
Argentine Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
ARS
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Armenia
</td>
<td style="text-align:right;">
Armenian Dram
</td>
<td style="text-align:right;">
֏
</td>
<td style="text-align:right;">
AMD
</td>
<td style="text-align:right;">
Luma
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Aruba
</td>
<td style="text-align:right;">
Aruban Florin
</td>
<td style="text-align:right;">
ƒ
</td>
<td style="text-align:right;">
AWG
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Helena, Ascension and Tristan da Cunha
</td>
<td style="text-align:right;">
Saint Helena Pound
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
SHP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Australia
</td>
<td style="text-align:right;">
Australian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
AUD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Austria
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Azerbaijan
</td>
<td style="text-align:right;">
Azerbaijan Manat
</td>
<td style="text-align:right;">
₼
</td>
<td style="text-align:right;">
AZN
</td>
<td style="text-align:right;">
Qəpik
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bahamas
</td>
<td style="text-align:right;">
Bahamian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BSD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bahrain
</td>
<td style="text-align:right;">
Bahraini Dinar
</td>
<td style="text-align:right;">
BD
</td>
<td style="text-align:right;">
BHD
</td>
<td style="text-align:right;">
Fils
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Bangladesh
</td>
<td style="text-align:right;">
Taka
</td>
<td style="text-align:right;">
৳
</td>
<td style="text-align:right;">
BDT
</td>
<td style="text-align:right;">
Poisha
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Barbados
</td>
<td style="text-align:right;">
Barbados Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BBD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Belarus
</td>
<td style="text-align:right;">
Belarusian Ruble
</td>
<td style="text-align:right;">
Br
</td>
<td style="text-align:right;">
BYN
</td>
<td style="text-align:right;">
Kopeck
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Belgium
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Belize
</td>
<td style="text-align:right;">
Belize Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BZD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Benin
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bermuda
</td>
<td style="text-align:right;">
Bermudian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BMD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bhutan
</td>
<td style="text-align:right;">
Ngultrum
</td>
<td style="text-align:right;">
Nu
</td>
<td style="text-align:right;">
BTN
</td>
<td style="text-align:right;">
Chetrum
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bhutan
</td>
<td style="text-align:right;">
Indian Rupee
</td>
<td style="text-align:right;">
₹
</td>
<td style="text-align:right;">
INR
</td>
<td style="text-align:right;">
Paisa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bolivia, Plurinational State of
</td>
<td style="text-align:right;">
Boliviano
</td>
<td style="text-align:right;">
Bs
</td>
<td style="text-align:right;">
BOB
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bonaire, Sint Eustatius and Saba
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bosnia and Herzegovina
</td>
<td style="text-align:right;">
Convertible Mark
</td>
<td style="text-align:right;">
KM
</td>
<td style="text-align:right;">
BAM
</td>
<td style="text-align:right;">
Fening
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Botswana
</td>
<td style="text-align:right;">
Pula
</td>
<td style="text-align:right;">
P
</td>
<td style="text-align:right;">
BWP
</td>
<td style="text-align:right;">
Thebe
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Brazil
</td>
<td style="text-align:right;">
Brazilian Real
</td>
<td style="text-align:right;">
R\$
</td>
<td style="text-align:right;">
BRL
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
British Indian Ocean Territory
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Virgin Islands, British
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Brunei Darussalam
</td>
<td style="text-align:right;">
Brunei Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BND
</td>
<td style="text-align:right;">
Sen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Brunei Darussalam
</td>
<td style="text-align:right;">
Singapore Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
SGD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bulgaria
</td>
<td style="text-align:right;">
Bulgarian Lev
</td>
<td style="text-align:right;">
Lev
</td>
<td style="text-align:right;">
BGN
</td>
<td style="text-align:right;">
Stotinka
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Burkina Faso
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Burundi
</td>
<td style="text-align:right;">
Burundi Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
BIF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cambodia
</td>
<td style="text-align:right;">
Riel
</td>
<td style="text-align:right;">
៛
</td>
<td style="text-align:right;">
KHR
</td>
<td style="text-align:right;">
Sen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cambodia
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cameroon
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Canada
</td>
<td style="text-align:right;">
Canadian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
CAD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cabo Verde
</td>
<td style="text-align:right;">
Cabo Verde Escudo
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
CVE
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cayman Islands
</td>
<td style="text-align:right;">
Cayman Islands Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
KYD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Central African Republic
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Chad
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Chile
</td>
<td style="text-align:right;">
Chilean Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
CLP
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
China
</td>
<td style="text-align:right;">
Yuan Renminbi
</td>
<td style="text-align:right;">
¥
</td>
<td style="text-align:right;">
CNY
</td>
<td style="text-align:right;">
Jiao\[G\]
</td>
<td style="text-align:right;">
10
</td>
</tr>
<tr>
<td style="text-align:left;">
Colombia
</td>
<td style="text-align:right;">
Colombian Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
COP
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Comoros
</td>
<td style="text-align:right;">
Comorian Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
KMF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Congo, The Democratic Republic of the
</td>
<td style="text-align:right;">
Congolese Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
CDF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Congo
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cook Islands
</td>
<td style="text-align:right;">
New Zealand Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
NZD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Costa Rica
</td>
<td style="text-align:right;">
Costa Rican Colon
</td>
<td style="text-align:right;">
₡
</td>
<td style="text-align:right;">
CRC
</td>
<td style="text-align:right;">
Céntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Côte d'Ivoire
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Croatia
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cuba
</td>
<td style="text-align:right;">
Cuban Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
CUP
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Curaçao
</td>
<td style="text-align:right;">
Netherlands Antillean Guilder
</td>
<td style="text-align:right;">
ƒ
</td>
<td style="text-align:right;">
ANG
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Cyprus
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Czechia
</td>
<td style="text-align:right;">
Czech Koruna
</td>
<td style="text-align:right;">
Kč
</td>
<td style="text-align:right;">
CZK
</td>
<td style="text-align:right;">
Heller
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Denmark
</td>
<td style="text-align:right;">
Danish Krone
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
DKK
</td>
<td style="text-align:right;">
Øre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Djibouti
</td>
<td style="text-align:right;">
Djibouti Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
DJF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Dominica
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Dominican Republic
</td>
<td style="text-align:right;">
Dominican Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
DOP
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Timor-Leste
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Ecuador
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Egypt
</td>
<td style="text-align:right;">
Egyptian Pound
</td>
<td style="text-align:right;">
LE
</td>
<td style="text-align:right;">
EGP
</td>
<td style="text-align:right;">
Piastre\[B\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
El Salvador
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Equatorial Guinea
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Eritrea
</td>
<td style="text-align:right;">
Nakfa
</td>
<td style="text-align:right;">
Nkf
</td>
<td style="text-align:right;">
ERN
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Estonia
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Eswatini
</td>
<td style="text-align:right;">
Lilangeni
</td>
<td style="text-align:right;">
L or E (pl.)
</td>
<td style="text-align:right;">
SZL
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Eswatini
</td>
<td style="text-align:right;">
Rand
</td>
<td style="text-align:right;">
R
</td>
<td style="text-align:right;">
ZAR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Ethiopia
</td>
<td style="text-align:right;">
Ethiopian Birr
</td>
<td style="text-align:right;">
Br
</td>
<td style="text-align:right;">
ETB
</td>
<td style="text-align:right;">
Santim
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Falkland Islands (Malvinas)
</td>
<td style="text-align:right;">
Falkland Islands Pound
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
FKP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Falkland Islands (Malvinas)
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Faroe Islands
</td>
<td style="text-align:right;">
Danish Krone
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
DKK
</td>
<td style="text-align:right;">
Øre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Fiji
</td>
<td style="text-align:right;">
Fiji Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
FJD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Finland
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
France
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
French Polynesia
</td>
<td style="text-align:right;">
CFP Franc
</td>
<td style="text-align:right;">
₣
</td>
<td style="text-align:right;">
XPF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
French Southern Territories
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Gabon
</td>
<td style="text-align:right;">
CFA Franc BEAC
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XAF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Gambia
</td>
<td style="text-align:right;">
Dalasi
</td>
<td style="text-align:right;">
D
</td>
<td style="text-align:right;">
GMD
</td>
<td style="text-align:right;">
Butut
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Georgia
</td>
<td style="text-align:right;">
Lari
</td>
<td style="text-align:right;">
₾
</td>
<td style="text-align:right;">
GEL
</td>
<td style="text-align:right;">
Tetri
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Germany
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Ghana
</td>
<td style="text-align:right;">
Ghana Cedi
</td>
<td style="text-align:right;">
₵
</td>
<td style="text-align:right;">
GHS
</td>
<td style="text-align:right;">
Pesewa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Gibraltar
</td>
<td style="text-align:right;">
Gibraltar Pound
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GIP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Gibraltar
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Greece
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Greenland
</td>
<td style="text-align:right;">
Danish Krone
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
DKK
</td>
<td style="text-align:right;">
Øre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Grenada
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Guatemala
</td>
<td style="text-align:right;">
Quetzal
</td>
<td style="text-align:right;">
Q
</td>
<td style="text-align:right;">
GTQ
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Guernsey
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Guinea
</td>
<td style="text-align:right;">
Guinean Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
GNF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Guinea-Bissau
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Guyana
</td>
<td style="text-align:right;">
Guyana Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
GYD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Haiti
</td>
<td style="text-align:right;">
Gourde
</td>
<td style="text-align:right;">
G
</td>
<td style="text-align:right;">
HTG
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Honduras
</td>
<td style="text-align:right;">
Lempira
</td>
<td style="text-align:right;">
L
</td>
<td style="text-align:right;">
HNL
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Hong Kong
</td>
<td style="text-align:right;">
Hong Kong Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
HKD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Hungary
</td>
<td style="text-align:right;">
Forint
</td>
<td style="text-align:right;">
Ft
</td>
<td style="text-align:right;">
HUF
</td>
<td style="text-align:right;">
Fillér
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Iceland
</td>
<td style="text-align:right;">
Iceland Krona
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
ISK
</td>
<td style="text-align:right;">
Eyrir
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
India
</td>
<td style="text-align:right;">
Indian Rupee
</td>
<td style="text-align:right;">
₹
</td>
<td style="text-align:right;">
INR
</td>
<td style="text-align:right;">
Paisa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Indonesia
</td>
<td style="text-align:right;">
Rupiah
</td>
<td style="text-align:right;">
Rp
</td>
<td style="text-align:right;">
IDR
</td>
<td style="text-align:right;">
Sen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Iran, Islamic Republic of
</td>
<td style="text-align:right;">
Iranian Rial
</td>
<td style="text-align:right;">
Rl or Rls (pl.)
</td>
<td style="text-align:right;">
IRR
</td>
<td style="text-align:right;">
Rial
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Iraq
</td>
<td style="text-align:right;">
Iraqi Dinar
</td>
<td style="text-align:right;">
ID
</td>
<td style="text-align:right;">
IQD
</td>
<td style="text-align:right;">
Fils
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Ireland
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Isle of Man
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Israel
</td>
<td style="text-align:right;">
New Israeli Sheqel
</td>
<td style="text-align:right;">
₪
</td>
<td style="text-align:right;">
ILS
</td>
<td style="text-align:right;">
Agora
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Italy
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Jamaica
</td>
<td style="text-align:right;">
Jamaican Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
JMD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Japan
</td>
<td style="text-align:right;">
Yen
</td>
<td style="text-align:right;">
¥
</td>
<td style="text-align:right;">
JPY
</td>
<td style="text-align:right;">
Sen\[C\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Jersey
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Jordan
</td>
<td style="text-align:right;">
Jordanian Dinar
</td>
<td style="text-align:right;">
JD
</td>
<td style="text-align:right;">
JOD
</td>
<td style="text-align:right;">
Piastre\[H\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Kazakhstan
</td>
<td style="text-align:right;">
Tenge
</td>
<td style="text-align:right;">
₸
</td>
<td style="text-align:right;">
KZT
</td>
<td style="text-align:right;">
Tıyn
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Kenya
</td>
<td style="text-align:right;">
Kenyan Shilling
</td>
<td style="text-align:right;">
Sh or Shs (pl.)
</td>
<td style="text-align:right;">
KES
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Kiribati
</td>
<td style="text-align:right;">
Australian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
AUD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Korea, Democratic People's Republic of
</td>
<td style="text-align:right;">
North Korean Won
</td>
<td style="text-align:right;">
₩
</td>
<td style="text-align:right;">
KPW
</td>
<td style="text-align:right;">
Chon
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Korea, Republic of
</td>
<td style="text-align:right;">
Won
</td>
<td style="text-align:right;">
₩
</td>
<td style="text-align:right;">
KRW
</td>
<td style="text-align:right;">
Jeon
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Kuwait
</td>
<td style="text-align:right;">
Kuwaiti Dinar
</td>
<td style="text-align:right;">
KD
</td>
<td style="text-align:right;">
KWD
</td>
<td style="text-align:right;">
Fils
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Kyrgyzstan
</td>
<td style="text-align:right;">
Som
</td>
<td style="text-align:right;">
som
</td>
<td style="text-align:right;">
KGS
</td>
<td style="text-align:right;">
Tyiyn
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Lao People's Democratic Republic
</td>
<td style="text-align:right;">
Lao Kip
</td>
<td style="text-align:right;">
₭
</td>
<td style="text-align:right;">
LAK
</td>
<td style="text-align:right;">
Att
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Latvia
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Lebanon
</td>
<td style="text-align:right;">
Lebanese Pound
</td>
<td style="text-align:right;">
LL
</td>
<td style="text-align:right;">
LBP
</td>
<td style="text-align:right;">
Piastre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Lesotho
</td>
<td style="text-align:right;">
Loti
</td>
<td style="text-align:right;">
L or M (pl.)
</td>
<td style="text-align:right;">
LSL
</td>
<td style="text-align:right;">
Sente
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Lesotho
</td>
<td style="text-align:right;">
Rand
</td>
<td style="text-align:right;">
R
</td>
<td style="text-align:right;">
ZAR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
South Georgia and the South Sandwich Islands
</td>
<td style="text-align:right;">
Falkland Islands Pound
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
FKP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
South Georgia and the South Sandwich Islands
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Liberia
</td>
<td style="text-align:right;">
Liberian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
LRD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Liberia
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Libya
</td>
<td style="text-align:right;">
Libyan Dinar
</td>
<td style="text-align:right;">
LD
</td>
<td style="text-align:right;">
LYD
</td>
<td style="text-align:right;">
Dirham
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Liechtenstein
</td>
<td style="text-align:right;">
Swiss Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
CHF
</td>
<td style="text-align:right;">
Rappen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Lithuania
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Luxembourg
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Macao
</td>
<td style="text-align:right;">
Pataca
</td>
<td style="text-align:right;">
MOP\$
</td>
<td style="text-align:right;">
MOP
</td>
<td style="text-align:right;">
Avo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Macao
</td>
<td style="text-align:right;">
Hong Kong Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
HKD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Madagascar
</td>
<td style="text-align:right;">
Malagasy Ariary
</td>
<td style="text-align:right;">
Ar
</td>
<td style="text-align:right;">
MGA
</td>
<td style="text-align:right;">
Iraimbilanja
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
Malawi
</td>
<td style="text-align:right;">
Malawi Kwacha
</td>
<td style="text-align:right;">
K
</td>
<td style="text-align:right;">
MWK
</td>
<td style="text-align:right;">
Tambala
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Malaysia
</td>
<td style="text-align:right;">
Malaysian Ringgit
</td>
<td style="text-align:right;">
RM
</td>
<td style="text-align:right;">
MYR
</td>
<td style="text-align:right;">
Sen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Maldives
</td>
<td style="text-align:right;">
Rufiyaa
</td>
<td style="text-align:right;">
Rf
</td>
<td style="text-align:right;">
MVR
</td>
<td style="text-align:right;">
Laari
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Mali
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Malta
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Marshall Islands
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Mauritania
</td>
<td style="text-align:right;">
Ouguiya
</td>
<td style="text-align:right;">
UM
</td>
<td style="text-align:right;">
MRU
</td>
<td style="text-align:right;">
Khoums
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
Mauritius
</td>
<td style="text-align:right;">
Mauritius Rupee
</td>
<td style="text-align:right;">
Re or Rs (pl.)
</td>
<td style="text-align:right;">
MUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Mexico
</td>
<td style="text-align:right;">
Mexican Peso
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
MXN
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Micronesia, Federated States of
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Moldova, Republic of
</td>
<td style="text-align:right;">
Moldovan Leu
</td>
<td style="text-align:right;">
Leu or Lei (pl.)
</td>
<td style="text-align:right;">
MDL
</td>
<td style="text-align:right;">
Ban
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Monaco
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Mongolia
</td>
<td style="text-align:right;">
Tugrik
</td>
<td style="text-align:right;">
₮
</td>
<td style="text-align:right;">
MNT
</td>
<td style="text-align:right;">
Möngö
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Montenegro
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Montserrat
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Morocco
</td>
<td style="text-align:right;">
Moroccan Dirham
</td>
<td style="text-align:right;">
DH
</td>
<td style="text-align:right;">
MAD
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Mozambique
</td>
<td style="text-align:right;">
Mozambique Metical
</td>
<td style="text-align:right;">
Mt
</td>
<td style="text-align:right;">
MZN
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Myanmar
</td>
<td style="text-align:right;">
Kyat
</td>
<td style="text-align:right;">
K or Ks (pl.)
</td>
<td style="text-align:right;">
MMK
</td>
<td style="text-align:right;">
Pya
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Namibia
</td>
<td style="text-align:right;">
Namibia Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
NAD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Namibia
</td>
<td style="text-align:right;">
Rand
</td>
<td style="text-align:right;">
R
</td>
<td style="text-align:right;">
ZAR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Nauru
</td>
<td style="text-align:right;">
Australian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
AUD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Nepal
</td>
<td style="text-align:right;">
Nepalese Rupee
</td>
<td style="text-align:right;">
Re or Rs (pl.)
</td>
<td style="text-align:right;">
NPR
</td>
<td style="text-align:right;">
Paisa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Nepal
</td>
<td style="text-align:right;">
Indian Rupee
</td>
<td style="text-align:right;">
₹
</td>
<td style="text-align:right;">
INR
</td>
<td style="text-align:right;">
Paisa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Netherlands
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
New Caledonia
</td>
<td style="text-align:right;">
CFP Franc
</td>
<td style="text-align:right;">
₣
</td>
<td style="text-align:right;">
XPF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
New Zealand
</td>
<td style="text-align:right;">
New Zealand Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
NZD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Nicaragua
</td>
<td style="text-align:right;">
Cordoba Oro
</td>
<td style="text-align:right;">
C\$
</td>
<td style="text-align:right;">
NIO
</td>
<td style="text-align:right;">
Centavo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Niger
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Nigeria
</td>
<td style="text-align:right;">
Naira
</td>
<td style="text-align:right;">
₦
</td>
<td style="text-align:right;">
NGN
</td>
<td style="text-align:right;">
Kobo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Niue
</td>
<td style="text-align:right;">
New Zealand Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
NZD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
North Macedonia
</td>
<td style="text-align:right;">
Denar
</td>
<td style="text-align:right;">
DEN
</td>
<td style="text-align:right;">
MKD
</td>
<td style="text-align:right;">
Deni
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Norway
</td>
<td style="text-align:right;">
Norwegian Krone
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
NOK
</td>
<td style="text-align:right;">
Øre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Oman
</td>
<td style="text-align:right;">
Rial Omani
</td>
<td style="text-align:right;">
RO
</td>
<td style="text-align:right;">
OMR
</td>
<td style="text-align:right;">
Baisa
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Pakistan
</td>
<td style="text-align:right;">
Pakistan Rupee
</td>
<td style="text-align:right;">
Re or Rs (pl.)
</td>
<td style="text-align:right;">
PKR
</td>
<td style="text-align:right;">
Paisa
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Palau
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Palestine, State of
</td>
<td style="text-align:right;">
New Israeli Sheqel
</td>
<td style="text-align:right;">
₪
</td>
<td style="text-align:right;">
ILS
</td>
<td style="text-align:right;">
Agora
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Palestine, State of
</td>
<td style="text-align:right;">
Jordanian Dinar
</td>
<td style="text-align:right;">
JD
</td>
<td style="text-align:right;">
JOD
</td>
<td style="text-align:right;">
Piastre\[H\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Panama
</td>
<td style="text-align:right;">
Balboa
</td>
<td style="text-align:right;">
B/
</td>
<td style="text-align:right;">
PAB
</td>
<td style="text-align:right;">
Centésimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Panama
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Papua New Guinea
</td>
<td style="text-align:right;">
Kina
</td>
<td style="text-align:right;">
K
</td>
<td style="text-align:right;">
PGK
</td>
<td style="text-align:right;">
Toea
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Paraguay
</td>
<td style="text-align:right;">
Guarani
</td>
<td style="text-align:right;">
₲
</td>
<td style="text-align:right;">
PYG
</td>
<td style="text-align:right;">
Céntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Peru
</td>
<td style="text-align:right;">
Sol
</td>
<td style="text-align:right;">
S/
</td>
<td style="text-align:right;">
PEN
</td>
<td style="text-align:right;">
Céntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Philippines
</td>
<td style="text-align:right;">
Philippine Peso
</td>
<td style="text-align:right;">
₱
</td>
<td style="text-align:right;">
PHP
</td>
<td style="text-align:right;">
Sentimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Pitcairn
</td>
<td style="text-align:right;">
New Zealand Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
NZD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Poland
</td>
<td style="text-align:right;">
Zloty
</td>
<td style="text-align:right;">
zł
</td>
<td style="text-align:right;">
PLN
</td>
<td style="text-align:right;">
Grosz
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Portugal
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Qatar
</td>
<td style="text-align:right;">
Qatari Rial
</td>
<td style="text-align:right;">
QR
</td>
<td style="text-align:right;">
QAR
</td>
<td style="text-align:right;">
Dirham
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Romania
</td>
<td style="text-align:right;">
Romanian Leu
</td>
<td style="text-align:right;">
Leu or Lei (pl.)
</td>
<td style="text-align:right;">
RON
</td>
<td style="text-align:right;">
Ban
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Russian Federation
</td>
<td style="text-align:right;">
Russian Ruble
</td>
<td style="text-align:right;">
₽
</td>
<td style="text-align:right;">
RUB
</td>
<td style="text-align:right;">
Kopeck
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Rwanda
</td>
<td style="text-align:right;">
Rwanda Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
RWF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bonaire, Sint Eustatius and Saba
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Western Sahara
</td>
<td style="text-align:right;">
Moroccan Dirham
</td>
<td style="text-align:right;">
DH
</td>
<td style="text-align:right;">
MAD
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Helena, Ascension and Tristan da Cunha
</td>
<td style="text-align:right;">
Saint Helena Pound
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
SHP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Helena, Ascension and Tristan da Cunha
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Kitts and Nevis
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Lucia
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Pierre and Miquelon
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Pierre and Miquelon
</td>
<td style="text-align:right;">
Canadian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
CAD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Vincent and the Grenadines
</td>
<td style="text-align:right;">
East Caribbean Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
XCD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Samoa
</td>
<td style="text-align:right;">
Tala
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
WST
</td>
<td style="text-align:right;">
Sene
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saint Barthélemy
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
San Marino
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sao Tome and Principe
</td>
<td style="text-align:right;">
Dobra
</td>
<td style="text-align:right;">
Db
</td>
<td style="text-align:right;">
STN
</td>
<td style="text-align:right;">
Cêntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Saudi Arabia
</td>
<td style="text-align:right;">
Saudi Riyal
</td>
<td style="text-align:right;">
Rl or Rls (pl.)
</td>
<td style="text-align:right;">
SAR
</td>
<td style="text-align:right;">
Halala
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Senegal
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Serbia
</td>
<td style="text-align:right;">
Serbian Dinar
</td>
<td style="text-align:right;">
DIN
</td>
<td style="text-align:right;">
RSD
</td>
<td style="text-align:right;">
Para
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Seychelles
</td>
<td style="text-align:right;">
Seychelles Rupee
</td>
<td style="text-align:right;">
Re or Rs (pl.)
</td>
<td style="text-align:right;">
SCR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sierra Leone
</td>
<td style="text-align:right;">
Leone
</td>
<td style="text-align:right;">
Le
</td>
<td style="text-align:right;">
SLE
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Singapore
</td>
<td style="text-align:right;">
Singapore Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
SGD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Singapore
</td>
<td style="text-align:right;">
Brunei Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
BND
</td>
<td style="text-align:right;">
Sen
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Bonaire, Sint Eustatius and Saba
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sint Maarten (Dutch part)
</td>
<td style="text-align:right;">
Netherlands Antillean Guilder
</td>
<td style="text-align:right;">
ƒ
</td>
<td style="text-align:right;">
ANG
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Slovakia
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Slovenia
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Solomon Islands
</td>
<td style="text-align:right;">
Solomon Islands Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
SBD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Somalia
</td>
<td style="text-align:right;">
Somali Shilling
</td>
<td style="text-align:right;">
Sh or Shs (pl.)
</td>
<td style="text-align:right;">
SOS
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
South Africa
</td>
<td style="text-align:right;">
Rand
</td>
<td style="text-align:right;">
R
</td>
<td style="text-align:right;">
ZAR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
South Sudan
</td>
<td style="text-align:right;">
South Sudanese Pound
</td>
<td style="text-align:right;">
LS
</td>
<td style="text-align:right;">
SSP
</td>
<td style="text-align:right;">
Piaster
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Spain
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sri Lanka
</td>
<td style="text-align:right;">
Sri Lanka Rupee
</td>
<td style="text-align:right;">
Re or Rs (pl.)
</td>
<td style="text-align:right;">
LKR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sudan
</td>
<td style="text-align:right;">
Sudanese Pound
</td>
<td style="text-align:right;">
LS
</td>
<td style="text-align:right;">
SDG
</td>
<td style="text-align:right;">
Piastre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Suriname
</td>
<td style="text-align:right;">
Surinam Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
SRD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Sweden
</td>
<td style="text-align:right;">
Swedish Krona
</td>
<td style="text-align:right;">
kr
</td>
<td style="text-align:right;">
SEK
</td>
<td style="text-align:right;">
Öre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Switzerland
</td>
<td style="text-align:right;">
Swiss Franc
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
CHF
</td>
<td style="text-align:right;">
Rappen\[J\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Syrian Arab Republic
</td>
<td style="text-align:right;">
Syrian Pound
</td>
<td style="text-align:right;">
LS
</td>
<td style="text-align:right;">
SYP
</td>
<td style="text-align:right;">
Piastre
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Taiwan, Province of China
</td>
<td style="text-align:right;">
New Taiwan Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
TWD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Tajikistan
</td>
<td style="text-align:right;">
Somoni
</td>
<td style="text-align:right;">
SM
</td>
<td style="text-align:right;">
TJS
</td>
<td style="text-align:right;">
Diram
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Tanzania, United Republic of
</td>
<td style="text-align:right;">
Tanzanian Shilling
</td>
<td style="text-align:right;">
Sh or Shs (pl.)
</td>
<td style="text-align:right;">
TZS
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Thailand
</td>
<td style="text-align:right;">
Baht
</td>
<td style="text-align:right;">
฿
</td>
<td style="text-align:right;">
THB
</td>
<td style="text-align:right;">
Satang
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Togo
</td>
<td style="text-align:right;">
CFA Franc BCEAO
</td>
<td style="text-align:right;">
Fr
</td>
<td style="text-align:right;">
XOF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Tonga
</td>
<td style="text-align:right;">
Pa'anga
</td>
<td style="text-align:right;">
T\$
</td>
<td style="text-align:right;">
TOP
</td>
<td style="text-align:right;">
Seniti
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Trinidad and Tobago
</td>
<td style="text-align:right;">
Trinidad and Tobago Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
TTD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Tunisia
</td>
<td style="text-align:right;">
Tunisian Dinar
</td>
<td style="text-align:right;">
DT
</td>
<td style="text-align:right;">
TND
</td>
<td style="text-align:right;">
Millime
</td>
<td style="text-align:right;">
1000
</td>
</tr>
<tr>
<td style="text-align:left;">
Türkiye
</td>
<td style="text-align:right;">
Turkish Lira
</td>
<td style="text-align:right;">
₺
</td>
<td style="text-align:right;">
TRY
</td>
<td style="text-align:right;">
Kuruş
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Turkmenistan
</td>
<td style="text-align:right;">
Turkmenistan New Manat
</td>
<td style="text-align:right;">
m
</td>
<td style="text-align:right;">
TMT
</td>
<td style="text-align:right;">
Tenge
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Turks and Caicos Islands
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Tuvalu
</td>
<td style="text-align:right;">
Australian Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
AUD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Uganda
</td>
<td style="text-align:right;">
Uganda Shilling
</td>
<td style="text-align:right;">
Sh or Shs (pl.)
</td>
<td style="text-align:right;">
UGX
</td>
<td style="text-align:right;">
(none)
</td>
<td style="text-align:right;">
(none)
</td>
</tr>
<tr>
<td style="text-align:left;">
Ukraine
</td>
<td style="text-align:right;">
Hryvnia
</td>
<td style="text-align:right;">
₴
</td>
<td style="text-align:right;">
UAH
</td>
<td style="text-align:right;">
Kopeck
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
United Arab Emirates
</td>
<td style="text-align:right;">
UAE Dirham
</td>
<td style="text-align:right;">
Dh or Dhs (pl.)
</td>
<td style="text-align:right;">
AED
</td>
<td style="text-align:right;">
Fils
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
United Kingdom
</td>
<td style="text-align:right;">
Pound Sterling
</td>
<td style="text-align:right;">
£
</td>
<td style="text-align:right;">
GBP
</td>
<td style="text-align:right;">
Penny
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
United States
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent\[A\]
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Uruguay
</td>
<td style="text-align:right;">
Peso Uruguayo
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
UYU
</td>
<td style="text-align:right;">
Centésimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Uzbekistan
</td>
<td style="text-align:right;">
Uzbekistan Sum
</td>
<td style="text-align:right;">
soum
</td>
<td style="text-align:right;">
UZS
</td>
<td style="text-align:right;">
Tiyin
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Vanuatu
</td>
<td style="text-align:right;">
Vatu
</td>
<td style="text-align:right;">
VT
</td>
<td style="text-align:right;">
VUV
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Holy See (Vatican City State)
</td>
<td style="text-align:right;">
Euro
</td>
<td style="text-align:right;">
€
</td>
<td style="text-align:right;">
EUR
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Venezuela, Bolivarian Republic of
</td>
<td style="text-align:right;">
Bolívar Soberano
</td>
<td style="text-align:right;">
Bs.S
</td>
<td style="text-align:right;">
VES
</td>
<td style="text-align:right;">
Céntimo
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Venezuela, Bolivarian Republic of
</td>
<td style="text-align:right;">
Bolívar Soberano
</td>
<td style="text-align:right;">
Bs.D
</td>
<td style="text-align:right;">
VED
</td>
<td style="text-align:right;">
Céntimo
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Venezuela, Bolivarian Republic of
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Viet Nam
</td>
<td style="text-align:right;">
Dong
</td>
<td style="text-align:right;">
₫
</td>
<td style="text-align:right;">
VND
</td>
<td style="text-align:right;">
Hào\[L\]
</td>
<td style="text-align:right;">
10
</td>
</tr>
<tr>
<td style="text-align:left;">
Wallis and Futuna
</td>
<td style="text-align:right;">
CFP Franc
</td>
<td style="text-align:right;">
₣
</td>
<td style="text-align:right;">
XPF
</td>
<td style="text-align:right;">
Centime
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Yemen
</td>
<td style="text-align:right;">
Yemeni Rial
</td>
<td style="text-align:right;">
Rl or Rls (pl.)
</td>
<td style="text-align:right;">
YER
</td>
<td style="text-align:right;">
Fils
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Zambia
</td>
<td style="text-align:right;">
Zambian Kwacha
</td>
<td style="text-align:right;">
K
</td>
<td style="text-align:right;">
ZMW
</td>
<td style="text-align:right;">
Ngwee
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
Zimbabwe
</td>
<td style="text-align:right;">
US Dollar
</td>
<td style="text-align:right;">
\$
</td>
<td style="text-align:right;">
USD
</td>
<td style="text-align:right;">
Cent
</td>
<td style="text-align:right;">
100
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

