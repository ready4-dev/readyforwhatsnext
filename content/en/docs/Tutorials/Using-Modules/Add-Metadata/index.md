---
title: "Add metadata to datasets of individual human records"
linkTitle: "Describe datasets"
date: "2026-01-29"
description: "Appending appropriate metadata to datasets of individual unit records can facilitate partial automation of some modelling tasks. This tutorial describes how a module from the youthvars R package can help you to add metadata to a youth mental health dataset so that it can be more readily used by other readyforwhatsnext modules."
weight: 10
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
- Status
- Status - development
output: hugodown::md_document
rmd_hash: a14eab225ea3dd01

---

{{% pageinfo %}} This below section renders a vignette article from the youthvars library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/youthvars/articles/V_02.html)
-   [view the source file](https://github.com/ready4-dev/youthvars/blob/main/vignettes/V_02.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/youthvars/edit/main/vignettes/V_02.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<html>


<body>






<div id="header">




</div>


<p>Note: <strong>This vignette is illustrated with fake data</strong>.
The dataset explored in this example should not be used to inform
decision-making.</p>
<pre class="r"><code>library(ready4)
library(youthvars)</code></pre>
<p>Youthvars provides two <a href="https://www.ready4-dev.com/docs/framework/implementation/modularity/#ready4-model-modules">ready4
framework modules</a> - <code>YouthvarsProfile</code> and
<code>YouthvarsSeries</code> that form part of the <a href="https://readyforwhatsnext.com/">readyforwhatsnext economic model
of youth mental health</a>. The ready4 modules in <code>youthvars</code>
extend the <a href="https://www.ready4-dev.com/docs/framework/use/authoring-data/label-data/">Ready4useDyad
module</a> and can be used to help describe key structural properties of
youth mental health datasets.</p>
<div id="ingest-data" class="section level2">
<h2>Ingest data</h2>
<p>To start we ingest <code>X</code>, a <code>Ready4useDyad</code>
(dataset and data dictionary pair) that we can download from a remote
repository.</p>
<pre class="r"><code>X &lt;- ready4use::Ready4useRepos(dv_nm_1L_chr = &quot;fakes&quot;,
                               dv_ds_nm_1L_chr = &quot;https://doi.org/10.7910/DVN/W95KED&quot;,
                               dv_server_1L_chr = &quot;dataverse.harvard.edu&quot;) %&gt;%
  ingest(fls_to_ingest_chr = &quot;ymh_clinical_dyad_r4&quot;,
         metadata_1L_lgl = F)</code></pre>
</div>
<div id="add-metadata" class="section level2">
<h2>Add metadata</h2>
<p>If a dataset is cross-sectional or we wish to treat it as if it were
(i.e., where data collection rounds are ignored) we can create
<code>Y</code>, an instance of the <code>YouthvarsProfile</code> module,
to add minimal metadata (the name of the unique identifier
variable).</p>
<pre class="r"><code>Y &lt;- YouthvarsProfile(a_Ready4useDyad = X, id_var_nm_1L_chr = &quot;fkClientID&quot;)</code></pre>
<p>If the temporal dimension of the dataset is important, it may be
therefore preferable to instead transform <code>X</code> into a
<code>YouthvarsSeries</code> module instance.
<code>YouthvarsSeries</code> objects contain all of the fields of
<code>YouthvarsProfile</code> objects, but also include additional
fields that are specific for longitudinal datasets
(e.g. <code>timepoint_var_nm_1L_chr</code> and
<code>timepoint_vals_chr</code> that respectively specify the
data-collection timepoint variable name and values and
<code>participation_var_1L_chr</code> that specifies the desired name of
a yet to be created variable that will summarise the data-collection
timepoints for which each unit record supplied data).</p>
<pre class="r"><code>Z &lt;- YouthvarsSeries(a_Ready4useDyad = X,
                     id_var_nm_1L_chr = &quot;fkClientID&quot;,
                     participation_var_1L_chr = &quot;participation&quot;,
                     timepoint_vals_chr = c(&quot;Baseline&quot;,&quot;Follow-up&quot;),
                     timepoint_var_nm_1L_chr = &quot;round&quot;)</code></pre>
</div>
<div id="youthvarsprofile-methods" class="section level2">
<h2>YouthvarsProfile methods</h2>
<div id="inspect-data" class="section level3">
<h3>Inspect data</h3>
<p>We can now specify the variables that we would like to prepare
descriptive statistics for by using the <code>renew</code> method. The
variables to be profiled are specified in the <code>profile_chr</code>
argument, the number of decimal digits (default = 3) of numeric values
in the summary tables to be generated can be specified with
<code>nbr_of_digits_1L_int</code>.</p>
<pre class="r"><code>Y &lt;- renew(Y, nbr_of_digits_1L_int = 2L, profile_chr = c(&quot;d_age&quot;,&quot;d_sexual_ori_s&quot;,&quot;d_studying_working&quot;))</code></pre>
<p>We can now view the descriptive statistics we created in the previous
step.</p>
<pre class="r"><code>Y %&gt;%
  exhibit(profile_idx_int = 1L, scroll_box_args_ls = list(width = &quot;100%&quot;))</code></pre>
<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>
Descriptive summary
</caption>
<thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="2">
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
1711)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Age
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
17.64
</td>
<td style="text-align:left;width: 3em; ">
(3.09)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
18.00
</td>
<td style="text-align:left;width: 3em; ">
(15.00, 20.00)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
12.00
</td>
<td style="text-align:left;width: 3em; ">
25.00
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
0.00
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Sexual orientation
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:left;width: 3em; ">
1178.00
</td>
<td style="text-align:left;width: 3em; ">
(71.74%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;width: 3em; ">
464.00
</td>
<td style="text-align:left;width: 3em; ">
(28.26%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
69.00
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Education and employment status
</td>
<td style="text-align:left;">
Not studying or working
</td>
<td style="text-align:left;width: 3em; ">
311.00
</td>
<td style="text-align:left;width: 3em; ">
(18.75%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Studying and working
</td>
<td style="text-align:left;width: 3em; ">
451.00
</td>
<td style="text-align:left;width: 3em; ">
(27.19%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Studying only
</td>
<td style="text-align:left;width: 3em; ">
572.00
</td>
<td style="text-align:left;width: 3em; ">
(34.48%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Working only
</td>
<td style="text-align:left;width: 3em; ">
325.00
</td>
<td style="text-align:left;width: 3em; ">
(19.59%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
52.00
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
</tbody>
</table>
<p>We can also plot the distributions of selected variables in our
dataset.</p>
<pre class="r"><code>depict(Y, x_vars_chr = c(&quot;c_sofas&quot;), x_labels_chr = c(&quot;SOFAS&quot;), as_percent_1L_lgl = T, style_1L_chr = &quot;lancet&quot; ,what_1L_chr = &quot;histogram&quot;, bins = 10)</code></pre>
<div class="figure">
<img role="img" aria-label="SOFAS total scores" src="data:image/png;base64,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" alt="SOFAS total scores" width="600px" />
<p class="caption">
SOFAS total scores
</p>
</div>
</div>
</div>
<div id="youthvarsseries-methods" class="section level2">
<h2>YouthvarsSeries methods</h2>
<div id="validate-data" class="section level3">
<h3>Validate data</h3>
<p>To explore longitudinal data we need to first use the
<code>ratify</code> method to ensure that <code>Z</code> has been
appropriately configured for methods examining datasets reporting
measures at two timepoints.</p>
<pre class="r"><code>Z &lt;- ratify(Z,
            type_1L_chr = &quot;two_timepoints&quot;)</code></pre>
</div>
<div id="inspect-data-1" class="section level3">
<h3>Inspect data</h3>
<p>We can now specify the variables that we would like to prepare
descriptive statistics for using the <code>renew</code> method. The
variables to be profiled are specified in arguments beginning with
“compare_”. Use <code>compare_ptcpn_chr</code> to compare variables
based on whether cases reported data at one or both timepoints and
<code>compare_by_time_chr</code> to compare the summary statistics of
variables by timepoints, e.g at baseline and follow-up. If you wish
these comparisons to report p values, then use the
<code>compare_ptcpn_with_test_chr</code> and
<code>compare_by_time_with_test_chr</code> arguments.</p>
<pre class="r"><code>Z &lt;- renew(Z,
           compare_by_time_chr = c(&quot;d_age&quot;,&quot;d_sexual_ori_s&quot;,&quot;d_studying_working&quot;),
           compare_by_time_with_test_chr = c(&quot;k6_total&quot;, &quot;phq9_total&quot;, &quot;bads_total&quot;),
           compare_ptcpn_with_test_chr = c(&quot;k6_total&quot;, &quot;phq9_total&quot;, &quot;bads_total&quot;)) </code></pre>
<p>The tables generated in the preceding step can be inspected using the
<code>exhibit</code> method.</p>
<pre class="r"><code>Z %&gt;%
  exhibit(profile_idx_int = 1L,
          scroll_box_args_ls = list(width = &quot;100%&quot;))</code></pre>
<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>
Outcomes by data completeness
</caption>
<thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Baseline only
</div>
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Baseline and follow-up
</div>
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
1068)
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
643)
</th>
<th style="text-align:left;">
<em>p</em>
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Kessler Psychological Distress Scale (6 Dimension)
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
12.153
</td>
<td style="text-align:left;width: 3em; ">
(5.409)
</td>
<td style="text-align:left;width: 3em; ">
11.069
</td>
<td style="text-align:left;width: 3em; ">
(5.778)
</td>
<td style="text-align:left;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
12.000
</td>
<td style="text-align:left;width: 3em; ">
(8.000, 16.000)
</td>
<td style="text-align:left;width: 3em; ">
11.000
</td>
<td style="text-align:left;width: 3em; ">
(7.000, 15.000)
</td>
<td style="text-align:left;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
24.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
24.000
</td>
<td style="text-align:left;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
3.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Patient Health Questionnaire
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
12.632
</td>
<td style="text-align:left;width: 3em; ">
(6.086)
</td>
<td style="text-align:left;width: 3em; ">
11.194
</td>
<td style="text-align:left;width: 3em; ">
(6.434)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
13.000
</td>
<td style="text-align:left;width: 3em; ">
(8.000, 17.000)
</td>
<td style="text-align:left;width: 3em; ">
11.000
</td>
<td style="text-align:left;width: 3em; ">
(6.000, 16.000)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
27.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
27.000
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
1.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
5.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Behavioural Activation for Depression Scale
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
79.814
</td>
<td style="text-align:left;width: 3em; ">
(26.478)
</td>
<td style="text-align:left;width: 3em; ">
83.571
</td>
<td style="text-align:left;width: 3em; ">
(25.809)
</td>
<td style="text-align:left;">
0.010
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
79.000
</td>
<td style="text-align:left;width: 3em; ">
(62.000, 95.250)
</td>
<td style="text-align:left;width: 3em; ">
84.000
</td>
<td style="text-align:left;width: 3em; ">
(66.000, 101.000)
</td>
<td style="text-align:left;">
0.010
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
150.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
150.000
</td>
<td style="text-align:left;">
0.010
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
1.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
10.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.010
</td>
</tr>
</tbody>
</table>
<pre class="r"><code>Z %&gt;%
  exhibit(profile_idx_int = 2L,
          scroll_box_args_ls = list(width = &quot;100%&quot;))</code></pre>
<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>
Outcomes by data collection round
</caption>
<thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Baseline
</div>
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Follow-up
</div>
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
1068)
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
643)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Age
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
17.555
</td>
<td style="text-align:left;width: 3em; ">
(3.090)
</td>
<td style="text-align:left;width: 3em; ">
17.770
</td>
<td style="text-align:left;width: 3em; ">
(3.091)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
17.000
</td>
<td style="text-align:left;width: 3em; ">
(15.000, 20.000)
</td>
<td style="text-align:left;width: 3em; ">
18.000
</td>
<td style="text-align:left;width: 3em; ">
(16.000, 20.000)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
12.000
</td>
<td style="text-align:left;width: 3em; ">
25.000
</td>
<td style="text-align:left;width: 3em; ">
12.000
</td>
<td style="text-align:left;width: 3em; ">
25.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Sexual orientation
</td>
<td style="text-align:left;">
Heterosexual
</td>
<td style="text-align:left;width: 3em; ">
738.000
</td>
<td style="text-align:left;width: 3em; ">
(71.860%)
</td>
<td style="text-align:left;width: 3em; ">
440.000
</td>
<td style="text-align:left;width: 3em; ">
(71.545%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;width: 3em; ">
289.000
</td>
<td style="text-align:left;width: 3em; ">
(28.140%)
</td>
<td style="text-align:left;width: 3em; ">
175.000
</td>
<td style="text-align:left;width: 3em; ">
(28.455%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
41.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
28.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Education and employment status
</td>
<td style="text-align:left;">
Not studying or working
</td>
<td style="text-align:left;width: 3em; ">
159.000
</td>
<td style="text-align:left;width: 3em; ">
(15.347%)
</td>
<td style="text-align:left;width: 3em; ">
152.000
</td>
<td style="text-align:left;width: 3em; ">
(24.398%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Studying and working
</td>
<td style="text-align:left;width: 3em; ">
305.000
</td>
<td style="text-align:left;width: 3em; ">
(29.440%)
</td>
<td style="text-align:left;width: 3em; ">
146.000
</td>
<td style="text-align:left;width: 3em; ">
(23.435%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Studying only
</td>
<td style="text-align:left;width: 3em; ">
405.000
</td>
<td style="text-align:left;width: 3em; ">
(39.093%)
</td>
<td style="text-align:left;width: 3em; ">
167.000
</td>
<td style="text-align:left;width: 3em; ">
(26.806%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Working only
</td>
<td style="text-align:left;width: 3em; ">
167.000
</td>
<td style="text-align:left;width: 3em; ">
(16.120%)
</td>
<td style="text-align:left;width: 3em; ">
158.000
</td>
<td style="text-align:left;width: 3em; ">
(25.361%)
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
32.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
20.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
</tr>
</tbody>
</table>
<pre class="r"><code>Z %&gt;%
  exhibit(profile_idx_int = 3L,
          scroll_box_args_ls = list(width = &quot;100%&quot;))</code></pre>
<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>
Outcomes by data collection round (with p values)
</caption>
<thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Baseline
</div>
</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">
<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">
Follow-up
</div>
</th>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1">
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
1068)
</th>
<th style="text-align:left;">
(N =
</th>
<th style="text-align:left;">
643)
</th>
<th style="text-align:left;">
<em>p</em>
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Kessler Psychological Distress Scale (6 Dimension)
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
12.082
</td>
<td style="text-align:left;width: 3em; ">
(5.603)
</td>
<td style="text-align:left;width: 3em; ">
10.100
</td>
<td style="text-align:left;width: 3em; ">
(5.665)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
12.000
</td>
<td style="text-align:left;width: 3em; ">
(8.000, 16.000)
</td>
<td style="text-align:left;width: 3em; ">
10.000
</td>
<td style="text-align:left;width: 3em; ">
(6.000, 14.000)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
24.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
24.000
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
1.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
2.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Patient Health Questionnaire
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
12.646
</td>
<td style="text-align:left;width: 3em; ">
(6.230)
</td>
<td style="text-align:left;width: 3em; ">
9.736
</td>
<td style="text-align:left;width: 3em; ">
(6.210)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
13.000
</td>
<td style="text-align:left;width: 3em; ">
(8.000, 17.000)
</td>
<td style="text-align:left;width: 3em; ">
10.000
</td>
<td style="text-align:left;width: 3em; ">
(5.000, 14.000)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
27.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
27.000
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
4.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
2.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
Behavioural Activation for Depression Scale
</td>
<td style="text-align:left;">
Mean (SD)
</td>
<td style="text-align:left;width: 3em; ">
78.429
</td>
<td style="text-align:left;width: 3em; ">
(25.608)
</td>
<td style="text-align:left;width: 3em; ">
89.615
</td>
<td style="text-align:left;width: 3em; ">
(25.205)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Median (Q1, Q3)
</td>
<td style="text-align:left;width: 3em; ">
78.000
</td>
<td style="text-align:left;width: 3em; ">
(61.000, 95.000)
</td>
<td style="text-align:left;width: 3em; ">
88.000
</td>
<td style="text-align:left;width: 3em; ">
(73.000, 106.000)
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Min - Max
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
150.000
</td>
<td style="text-align:left;width: 3em; ">
0.000
</td>
<td style="text-align:left;width: 3em; ">
150.000
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;width: 14em; font-weight: bold;">
</td>
<td style="text-align:left;">
Missing
</td>
<td style="text-align:left;width: 3em; ">
7.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;width: 3em; ">
4.000
</td>
<td style="text-align:left;width: 3em; ">
</td>
<td style="text-align:left;">
0.000
</td>
</tr>
</tbody>
</table>
<p>The <code>depict</code> method can create plots, comparing numeric
variables by timepoint.</p>
<pre class="r"><code>depict(Z, x_vars_chr = c(&quot;c_sofas&quot;), x_labels_chr = c(&quot;SOFAS&quot;), y_labels_chr = &quot;&quot;, z_vars_chr = &quot;round&quot;,
       z_labels_chr = &quot;Time&quot;, as_percent_1L_lgl = T, position_xx  =&quot;dodge&quot;, style_1L_chr = &quot;lancet&quot;,
       what_1L_chr = &quot;histogram&quot;, bins=10)</code></pre>
<pre><code>## Ignoring unknown labels:
## • shape : &quot;Time&quot;
## • linetype : &quot;Time&quot;</code></pre>
<div class="figure">
<img role="img" aria-label="SOFAS total scores by data collection round" src="data:image/png;base64,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tIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQegG03oYBtIEi2AXQnZ5nljfqSe/6TzYLoGkAPU8R7AJoWq6fz/NmPeld/8lmATQNoOcpgl0ATQNogVkATQPoeYpgF0DT8lADaL1hAO22CHYBNA2gBWYBNA2g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" alt="SOFAS total scores by data collection round" width="600px" />
<p class="caption">
SOFAS total scores by data collection round
</p>
</div>
</div>
</div>
<div id="share-data" class="section level2">
<h2>Share data</h2>
<p><strong>If and only if the dataset you are working with is
appropriate for public dissemination (e.g. is synthetic data), you can
use the following workflow for sharing it.</strong> We can share the
dataset we created for this example using the <code>share</code> method,
specifying the repository to which we wish to publish the dataset (and
for which we have write permissions) in a (<a href="https://ready4-dev.github.io/ready4use/articles/V_01.html">Ready4useRepos
object</a>).</p>
<pre class="r"><code>A &lt;- Ready4useRepos(gh_repo_1L_chr = &quot;ready4-dev/youthvars&quot;, # Replace with your repository 
                          gh_tag_1L_chr = &quot;Documentation_0.0&quot;), # (need write permissions).
A &lt;- share(A,
           obj_to_share_xx = Z,
           fl_nm_1L_chr = &quot;ymh_YouthvarsSeries&quot;)</code></pre>
<p><code>Z</code> is now available for download as the file
<code>ymh_YouthvarsSeries.RDS</code> from the <a href="https://github.com/ready4-dev/youthvars/releases/tag/Documentation_0.0">“Documentation_0.0”
release of the youthvars package</a>.</p>
</div>





<script>

// add bootstrap table styles to pandoc tables
function bootstrapStylePandocTables() {
  $('tr.odd').parent('tbody').parent('table').addClass('table table-condensed');
}
$(document).ready(function () {
  bootstrapStylePandocTables();
});


</script>

<!-- tabsets -->

<script>
$(document).ready(function () {
  window.buildTabsets("TOC");
});

$(document).ready(function () {
  $('.tabset-dropdown > .nav-tabs > li').click(function () {
    $(this).parent().toggleClass('nav-tabs-open');
  });
});
</script>

<!-- code folding -->


<!-- dynamically load mathjax for compatibility with self-contained -->
<script>
  (function () {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
    document.getElementsByTagName("head")[0].appendChild(script);
  })();
</script>

</body>
</html>

