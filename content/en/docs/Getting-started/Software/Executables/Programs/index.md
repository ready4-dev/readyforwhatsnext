---
title: "Programs"
linkTitle: "Programs"
date: "2022-12-24"
description: "Programs are used to generate and report a model analysis."
weight: 3
categories: 
- Documentation
tags: 
- Software
- Software - executable
- Software - executable (programs)
output: hugodown::md_document
rmd_hash: 320c76ce6fb4ee8b

---

## What are ready4 programs?

Programs can be executed in their current form without the need for additional input data and, unless modified or run interactively (prompting a user for inputs during execution), will always generate the exact same output. They are typically deployed for configuring the run specifications of a computational model, specifying the data to which it will be applied and reporting analysis results.

## Why are they useful?

ready4 programs can be used for the following purposes:

-   to reproduce a study analysis, in which case you will need access to the original study data, and may also need to modify the program to specify the path to this data from your machine;
-   to replicate a study analysis (ie to apply the study algorithm to similar but different input data \[this can be a new sample from the same population or, if used for demonstration purposes, fake data representative of the original study dataset\]), in which case you will need to modify the program to specify the path to this data; and
-   to generalise a study analysis, in which case you use the program as a template to be modified to reflect key differences between the original study and your study.

## Current ready4 programs

Currently available ready4 programs are summarised in the below table.

<html>


<body>






<div id="header">




</div>


<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Program
</th>
<th style="text-align:left;">
Release
</th>
<th style="text-align:left;">
Date
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Source
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
aqol6dmap_fakes
</td>
<td style="text-align:left;">
0.0.9.0
</td>
<td style="text-align:left;">
02-Mar-2022
</td>
<td style="text-align:left;">
This program generates a purely synthetic (i.e. fake - no trace of any
real records) population that is reasonably representative of the input
data we used for the utility mapping study described in the article <a href="https://doi.org/10.1101/2021.07.07.21260129" class="uri">https://doi.org/10.1101/2021.07.07.21260129</a>.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/aqol6dmap_fakes" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.6321820" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
aqol6dmap_use
</td>
<td style="text-align:left;">
0.1
</td>
<td style="text-align:left;">
13-Sep-2022
</td>
<td style="text-align:left;">
Apply AQoL-6D Utility Mapping Models To New DataThis release includes
minor formatting change and an updated version number.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/aqol6dmap_use" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.6317179" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
dce_sa_analysis
</td>
<td style="text-align:left;">
0.1.1
</td>
<td style="text-align:left;">
28-Oct-2022
</td>
<td style="text-align:left;">
A self-documenting R Markdown program for analysing responses to a
discrete choice experiment exploring the online help-seeking preferences
of socially anxious young people.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/dce_sa_analysis" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.7223286" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
dce_sa_design
</td>
<td style="text-align:left;">
0.0.9.3
</td>
<td style="text-align:left;">
26-Oct-2022
</td>
<td style="text-align:left;">
An R Markdown program to create the experimental design for a Discrete
Choice Experiment (DCE) exploring online help seeking in socially
anxious young people.This release uses functions from the mychoice R
package (<a href="https://github.com/ready4-dev/mychoice" class="uri">https://github.com/ready4-dev/mychoice</a>).
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/dce_sa_design" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.6626256" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
ttu_lng_aqol6_csp
</td>
<td style="text-align:left;">
0.1
</td>
<td style="text-align:left;">
16-Sep-2022
</td>
<td style="text-align:left;">
Complete study program to reproduce all steps from data ingest through
to results dissemination for a study to map mental health measures to
AQoL-6D health utility.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/ttu_lng_aqol6_csp" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.6116077" style="     ">Archive</a>
</td>
</tr>
</tbody>
</table>





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

## Documentation

ready4 programs are typically self-documenting, meaning that each section of code is integrated with plain English descriptions of the purpose it fulfills. The only programs that are not self-documenting are those whose primary purpose is to produce a document (normally an analysis report). Self-documenting programs and sub-routines will be typically documented as a PDF or HTML render of the RMarkdown source file. This rendered document will be bundled with the program, but in some cases may also be shared in online data repositories.

