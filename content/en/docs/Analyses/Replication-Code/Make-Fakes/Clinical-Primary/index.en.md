---
title: "Create a synthetic population of young people attending primary mental health services"
linkTitle: "Clinical"
date: "2024-01-25"
description: "We created a basic synthetic dataset of to represent a clinical youth mental health sample."
weight: 3
categories: 
- Documentation
tags: 
- Analyses
- Analyses - replication code
- Software
- Software - executable
- Software - executable (programs)
- Software - libraries
- Software - libraries (scorz)
- Software - libraries (specific)
- Software - libraries (TTU)
- Software - libraries (youthu)
- Software - libraries (youthvars)
- Status
- Status - development
- Use
- Use - synthetic populations
output: hugodown::md_document
rmd_hash: 0f4431ff0dbda625

---

{{% pageinfo %}} This below section renders an R Markdown program. The following alternative options may provide improved viewing experience, more contextual information and access to more useful code formats:

-   [view the HTML in the dataset containing its outputs (includes contextual information)](https://doi.org/10.7910/DVN/HJXYKQ) from that article; and;
-   [view the HTML along with the current release of its R Markdown code (useful if you plan to run the code)](https://doi.org/10.5281/zenodo.6321820) and
-   [view the HTML along with the current development version of its R Markdown code (useful if you wish to copy or edit the code)](https://github.com/ready4-dev/aqol6dmap_fakes/) {{% /pageinfo %}}

<div class="highlight">

</div>

# Introduction

This program generates a purely synthetic (i.e. fake - no trace of any real records) population that is reasonably representative of the input data we used for the utility mapping study described in the article <https://doi.org/10.1101/2021.07.07.21260129>.

No access to the real data is required in order to use this program - it is based on summary statistics (e.g. means and standard deviations of variables, correlation matrices). It should be noted however, that a different (and simpler) workflow can be implemented when you do have access to the source dataset (for example, by using the `syn` function from the `synthpop` package).

The output of this program is very similar but not identical to a fake dataset created by an earlier version of this program and which is saved in the "ymh_clinical_dict_r3.RDS" file from the <https://doi.org/10.7910/DVN/HJXYKQ> data repository.

# Install required R packages

If you do not have the following packages already installed, uncomment and run the following lines.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># install.packages("faux")</span></span>
<span><span class='c'># devtools::install_github("ready4-dev/ready4) </span></span>
<span><span class='c'># devtools::install_github("ready4-dev/youthvars) </span></span>
<span><span class='c'># devtools::install_github("ready4-dev/scorz) </span></span>
<span><span class='c'># devtools::install_github("ready4-dev/specific") </span></span>
<span><span class='c'># devtools::install_github("ready4-dev/TTU")</span></span>
<span><span class='c'># devtools::install_github("ready4-dev/youthu")</span></span></code></pre>

</div>

Load the ready4 framework package.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span></code></pre>

</div>

# Specify parameters to generate outcome fake data

## AQoL item response parameters

The first set of input data are the proportions for each allowed response for each of the twenty AQOL-6D questions at both baseline and followup.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>aqol_items_prpns_tbs_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>bl_answer_props_tb <span class='o'>=</span> <span class='nf'>tibble</span><span class='nf'>::</span><span class='nf'><a href='https://tibble.tidyverse.org/reference/tribble.html'>tribble</a></span><span class='o'>(</span></span>
<span>    <span class='o'>~</span><span class='nv'>Question</span>, <span class='o'>~</span><span class='nv'>Answer_1</span>, <span class='o'>~</span><span class='nv'>Answer_2</span>, <span class='o'>~</span><span class='nv'>Answer_3</span>, <span class='o'>~</span><span class='nv'>Answer_4</span>, <span class='o'>~</span><span class='nv'>Answer_5</span>, <span class='o'>~</span><span class='nv'>Answer_6</span>,</span>
<span>    <span class='s'>"Q1"</span>, <span class='m'>0.35</span>, <span class='m'>0.38</span>, <span class='m'>0.16</span>, <span class='m'>0.03</span>, <span class='kc'>NA_real_</span>,<span class='m'>100</span>, <span class='c'># Check item 5 in real data.</span></span>
<span>    <span class='s'>"Q2"</span>, <span class='m'>0.28</span>, <span class='m'>0.38</span>, <span class='m'>0.18</span>, <span class='m'>0.08</span>, <span class='m'>0.04</span>,<span class='m'>100</span>,</span>
<span>    <span class='s'>"Q3"</span>, <span class='m'>0.78</span>, <span class='m'>0.18</span>, <span class='m'>0.03</span>, <span class='m'>0.01</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q4"</span>, <span class='m'>0.64</span>, <span class='m'>0.23</span>, <span class='m'>0.09</span>, <span class='m'>0.0</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q5"</span>, <span class='m'>0.3</span>, <span class='m'>0.48</span>, <span class='m'>0.12</span>, <span class='m'>0.05</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q6"</span>, <span class='m'>0.33</span>, <span class='m'>0.48</span>, <span class='m'>0.15</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q7"</span>, <span class='m'>0.44</span>, <span class='m'>0.27</span>, <span class='m'>0.11</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q8"</span>, <span class='m'>0.18</span>, <span class='m'>0.29</span>, <span class='m'>0.23</span>, <span class='m'>0.21</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q9"</span>, <span class='m'>0.07</span>, <span class='m'>0.27</span>, <span class='m'>0.19</span>, <span class='m'>0.37</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q10"</span>, <span class='m'>0.04</span>, <span class='m'>0.15</span>, <span class='m'>0.4</span>, <span class='m'>0.25</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q11"</span>, <span class='m'>0.03</span>, <span class='m'>0.13</span>, <span class='m'>0.52</span>, <span class='m'>0.25</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q12"</span>, <span class='m'>0.06</span>, <span class='m'>0.21</span>, <span class='m'>0.25</span>, <span class='m'>0.34</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q13"</span>, <span class='m'>0.05</span>, <span class='m'>0.25</span>, <span class='m'>0.31</span>, <span class='m'>0.28</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q14"</span>, <span class='m'>0.05</span>, <span class='m'>0.3</span>, <span class='m'>0.34</span>, <span class='m'>0.25</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q15"</span>, <span class='m'>0.57</span>, <span class='m'>0.25</span>, <span class='m'>0.12</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q16"</span>, <span class='m'>0.48</span>, <span class='m'>0.42</span>, <span class='m'>0.06</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q17"</span>, <span class='m'>0.44</span>, <span class='m'>0.3</span>, <span class='m'>0.16</span>, <span class='m'>0.07</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q18"</span>, <span class='m'>0.33</span>, <span class='m'>0.38</span>, <span class='m'>0.25</span>, <span class='m'>0.04</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q19"</span>, <span class='m'>0.33</span>, <span class='m'>0.49</span>, <span class='m'>0.16</span>, <span class='m'>0.02</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q20"</span>, <span class='m'>0.67</span>, <span class='m'>0.21</span>, <span class='m'>0.02</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span><span class='o'>)</span>,</span>
<span>    fup_answer_props_tb <span class='o'>=</span> <span class='nf'>tibble</span><span class='nf'>::</span><span class='nf'><a href='https://tibble.tidyverse.org/reference/tribble.html'>tribble</a></span><span class='o'>(</span></span>
<span>    <span class='o'>~</span><span class='nv'>Question</span>, <span class='o'>~</span><span class='nv'>Answer_1</span>, <span class='o'>~</span><span class='nv'>Answer_2</span>, <span class='o'>~</span><span class='nv'>Answer_3</span>, <span class='o'>~</span><span class='nv'>Answer_4</span>, <span class='o'>~</span><span class='nv'>Answer_5</span>, <span class='o'>~</span><span class='nv'>Answer_6</span>,</span>
<span>    <span class='s'>"Q1"</span>, <span class='m'>0.51</span>, <span class='m'>0.33</span>, <span class='m'>0.12</span>, <span class='m'>0.02</span>, <span class='kc'>NA_real_</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q2"</span>, <span class='m'>0.36</span>, <span class='m'>0.38</span>, <span class='m'>0.16</span>, <span class='m'>0.06</span>, <span class='m'>0.02</span>,<span class='m'>100</span>,</span>
<span>    <span class='s'>"Q3"</span>, <span class='m'>0.81</span>, <span class='m'>0.15</span>, <span class='m'>0.04</span>, <span class='m'>0.00</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q4"</span>, <span class='m'>0.73</span>, <span class='m'>0.18</span>, <span class='m'>0.09</span>, <span class='m'>0.0</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q5"</span>, <span class='m'>0.36</span>, <span class='m'>0.42</span>, <span class='m'>0.12</span>, <span class='m'>0.05</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q6"</span>, <span class='m'>0.48</span>, <span class='m'>0.40</span>, <span class='m'>0.11</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q7"</span>, <span class='m'>0.57</span>, <span class='m'>0.25</span>, <span class='m'>0.09</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q8"</span>, <span class='m'>0.31</span>, <span class='m'>0.33</span>, <span class='m'>0.17</span>, <span class='m'>0.12</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q9"</span>, <span class='m'>0.13</span>, <span class='m'>0.35</span>, <span class='m'>0.19</span>, <span class='m'>0.23</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q10"</span>, <span class='m'>0.1</span>, <span class='m'>0.21</span>, <span class='m'>0.43</span>, <span class='m'>0.16</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q11"</span>, <span class='m'>0.06</span>, <span class='m'>0.25</span>, <span class='m'>0.48</span>, <span class='m'>0.18</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q12"</span>, <span class='m'>0.08</span>, <span class='m'>0.27</span>, <span class='m'>0.26</span>, <span class='m'>0.25</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q13"</span>, <span class='m'>0.07</span>, <span class='m'>0.37</span>, <span class='m'>0.31</span>, <span class='m'>0.19</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q14"</span>, <span class='m'>0.08</span>, <span class='m'>0.37</span>, <span class='m'>0.34</span>, <span class='m'>0.15</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q15"</span>, <span class='m'>0.62</span>, <span class='m'>0.23</span>, <span class='m'>0.09</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q16"</span>, <span class='m'>0.52</span>, <span class='m'>0.40</span>, <span class='m'>0.06</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q17"</span>, <span class='m'>0.51</span>, <span class='m'>0.28</span>, <span class='m'>0.15</span>, <span class='m'>0.06</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,</span>
<span>    <span class='s'>"Q18"</span>, <span class='m'>0.37</span>, <span class='m'>0.35</span>, <span class='m'>0.25</span>, <span class='m'>0.03</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q19"</span>, <span class='m'>0.43</span>, <span class='m'>0.40</span>, <span class='m'>0.16</span>, <span class='m'>0.01</span>, <span class='m'>0.0</span>, <span class='m'>100</span>,</span>
<span>    <span class='s'>"Q20"</span>, <span class='m'>0.77</span>, <span class='m'>0.21</span>, <span class='m'>0.02</span>, <span class='m'>100</span>, <span class='kc'>NA_real_</span>,<span class='kc'>NA_real_</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>youthvars</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/make_complete_prpns_tbs_ls.html'>make_complete_prpns_tbs_ls</a></span><span class='o'>(</span><span class='o'>)</span></span></code></pre>

</div>

## Outcome variable correlation parameters

First we specify the names of variables we will be creating as outcome variables.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>var_names_chr</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"aqol6d_total_w"</span>,<span class='s'>"phq9_total"</span>,<span class='s'>"bads_total"</span>,</span>
<span>                   <span class='s'>"gad7_total"</span>,<span class='s'>"oasis_total"</span>,<span class='s'>"scared_total"</span>,<span class='s'>"k6_total"</span><span class='o'>)</span></span></code></pre>

</div>

The next step is to specify the correlations between outcome variables (variables assumed to be ordered as in previous step) at baseline and follow-up timepoints.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>cor_mat_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/matrix.html'>matrix</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='o'>-</span><span class='m'>0.78</span>,<span class='m'>0.72</span>,<span class='o'>-</span><span class='m'>0.67</span>,<span class='o'>-</span><span class='m'>0.71</span>,<span class='o'>-</span><span class='m'>0.65</span>,<span class='o'>-</span><span class='m'>0.67</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='m'>1</span>,<span class='o'>-</span><span class='m'>0.73</span>,<span class='m'>0.69</span>,<span class='m'>0.66</span>,<span class='m'>0.63</span>,<span class='m'>0.71</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='o'>-</span><span class='m'>.57</span>,<span class='o'>-</span><span class='m'>0.64</span>,<span class='o'>-</span><span class='m'>0.57</span>,<span class='o'>-</span><span class='m'>0.65</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.74</span>,<span class='m'>0.70</span>,<span class='m'>0.63</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.7</span>,<span class='m'>0.59</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.55</span>,</span>
<span>                               <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span><span class='o'>)</span>,<span class='m'>7</span>,<span class='m'>7</span><span class='o'>)</span>,</span>
<span>                    <span class='nf'><a href='https://rdrr.io/r/base/matrix.html'>matrix</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='o'>-</span><span class='m'>0.81</span>,<span class='m'>0.72</span>,<span class='o'>-</span><span class='m'>0.71</span>,<span class='o'>-</span><span class='m'>0.73</span>,<span class='o'>-</span><span class='m'>0.64</span>,<span class='o'>-</span><span class='m'>0.68</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='m'>1</span>,<span class='o'>-</span><span class='m'>0.72</span>,<span class='m'>0.69</span>,<span class='m'>0.68</span>,<span class='m'>0.61</span>,<span class='m'>0.68</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='o'>-</span><span class='m'>0.59</span>,<span class='o'>-</span><span class='m'>0.61</span>,<span class='o'>-</span><span class='m'>0.51</span>,<span class='o'>-</span><span class='m'>0.61</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.75</span>,<span class='m'>0.71</span>,<span class='m'>0.6</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.68</span>,<span class='m'>0.59</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span>,<span class='m'>0.52</span>,</span>
<span>                        <span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='kc'>NA</span>,<span class='m'>1</span><span class='o'>)</span>,<span class='m'>7</span>,<span class='m'>7</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

We now specify the univariate distribution parameters for each of the outcome variables.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>synth_data_spine_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>cor_mat_ls <span class='o'>=</span> <span class='nv'>cor_mat_ls</span>,</span>
<span>                            nbr_obs_dbl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1068</span>,<span class='m'>643</span><span class='o'>)</span>,</span>
<span>                            timepoint_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"BL"</span>,<span class='s'>"FUP"</span><span class='o'>)</span>,</span>
<span>                            means_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.6</span>,<span class='m'>12.8</span>,<span class='m'>78.2</span>, <span class='m'>10.4</span>,<span class='m'>8.1</span>,<span class='m'>34.2</span>,<span class='m'>12.2</span><span class='o'>)</span>,</span>
<span>                                            <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.7</span>,<span class='m'>9.8</span>,<span class='m'>89.4</span>, <span class='m'>7.9</span>,<span class='m'>6.3</span>,<span class='m'>28.8</span>,<span class='m'>9.8</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                            sds_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.2</span>,<span class='m'>6.6</span>,<span class='m'>24.8</span>,<span class='m'>5.7</span>,<span class='m'>4.7</span>,<span class='m'>17.9</span>,<span class='m'>5.8</span><span class='o'>)</span>,</span>
<span>                                          <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.2</span>,<span class='m'>6.5</span>,<span class='m'>24.4</span>,<span class='m'>5.5</span>,<span class='m'>4.3</span>,<span class='m'>17.8</span>,<span class='m'>5.9</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                            missing_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>4</span>,<span class='m'>10</span>,<span class='m'>6</span>,<span class='m'>7</span>,<span class='m'>7</span>,<span class='m'>4</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>5</span>,<span class='m'>2</span>,<span class='m'>2</span>,<span class='m'>1</span>,<span class='m'>2</span>,<span class='m'>2</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                            min_max_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0.03</span>,<span class='m'>1</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>27</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>150</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>21</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>20</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>82</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>0</span>,<span class='m'>24</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                            discrete_lgl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='kc'>F</span>,<span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>T</span>,<span class='m'>6</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                            var_names_chr <span class='o'>=</span> <span class='nv'>var_names_chr</span>,</span>
<span>                            aqol_tots_var_nms_chr <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span>cumulative <span class='o'>=</span> <span class='s'>"aqol6d_total_c"</span>,</span>
<span>                                                      weighted <span class='o'>=</span> <span class='s'>"aqol6d_total_w"</span><span class='o'>)</span><span class='o'>)</span> </span></code></pre>

