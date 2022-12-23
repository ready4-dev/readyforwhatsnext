---
title: "Subroutines"
linkTitle: "Subroutines"
date: "2022-12-24"
description: "Subroutines perform part of an analysis and reporting algorithm."
weight: 4
categories: 
- Documentation
tags: 
- Subroutines
output: hugodown::md_document
rmd_hash: d62823eb9073dfd8

---

## What are ready4 subroutines?

Sub-routines need to be called by parent [programs](../programs) that supply them with input data. Sub-routines can be called by multiple programs and will produce output that varies based on the input values they are supplied with. They are typically deployed to implement parts of a model's analysis and reporting algorithm.

## Why are they useful?

ready4 subroutines can be used for the following purposes:

-   to help execute a program or function written by a third party (in which case you probably won't need to modify the subroutine and may not even be aware that it is being used);
-   to help execute a program or function that you write (in which case, you shouldn't have to modify the subroutine, but may find it useful to customise it to your purposes); and
-   to serve as a template for subroutines you write yourself that perform similar tasks (in which case you will be rewriting the subroutine's code).

## Current ready4 subroutines

Currently available ready4 subroutines are summarised in the below table.

<html>


<body>






<div id="header">




</div>


<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Subroutine
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
ms_tmpl
</td>
<td style="text-align:left;">
0.1.1.0
</td>
<td style="text-align:left;">
19-Apr-2022
</td>
<td style="text-align:left;">
A collection of files to provide a template for generating scientific
manuscripts describing open source mental health systems models projects
that use the ready4 framework.This release is a minor patch to correct
an incorrectly specified version number.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/ms_tmpl" style="     ">Dev</a> ,
<a href="https://doi.org/10.5281/zenodo.5866880" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
mychoice_results
</td>
<td style="text-align:left;">
0.1
</td>
<td style="text-align:left;">
07-Nov-2022
</td>
<td style="text-align:left;">
Report results from a Discrete Choice Experiment implemented with the
mychoice R package.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/mychoice_results" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.7297904" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
ttu_lng_ss
</td>
<td style="text-align:left;">
0.8.0.0
</td>
<td style="text-align:left;">
09-Sep-2022
</td>
<td style="text-align:left;">
This software extends the R package TTU (<a href="https://ready4-dev.github.io/TTU/" class="uri">https://ready4-dev.github.io/TTU/</a>) by providing a
toolkit for automatically authoring a first draft of a scientific
manuscript describing a utility mapping study using metadada generated
by TTU classes and methods. The extension can produce manuscripts in PDF
/ LaTex and Word formats - see <a href="https://doi.org/10.7910/DVN/D74QMP" class="uri">https://doi.org/10.7910/DVN/D74QMP</a> for examples. It
should be noted that the Word output requires some manual editing to
adapt section numbering, modify table headers and resize tables to page
boundaries.This version fixes some bugs in how software versions were
referenced in the generated manuscript.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/ttu_lng_ss" style="     ">Dev</a>
,
<a href="https://doi.org/10.5281/zenodo.5976987" style="     ">Archive</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
ttu_mdl_ctlg
</td>
<td style="text-align:left;">
0.0.9.7
</td>
<td style="text-align:left;">
09-Sep-2022
</td>
<td style="text-align:left;">
Generate a template utility mapping (transfer to utility) model
catalogueThis update fixes an issue with the display size of plots.
</td>
<td style="text-align:left;">
<a href="https://github.com/ready4-dev/ttu_mdl_ctlg" style="     ">Dev</a>,
<a href="https://doi.org/10.5281/zenodo.5936870" style="     ">Archive</a>
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

ready4 programs are currently minimally documented, typically in the form as notes contained in a README file in the source code bundle.

