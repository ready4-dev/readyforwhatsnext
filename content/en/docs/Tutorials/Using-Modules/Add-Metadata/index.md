---
title: "Add metadata to datasets of individual human records"
linkTitle: "Describe datasets"
date: "2024-06-08"
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
<code>YouthvarsSeries</code> that form part of the <a href="https://readyforwhatsnext.org/">readyforwhatsnext economic model
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
<pre class="r"><code>depict(Y, var_nms_chr = c(&quot;c_sofas&quot;), labels_chr = c(&quot;SOFAS&quot;))</code></pre>
<div class="figure">
<img src="data:image/png;base64,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g2wVVFpgkgJNAN5oHz+B/lo+NlxdfeMZ8qz/tlOvrjw7QALd/zD4v3HgZOBobRx0uRe8JgxM8go0AXijffyuQPc/DK4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJICTQDeaAq0Aq4InAwcrY2DbBVUWmCSAk0A3mgKtAKuCJwMHK2Ng2wVVFpgkgJNAN5oCrQCrgicDBytjYNsFVRaYJIC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pEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWVFpikQBOAN5oCrYArAicDR2vjIFsFlRaYpEATgDeaAq2AKwInA0dr4yBbBZUWmKRAE4A3mgKtgCsCJwNHa+MgWwWV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" alt="SOFAS total scores" width="600px" />
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
<pre class="r"><code>depict(Z,
       type_1L_chr = &quot;by_time&quot;,
       var_nms_chr = c(&quot;c_sofas&quot;),
       label_fill_1L_chr = &quot;Time&quot;,#
       labels_chr = c(&quot;SOFAS&quot;),#
       y_label_1L_chr = &quot;&quot;)</code></pre>
<div class="figure">
<img src="data:image/png;base64,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Otvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRogAItgEukQBVoOtvc0hRowIMT6K+l4+rqlwnrU33M2X6T4GyLTRZW+5izfZoBCXT/l8H/xnkH6h1oOtvc0rwDDXhwd6D7vwwukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAukQJVoOlsc0tToAEKtAAuEVegx5xtsgcVaLA0BRqgQAvgEilQBZrONrc0BRqgQAvgElEFumq4wx13uDfi2aZQoMHSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2AS6RAFWg629zSFGiAAi2A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" alt="SOFAS total scores by data collection round" width="600px" />
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