</div>

# Generate fake data

## Create fake outcome variable datasets

We now use the parameters we have just specified to create baseline and follow-up datasets with fake data for our nominated outcome variables.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>aqol_scores_pars_ls</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>means_dbl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>44.5</span>,<span class='m'>40.6</span><span class='o'>)</span>, </span>
<span>                            sds_dbl <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>9.9</span>,<span class='m'>9.8</span><span class='o'>)</span>,</span>
<span>                            corr_dbl <span class='o'>=</span> <span class='o'>-</span><span class='m'>0.95</span><span class='o'>)</span></span>
<span><span class='nv'>aqol6d_adol_pop_tbs_ls</span> <span class='o'>&lt;-</span> <span class='nv'>aqol_items_prpns_tbs_ls</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>scorz</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/scorz/reference/make_aqol6d_adol_pop_tbs_ls.html'>make_aqol6d_adol_pop_tbs_ls</a></span><span class='o'>(</span>aqol_scores_pars_ls <span class='o'>=</span> <span class='nv'>aqol_scores_pars_ls</span>,</span>
<span>                                     series_names_chr <span class='o'>=</span>  <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"bl_outcomes_tb"</span>,</span>
<span>                                                           <span class='s'>"fup_outcomes_tb"</span><span class='o'>)</span>,</span>
<span>                                     synth_data_spine_ls <span class='o'>=</span> <span class='nv'>synth_data_spine_ls</span>,</span>
<span>                                     temporal_cors_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>aqol6d_total_w <span class='o'>=</span> <span class='m'>0.85</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(id, match_var_chr)`</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(id)`</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(id, match_var_chr)`</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(id)`</span></span>
<span></span></code></pre>

