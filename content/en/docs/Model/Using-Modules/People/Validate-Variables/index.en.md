---
title: "Validate variable total scores"
linkTitle: "Validate data"
date: "2022-12-24"
description: "Vector based classes can be used to help validate variable values. This tutorial describes how to do that with sub-module classes exported as part of the youthvars R package."
weight: 92
categories: 
- Documentation
tags:
- Data - management
- Data - metadata
- Model
- Model - modules
- Model - modules (people)
- Software
- Software - libraries
- Software - libraries (youthvars)
output: hugodown::md_document
rmd_hash: e13a0c5ba9133f1a

---

{{% pageinfo %}} This below section renders a vignette article from the youthvars library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthvars/articles/V_01.html)
-   [view the source file](https://github.com/ready4-dev/youthvars/blob/main/vignettes/V_01.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthvars/edit/main/vignettes/V_01.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/youthvars/'>youthvars</a></span><span class='o'>)</span></span></code></pre>

</div>

## Variable classes and data integrity

The `youthvars` package defines a number of vector based classes that can be used to quality assure the data recorded for individual variables. `youthvars` variable classes are potentially useful for:

1.  facilitating automated data integrity checks that verify no impermissible values (e.g. utility scores greater than one) are present in source data, transformed data or results; and
2.  automating the selection of the appropriate method to apply to each data type.

## Included classes

The initial set of classes included in the `youthvars` package are one class for Assessment of Quality of Life (Adolescent) health utility and one for each of the predictors used in the utility prediction algorithms included in the related [youthu](https://ready4-dev.github.io/youthu/) package.

### Assessment of Quality of Life Six Dimension (Adolescent) Health Utility

The `youthvars_aqol6d_adol` class is defined for numeric vectors with a minimum value of 0.03 and maximum value of 1.0.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html'>youthvars_aqol6d_adol</a></span><span class='o'>(</span><span class='m'>0.4</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 0.4</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_aqol6d_adol"</span></span>
<span><span class='c'>#&gt; [2] "numeric"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html'>youthvars_aqol6d_adol</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.03</span>,<span class='m'>0.2</span>,<span class='m'>1</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 0.03 0.20 1.00</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_aqol6d_adol"</span></span>
<span><span class='c'>#&gt; [2] "numeric"</span></span></code></pre>

</div>

Non numeric objects and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html'>youthvars_aqol6d_adol</a></span><span class='o'>(</span><span class='s'>"0.5"</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_aqol6d_adol(x): is.numeric(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html'>youthvars_aqol6d_adol</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>0.1</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_aqol6d_adol object must be greater than or equal to 0.03.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html'>youthvars_aqol6d_adol</a></span><span class='o'>(</span><span class='m'>1.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_aqol6d_adol object must be less than or equal to 1.</span></span></code></pre>

</div>

### Behavioural Activation for Depression Scale (BADS)

The `youthvars_bads` class is defined for integer vectors with a minimum value of 0 and maximum value of 150.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html'>youthvars_bads</a></span><span class='o'>(</span><span class='m'>143L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 143</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_bads" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html'>youthvars_bads</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>15</span>,<span class='m'>150</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]   1  15 150</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_bads" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html'>youthvars_bads</a></span><span class='o'>(</span><span class='m'>22.5</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_bads(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html'>youthvars_bads</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_bads object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html'>youthvars_bads</a></span><span class='o'>(</span><span class='m'>160L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_bads object must be less than or equal to 150.</span></span></code></pre>

</div>

### Generalised Anxiety Disorder Scale (GAD-7)

The `youthvars_gad7` class is defined for integer vectors with a minimum value of 0 and a maximum value of 21.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html'>youthvars_gad7</a></span><span class='o'>(</span><span class='m'>15L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 15</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_gad7" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html'>youthvars_gad7</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>14</span>,<span class='m'>21</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 14 21</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_gad7" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html'>youthvars_gad7</a></span><span class='o'>(</span><span class='m'>14.6</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_gad7(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html'>youthvars_gad7</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_gad7 object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html'>youthvars_gad7</a></span><span class='o'>(</span><span class='m'>22L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_gad7 object must be less than or equal to 21.</span></span></code></pre>

</div>

### Kessler Psychological Distress Scale (K6) - US Scoring System

The `youthvars_k6` class is defined for integer vectors with a minimum value of 0 and a maximum value of 24.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html'>youthvars_k6</a></span><span class='o'>(</span><span class='m'>21L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 21</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_k6" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html'>youthvars_k6</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>13</span>,<span class='m'>24</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 13 24</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_k6" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html'>youthvars_k6</a></span><span class='o'>(</span><span class='m'>11.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_k6(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html'>youthvars_k6</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_k6 object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html'>youthvars_k6</a></span><span class='o'>(</span><span class='m'>25L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_k6 object must be less than or equal to 24.</span></span></code></pre>

</div>

### Overall Anxiety Severity and Impairment Scale (OASIS)

The `youthvars_oasis` class is defined for integer vectors with a minimum value of 0 and a maximum value of 20.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html'>youthvars_oasis</a></span><span class='o'>(</span><span class='m'>15L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 15</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_oasis" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html'>youthvars_oasis</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>12</span>,<span class='m'>20</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 12 20</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_oasis" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html'>youthvars_oasis</a></span><span class='o'>(</span><span class='m'>14.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_oasis(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html'>youthvars_oasis</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_oasis object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html'>youthvars_oasis</a></span><span class='o'>(</span><span class='m'>21L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_oasis object must be less than or equal to 20.</span></span></code></pre>

</div>

### Patient Health Questionnaire (PHQ-9)

The `youthvars_phq9` class is defined for integer vectors with a minimum value of 0 and a maximum value of 27.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html'>youthvars_phq9</a></span><span class='o'>(</span><span class='m'>11L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 11</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_phq9" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html'>youthvars_phq9</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>13</span>,<span class='m'>27</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 13 27</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_phq9" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html'>youthvars_phq9</a></span><span class='o'>(</span><span class='m'>15.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_phq9(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html'>youthvars_phq9</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_phq9 object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html'>youthvars_phq9</a></span><span class='o'>(</span><span class='m'>28L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_phq9 object must be less than or equal to 27.</span></span></code></pre>

</div>

### Screen for Child Anxiety Related Disorders (SCARED)

The `youthvars_scared` class is defined for integer vectors with a minimum value of 0 and a maximum value of 82.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html'>youthvars_scared</a></span><span class='o'>(</span><span class='m'>77L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 77</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_scared" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html'>youthvars_scared</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>42</span>,<span class='m'>82</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 42 82</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_scared" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html'>youthvars_scared</a></span><span class='o'>(</span><span class='m'>33.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_scared(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html'>youthvars_scared</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_scared object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html'>youthvars_scared</a></span><span class='o'>(</span><span class='m'>83</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_scared(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

### Social and Occupational Functioning Assessment Scale (SOFAS)

The `youthvars_sofas` class is defined for integer vectors with a minimum value of 0 and a maximum value of 100.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html'>youthvars_sofas</a></span><span class='o'>(</span><span class='m'>44L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] 44</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_sofas" "integer"</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html'>youthvars_sofas</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>23</span>,<span class='m'>89</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1]  0 23 89</span></span>
<span><span class='c'>#&gt; attr(,"class")</span></span>
<span><span class='c'>#&gt; [1] "youthvars_sofas" "integer"</span></span></code></pre>

</div>

Non-integers and values outside these ranges will produce errors.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html'>youthvars_sofas</a></span><span class='o'>(</span><span class='m'>73.2</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error in make_new_youthvars_sofas(x): is.integer(x) is not TRUE</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html'>youthvars_sofas</a></span><span class='o'>(</span><span class='o'>-</span><span class='m'>1L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_sofas object must be greater than or equal to 0.</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html'>youthvars_sofas</a></span><span class='o'>(</span><span class='m'>103L</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Error: All non-missing values in valid youthvars_sofas object must be less than or equal to 100.</span></span></code></pre>

</div>