</div>

## Create fake descriptive variables

We now specify the names and statistical parameters of the variables we will be using in descriptive statistics. For this analysis we are not interested in capturing the joint distribution between these variables, so we only use univariate parameters.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>descriptives_BL_tb</span> <span class='o'>&lt;-</span> <span class='nf'>tibble</span><span class='nf'>::</span><span class='nf'><a href='https://tibble.tidyverse.org/reference/tibble.html'>tibble</a></span><span class='o'>(</span>fkClientID <span class='o'>=</span> <span class='nv'>aqol6d_adol_pop_tbs_ls</span><span class='o'>$</span><span class='nv'>bl_outcomes_tb</span><span class='o'>$</span><span class='nv'>fkClientID</span>,</span>
<span>                                     round <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span><span class='o'>)</span> ,</span>
<span>                                     d_age <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/stats/Normal.html'>rnorm</a></span><span class='o'>(</span><span class='m'>1068</span>,<span class='m'>18.1</span>,<span class='m'>3.3</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_dbl</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>25</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                                        <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='m'>12</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                     d_gender <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>653</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>359</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>3</span>,<span class='m'>39</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>17</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                                       <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Female"</span>,<span class='s'>"Male"</span>,<span class='s'>"Other"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                     d_sexual_ori_s <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>738</span><span class='o'>)</span>,</span>
<span>                                                        <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>289</span><span class='o'>)</span>,</span>
<span>                                                        <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>41</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                                       <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Straight"</span>,<span class='s'>"Other"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                     Region <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>671</span><span class='o'>)</span>,</span>
<span>                                                <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>397</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                                       <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Metro"</span>,<span class='s'>"Regional"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                     CALD <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>T</span>,<span class='m'>759</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>F</span>,<span class='m'>169</span><span class='o'>)</span>,</span>
<span>                                              <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA</span>,<span class='m'>140</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span>,</span>
<span>                                     d_studying_working <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>405</span><span class='o'>)</span>,</span>
<span>                                                            <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>167</span><span class='o'>)</span>,</span>
<span>                                                            <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>3</span>,<span class='m'>305</span><span class='o'>)</span>,</span>
<span>                                                            <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>4</span>,<span class='m'>159</span><span class='o'>)</span>,</span>
<span>                                                            <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>32</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Studying only"</span>,</span>
<span>                                                         <span class='s'>"Working only"</span>,</span>
<span>                                                         <span class='s'>"Studying and working"</span>,</span>
<span>                                                         <span class='s'>"Not studying or working"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                     c_p_diag_s <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>182</span><span class='o'>)</span>,</span>
<span>                                                    <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>264</span><span class='o'>)</span>,</span>
<span>                                                    <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>3</span>,<span class='m'>332</span><span class='o'>)</span>,</span>
<span>                                                    <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>4</span>,<span class='m'>237</span><span class='o'>)</span>,</span>
<span>                                                    <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>53</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                       <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                         <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Depression"</span>, <span class='s'>"Anxiety"</span>,<span class='s'>"Depression and Anxiety"</span>, <span class='s'>"Other"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                         c_clinical_staging_s <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>625</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>326</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>3</span>,<span class='m'>86</span><span class='o'>)</span>,</span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>31</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                           <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                           <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"0-1a"</span>,<span class='s'>"1b"</span>,<span class='s'>"2-4"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                         c_sofas <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/stats/Normal.html'>rnorm</a></span><span class='o'>(</span><span class='m'>1068</span><span class='o'>-</span><span class='m'>30</span>,<span class='m'>65.2</span>,<span class='m'>9.5</span><span class='o'>)</span>,</span>
<span>                                     <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>30</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                           <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_dbl</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>100</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                            <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='m'>0</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                           <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span>,</span>
<span>                         s_centre <span class='o'>=</span> <span class='kc'>NA_character_</span>, </span>
<span>                         d_agegroup <span class='o'>=</span> <span class='kc'>NA_character_</span>, </span>
<span>                         d_sex_birth_s <span class='o'>=</span> <span class='kc'>NA_character_</span>, </span>
<span>                         d_country_bir_s <span class='o'>=</span> <span class='kc'>NA_character_</span>,</span>
<span>                         d_ATSI <span class='o'>=</span> <span class='kc'>NA_character_</span>,</span>
<span>                         d_english_home <span class='o'>=</span> <span class='kc'>NA</span>, </span>
<span>                         d_english_native <span class='o'>=</span> <span class='kc'>NA</span>, </span>
<span>                         d_relation_s <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>1</span>,<span class='m'>325</span><span class='o'>)</span>,</span>
<span>                                          <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>2</span>,<span class='m'>426</span><span class='o'>)</span>,</span>
<span>                                          <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='m'>3</span>,<span class='m'>286</span><span class='o'>)</span>,</span>
<span>                                          <span class='nf'><a href='https://rdrr.io/r/base/rep.html'>rep</a></span><span class='o'>(</span><span class='kc'>NA_real_</span>,<span class='m'>31</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                           <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/scramble_xx.html'>scramble_xx</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                           <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"REPLACE_ME_1"</span>,</span>
<span>                                             <span class='s'>"REPLACE_ME_2"</span>,</span>
<span>                                             <span class='s'>"REPLACE_ME_3"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span>  <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>d_sex_birth_s <span class='o'>=</span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/case_when.html'>case_when</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/NA.html'>is.na</a></span><span class='o'>(</span><span class='nv'>d_gender</span><span class='o'>)</span> <span class='o'>~</span> <span class='kc'>NA_integer_</span>,</span>
<span>                                                 <span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nv'>d_gender</span><span class='o'>)</span> <span class='o'><a href='https://rdrr.io/r/base/match.html'>%in%</a></span> </span>
<span>                                                   <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1L</span>,<span class='m'>2L</span><span class='o'>)</span> <span class='o'>&amp;</span> </span>
<span>                                                   <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span><span class='o'>(</span><span class='m'>1068</span><span class='o'>)</span><span class='o'>&gt;</span><span class='m'>0.995</span> <span class='o'>~</span> <span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nv'>d_gender</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                                                   <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_int</a></span><span class='o'>(</span><span class='o'>~</span> <span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/NA.html'>is.na</a></span><span class='o'>(</span><span class='nv'>.x</span><span class='o'>)</span>, </span>
<span>                                                                           <span class='nv'>.x</span>, </span>
<span>                                                                           <span class='kr'><a href='https://rdrr.io/r/base/switch.html'>switch</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>2L</span>,<span class='m'>1L</span>,<span class='m'>3L</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                                                 <span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nv'>d_gender</span><span class='o'>)</span> <span class='o'>==</span> <span class='m'>3</span> <span class='o'>~</span> <span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1L</span>,<span class='m'>2L</span><span class='o'>)</span>, </span>
<span>                                                                                    <span class='m'>1068</span>, </span>
<span>                                                                                    replace <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span>,</span>
<span>                                                 <span class='kc'>TRUE</span> <span class='o'>~</span> <span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nv'>d_gender</span><span class='o'>)</span></span>
<span>                                                 <span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span>labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Female"</span>,<span class='s'>"Male"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nv'>descriptives_FUP_tb</span> <span class='o'>&lt;-</span> <span class='nv'>descriptives_BL_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>fkClientID</span> <span class='o'><a href='https://rdrr.io/r/base/match.html'>%in%</a></span> </span>
<span>                  <span class='nv'>aqol6d_adol_pop_tbs_ls</span><span class='o'>$</span><span class='nv'>fup_outcomes_tb</span><span class='o'>$</span><span class='nv'>fkClientID</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>round <span class='o'>=</span> <span class='m'>2</span>,</span>
<span>                d_age <span class='o'>=</span> <span class='nv'>d_age</span> <span class='o'>+</span> <span class='m'>0.25</span>,</span>
<span>                Region <span class='o'>=</span> <span class='nv'>Region</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                  <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/randomise_changes_in_fct_lvls.html'>randomise_changes_in_fct_lvls</a></span><span class='o'>(</span><span class='m'>0.98</span><span class='o'>)</span>,</span>
<span>                d_studying_working <span class='o'>=</span> <span class='nv'>d_studying_working</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/randomise_changes_in_fct_lvls.html'>randomise_changes_in_fct_lvls</a></span><span class='o'>(</span><span class='m'>0.9</span><span class='o'>)</span>,</span>
<span>                c_p_diag_s <span class='o'>=</span> <span class='nv'>c_p_diag_s</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                  <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/randomise_changes_in_fct_lvls.html'>randomise_changes_in_fct_lvls</a></span><span class='o'>(</span><span class='m'>0.90</span><span class='o'>)</span>,</span>
<span>                c_clinical_staging_s <span class='o'>=</span> <span class='nv'>c_clinical_staging_s</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                  <span class='nf'>specific</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/specific/reference/randomise_changes_in_fct_lvls.html'>randomise_changes_in_fct_lvls</a></span><span class='o'>(</span><span class='m'>0.8</span><span class='o'>)</span>,</span>
<span>                c_sofas <span class='o'>=</span> <span class='nv'>c_sofas</span> <span class='o'>+</span> <span class='nf'><a href='https://rdrr.io/r/stats/Normal.html'>rnorm</a></span><span class='o'>(</span><span class='m'>643</span>,<span class='m'>4.7</span>,<span class='m'>10</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                         <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_dbl</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>100</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='m'>0</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nv'>bl_tb</span> <span class='o'>&lt;-</span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate-joins.html'>inner_join</a></span><span class='o'>(</span><span class='nv'>descriptives_BL_tb</span>,</span>
<span>                           <span class='nv'>aqol6d_adol_pop_tbs_ls</span><span class='o'>$</span><span class='nv'>bl_outcomes_tb</span><span class='o'>)</span> </span>
<span><span class='c'>#&gt; Joining with `by = join_by(fkClientID)`</span></span>
<span></span><span><span class='nv'>fup_tb</span> <span class='o'>&lt;-</span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate-joins.html'>inner_join</a></span><span class='o'>(</span><span class='nv'>descriptives_FUP_tb</span>,</span>
<span>                            <span class='nv'>aqol6d_adol_pop_tbs_ls</span><span class='o'>$</span><span class='nv'>fup_outcomes_tb</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; Joining with `by = join_by(fkClientID)`</span></span>
<span></span></code></pre>

</div>

We make some adjustments to ensure that the `c_sofas` variable is correlated with our `aqol6d_total_w` variable at both baseline and follow-up.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>bl_tb</span> <span class='o'>&lt;-</span> <span class='nv'>bl_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>c_sofas <span class='o'>=</span> <span class='nf'>faux</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/faux/man/rnorm_pre.html'>rnorm_pre</a></span><span class='o'>(</span><span class='nv'>bl_tb</span><span class='o'>$</span><span class='nv'>aqol6d_total_w</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                            <span class='nf'><a href='https://rdrr.io/r/base/vector.html'>as.vector</a></span><span class='o'>(</span><span class='o'>)</span>, </span>
<span>                                          mu <span class='o'>=</span> <span class='m'>65.2</span>, </span>
<span>                                          sd <span class='o'>=</span> <span class='m'>9.5</span>, </span>
<span>                                          r <span class='o'>=</span> <span class='m'>0.5</span>, </span>
<span>                                          empirical <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_dbl</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>100</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='m'>0</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nv'>fup_tb</span> <span class='o'>&lt;-</span> <span class='nv'>fup_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>c_sofas <span class='o'>=</span> <span class='nf'>faux</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/faux/man/rnorm_pre.html'>rnorm_pre</a></span><span class='o'>(</span><span class='nv'>fup_tb</span><span class='o'>$</span><span class='nv'>aqol6d_total_w</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                                            <span class='nf'><a href='https://rdrr.io/r/base/vector.html'>as.vector</a></span><span class='o'>(</span><span class='o'>)</span>, </span>
<span>                                          mu <span class='o'>=</span> <span class='m'>69.9</span>, </span>
<span>                                          sd <span class='o'>=</span> <span class='m'>10</span>, </span>
<span>                                          r <span class='o'>=</span> <span class='m'>0.5</span>, </span>
<span>                                          empirical <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_dbl</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>.x</span>,<span class='m'>100</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='m'>0</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

## Combine datasets

We now add the fake outcome variables dataset to the fake descriptive variables dataset.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>composite_tb</span> <span class='o'>&lt;-</span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/bind_rows.html'>bind_rows</a></span><span class='o'>(</span><span class='nv'>bl_tb</span>, <span class='nv'>fup_tb</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>d_age <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/Round.html'>floor</a></span><span class='o'>(</span><span class='nv'>d_age</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>d_gender <span class='o'>=</span> <span class='nv'>d_gender</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/character.html'>as.character</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span><span class='o'>==</span><span class='s'>"Other"</span>,</span>
<span>                                         <span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Genderqueer/gender nonconforming/agender"</span>,</span>
<span>                                                              <span class='s'>"Transgender"</span><span class='o'>)</span>,<span class='m'>1</span><span class='o'>)</span>,</span>
<span>                                         <span class='nv'>.x</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                s_centre <span class='o'>=</span> <span class='nv'>Region</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/character.html'>as.character</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span><span class='o'>==</span><span class='s'>"Metro"</span>,</span>
<span>                                         <span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Canberra"</span>,<span class='s'>"Southport"</span>,<span class='s'>"Knox"</span><span class='o'>)</span>,<span class='m'>1</span><span class='o'>)</span>,</span>
<span>                                         <span class='s'>"Regional Centre"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                d_country_bir_s <span class='o'>=</span> <span class='nv'>CALD</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span>,</span>
<span>                                         <span class='s'>"Other"</span>,</span>
<span>                                         <span class='s'>"Australia"</span><span class='o'>)</span><span class='o'>)</span>, </span>
<span>                       d_ATSI <span class='o'>=</span> <span class='nv'>CALD</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span>,</span>
<span>                                         <span class='s'>"Yes"</span>,</span>
<span>                                         <span class='s'>"No"</span><span class='o'>)</span><span class='o'>)</span>,</span>
<span>                       d_english_home <span class='o'>=</span> <span class='nv'>CALD</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span>,</span>
<span>                                         <span class='s'>"No"</span>,</span>
<span>                                         <span class='s'>"Yes"</span><span class='o'>)</span><span class='o'>)</span>, </span>
<span>                       d_english_native <span class='o'>=</span> <span class='nv'>CALD</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>                  <span class='nf'>purrr</span><span class='nf'>::</span><span class='nf'><a href='https://purrr.tidyverse.org/reference/map.html'>map_chr</a></span><span class='o'>(</span><span class='o'>~</span><span class='nf'><a href='https://rdrr.io/r/base/ifelse.html'>ifelse</a></span><span class='o'>(</span><span class='nv'>.x</span>,</span>
<span>                                         <span class='s'>"No"</span>,</span>
<span>                                         <span class='s'>"Yes"</span><span class='o'>)</span><span class='o'>)</span></span>
<span>                <span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='o'>-</span><span class='nv'>CALD</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='o'>-</span><span class='nv'>Region</span><span class='o'>)</span></span>
<span><span class='nv'>composite_tb</span> <span class='o'>&lt;-</span> <span class='nv'>composite_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='o'>-</span><span class='nf'><a href='https://rdrr.io/r/base/sets.html'>setdiff</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/names.html'>names</a></span><span class='o'>(</span><span class='nv'>composite_tb</span><span class='o'>)</span><span class='o'>[</span><span class='nf'><a href='https://rdrr.io/r/base/startsWith.html'>startsWith</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/names.html'>names</a></span><span class='o'>(</span><span class='nv'>composite_tb</span><span class='o'>)</span>,</span>
<span>                                                        <span class='s'>"aqol6d_"</span><span class='o'>)</span><span class='o'>]</span>,</span>
<span>                         <span class='nf'><a href='https://rdrr.io/r/base/names.html'>names</a></span><span class='o'>(</span><span class='nv'>composite_tb</span><span class='o'>)</span><span class='o'>[</span><span class='nf'><a href='https://rdrr.io/r/base/startsWith.html'>startsWith</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/names.html'>names</a></span><span class='o'>(</span><span class='nv'>composite_tb</span><span class='o'>)</span>,</span>
<span>                                                        <span class='s'>"aqol6d_q"</span><span class='o'>)</span><span class='o'>]</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='nv'>composite_tb</span> <span class='o'>&lt;-</span> <span class='nv'>composite_tb</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>c_sofas <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/integer.html'>as.integer</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/Round.html'>round</a></span><span class='o'>(</span><span class='nv'>c_sofas</span>,<span class='m'>0</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>round <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span><span class='nv'>round</span>, labels <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Baseline"</span>,</span>
<span>                                                 <span class='s'>"Follow-up"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>d_relation_s <span class='o'>=</span> <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/case_when.html'>case_when</a></span><span class='o'>(</span><span class='nv'>d_relation_s</span> <span class='o'><a href='https://rdrr.io/r/base/match.html'>%in%</a></span> </span>
<span>                                                  <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"REPLACE_ME_1"</span>,<span class='s'>"REPLACE_ME_2"</span><span class='o'>)</span> <span class='o'>~</span> </span>
<span>                                                  <span class='s'>"Not in a relationship"</span>,</span>
<span>                                                <span class='kc'>T</span> <span class='o'>~</span> <span class='s'>"In a relationship"</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>youthu</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/youthu/reference/add_dates_from_dstr.html'>add_dates_from_dstr</a></span><span class='o'>(</span>bl_start_date_dtm <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/Sys.time.html'>Sys.Date</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>-</span> <span class='nf'>lubridate</span><span class='nf'>::</span><span class='nf'><a href='https://lubridate.tidyverse.org/reference/period.html'>days</a></span><span class='o'>(</span><span class='m'>600</span><span class='o'>)</span>,<span class='c'>##</span></span>
<span>                              bl_end_date_dtm <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/Sys.time.html'>Sys.Date</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>-</span> <span class='nf'>lubridate</span><span class='nf'>::</span><span class='nf'><a href='https://lubridate.tidyverse.org/reference/period.html'>days</a></span><span class='o'>(</span><span class='m'>420</span><span class='o'>)</span>,</span>
<span>                              duration_args_ls <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>a <span class='o'>=</span> <span class='m'>60</span>, b <span class='o'>=</span> <span class='m'>140</span>, mean <span class='o'>=</span> <span class='m'>90</span>, sd <span class='o'>=</span> <span class='m'>10</span><span class='o'>)</span>,</span>
<span>                              duration_fn <span class='o'>=</span> <span class='nf'>truncnorm</span><span class='nf'>::</span><span class='nv'><a href='https://rdrr.io/pkg/truncnorm/man/dtruncnorm.html'>rtruncnorm</a></span>,</span>
<span>                              date_var_nm_1L_chr <span class='o'>=</span> <span class='s'>"d_interview_date"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='o'>-</span><span class='nv'>duration_prd</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>youthvars</span><span class='nf'>::</span><span class='nf'><a href='https://ready4-dev.github.io/youthvars/reference/transform_raw_ds_for_analysis.html'>transform_raw_ds_for_analysis</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/rename.html'>rename</a></span><span class='o'>(</span>phq9_total <span class='o'>=</span> <span class='nv'>PHQ9</span>,</span>
<span>                bads_total <span class='o'>=</span> <span class='nv'>BADS</span>,</span>
<span>                gad7_total <span class='o'>=</span> <span class='nv'>GAD7</span>,</span>
<span>                oasis_total <span class='o'>=</span> <span class='nv'>OASIS</span>,</span>
<span>                scared_total <span class='o'>=</span> <span class='nv'>SCARED</span>,</span>
<span>                k6_total <span class='o'>=</span> <span class='nv'>K6</span>,</span>
<span>                c_sofas <span class='o'>=</span> <span class='nv'>SOFAS</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>dplyr</span><span class='nf'>::</span><span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='o'>-</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"d_agegroup"</span>,<span class='s'>"Gender"</span>, <span class='s'>"CALD"</span>, <span class='s'>"Region"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

