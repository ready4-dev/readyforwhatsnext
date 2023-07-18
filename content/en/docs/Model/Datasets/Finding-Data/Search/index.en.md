---
title: "Search open access data collections"
linkTitle: "Search"
date: "2023-07-11"
description: "Online open access data repositories are the preferred storage locations for ready4 model datasets."
weight: 91
categories: 
- Documentation
tags: 
- Data
- Data - search
- Framework
- Framework - foundation
- Repositories
- Repositories - data
- Software
- Software - libraries
- Software - libraries (ready4)
- Status
- Status - development
output: hugodown::md_document
rmd_hash: a5380ade891933a0
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span></code></pre>

</div>

The `make_datasets_tb` function from the ready4 library can be used to create a summary table of the open access datasets we curate in our [ready4 Dataverse Collection](https://dataverse.harvard.edu/dataverse/ready4).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/make_datasets_tb.html'>make_datasets_tb</a></span><span class='o'>(</span><span class='s'>"ready4"</span><span class='o'>)</span> <span class='o'>-&gt;</span> <span class='nv'>x</span></span></code></pre>

</div>

One way to inspect this information is to group contents by Dataverse Collections using the `print-data` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_data.html'>print_data</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>           by_dv_1L_lgl <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>kableExtra</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/kableExtra/man/scroll_box.html'>scroll_box</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Dataverse
</th>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Creator
</th>
<th style="text-align:left;">
Datasets
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/TTU"> TTU </a>
</td>
<td style="text-align:left;">
Transfer to Utility
</td>
<td style="text-align:left;">
A collection of transfer to utility datasets developed with the ready4 open science framework.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/DKDIB0" style="     ">1</a>, <a href="https://doi.org/10.7910/DVN/FDRUXH" style="     ">2</a>, <a href="https://doi.org/10.7910/DVN/N4NEHL" style="     ">3</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/fakes"> fakes </a>
</td>
<td style="text-align:left;">
Fake Data For Instruction And Illustration
</td>
<td style="text-align:left;">
Fake data used to illustrate toolkits developed with the ready4 open science framework.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/D74QMP" style="     ">4</a> , <a href="https://doi.org/10.7910/DVN/612HDC" style="     ">5</a> , <a href="https://doi.org/10.7910/DVN/HJXYKQ" style="     ">6</a> , <a href="https://doi.org/10.7910/DVN/W95KED" style="     ">7</a> , <a href="https://doi.org/10.7910/DVN/GW7ZKC" style="     ">8</a> , <a href="https://doi.org/10.7910/DVN/LYBMB0" style="     ">9</a> , <a href="https://doi.org/10.7910/DVN/3R5TS3" style="     ">10</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/firstbounce"> firstbounce </a>
</td>
<td style="text-align:left;">
First Bounce
</td>
<td style="text-align:left;">
A ready4 framework model of platforms. Aims to identify opportunities to improve the efficiency and equity of mental health services.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/ready4fw"> ready4fw </a>
</td>
<td style="text-align:left;">
ready4 Framework
</td>
<td style="text-align:left;">
A collection of datasets that support implementation of the ready4 framework for open science computational models of mental health systems.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/RIQTKK" style="     ">11</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/readyforwhatsnext"> readyforwhatsnext </a>
</td>
<td style="text-align:left;">
readyforwhatsnext
</td>
<td style="text-align:left;">
Data collections for the readyforwhatsnext mental health systems model.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/QBZFQV" style="     ">12</a>, <a href="https://doi.org/10.7910/DVN/JHSCDJ" style="     ">13</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/springtides"> springtides </a>
</td>
<td style="text-align:left;">
Springtides
</td>
<td style="text-align:left;">
A ready4 framework model of places. Synthesises geometry (boundary, coordinate) and spatial attribute (e.g. population counts, environmental characteristics, service identifier and model coefficients associated with areas) data.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/V3OKZV" style="     ">14</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://dataverse.harvard.edu/dataverse/springtolife"> springtolife </a>
</td>
<td style="text-align:left;">
Spring To Life
</td>
<td style="text-align:left;">
A ready4 framework model of people. Models the characteristics, behaviours, relationships and outcomes of groups of individuals relevant to policymakers and service planners aiming to improve population mental health.
</td>
<td style="text-align:left;">
Orygen
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/VGPIPS" style="     ">15</a>
</td>
</tr>
</tbody>
</table>

</div>

</div>

Alternatively, we can itemise individual Dataverse Datasets. When doing so, it makes sense to prepare separate views for toy datasets designed for instruction and real datasets appropriate for use in modelling.

Datasets appropriate for use in modelling projects can be returned by supplying the value "real" to the `what_1L_chr` argument of `print_data`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_data.html'>print_data</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>           what_1L_chr <span class='o'>=</span> <span class='s'>"real"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>kableExtra</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/kableExtra/man/scroll_box.html'>scroll_box</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Title
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Dataverse
</th>
<th style="text-align:left;">
DOI
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Transfer to AQoL-6D Utility Mapping Algorithms
</td>
<td style="text-align:left;">
Catalogues of models (and the programs that produced them) that can be used in conjunction with the youthu R package to predict AQoL-6D health utility (and thus, derive QALYs) from measures collected in youth mental health services.
</td>
<td style="text-align:left;">
TTU
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/DKDIB0">10.7910/DVN/DKDIB0</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Transfer to AQoL-6D From Measures Collected In Primary Youth Mental Health Services
</td>
<td style="text-align:left;">
This is a work in progress dataset to support the implementation and reporting of a study to map measures collected in Australian primary youth mental health services to AQoL-6D health utility.
</td>
<td style="text-align:left;">
TTU
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/FDRUXH">10.7910/DVN/FDRUXH</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Transfer to CHU-9D From Measures Collected In Primary Youth Mental Health Services
</td>
<td style="text-align:left;">
This is a work in progress dataset to support the implementation and reporting of a study to map measures collected in Australian primary youth mental health services to CHU-9D health utility
</td>
<td style="text-align:left;">
TTU
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/N4NEHL">10.7910/DVN/N4NEHL</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4 Framework Abbreviations and Definitions
</td>
<td style="text-align:left;">
This dataset contains resources that help ready4 Framework Developers adopt common standards and workflows.
</td>
<td style="text-align:left;">
ready4fw
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/RIQTKK">10.7910/DVN/RIQTKK</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
readyforwhatsnext posters
</td>
<td style="text-align:left;">
A collection of poster summaries about the readyforwhatsnext project and its outputs.
</td>
<td style="text-align:left;">
readyforwhatsnext
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/QBZFQV">10.7910/DVN/QBZFQV</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Australian demographic input parameters for Springtides model
</td>
<td style="text-align:left;">
Geometry, spatial attribute and metadata inputs for the demographic module of the readyforwhatsnext model. The demographic module is a systems dynamics spatial simulation of area demographic characteristics. The current version of the model is quite rudimentary and is designed to be extended by other models developped with the ready4 open science mental health modelling tools.
</td>
<td style="text-align:left;">
readyforwhatsnext
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/JHSCDJ">10.7910/DVN/JHSCDJ</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Springtides reports for Local Government Areas in the North West of Melbourne
</td>
<td style="text-align:left;">
This dataset is a collection of reports generated by a development version of the Springtides Model Of Places. Each report summarises prevalence projections for a specified mental disorder / mental health condition for a Local Government Area that is wholly or partially within the catchment area of the Orygen youth mental health service in North West Melbourne. As these reports were generated by a development version of the Springtides Model, these projections should be regarded as exploratory.
</td>
<td style="text-align:left;">
springtides
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/V3OKZV">10.7910/DVN/V3OKZV</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Modelling the online helpseeking choice of socially anxious young people
</td>
<td style="text-align:left;">

Models to predict the online helpseeking choices of socially anxious young people in Australia and replication code and documentation to implement the discrete choice experiment that generated the models.

All study outputs were created with the aid of the mychoice R package (<a href="https://ready4-dev.github.io/mychoice">https://ready4-dev.github.io/mychoice</a>).
</td>
<td style="text-align:left;">
springtolife
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/VGPIPS">10.7910/DVN/VGPIPS</a>
</td>
</tr>
</tbody>
</table>

</div>

</div>

To view toy datasets, instead supply the value "fakes".

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_data.html'>print_data</a></span><span class='o'>(</span><span class='nv'>x</span>,</span>
<span>           what_1L_chr <span class='o'>=</span> <span class='s'>"fakes"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span></span>
<span>  <span class='nf'>kableExtra</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/kableExtra/man/scroll_box.html'>scroll_box</a></span><span class='o'>(</span>width <span class='o'>=</span> <span class='s'>"100%"</span><span class='o'>)</span></span>
</code></pre>

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; ">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Title
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Dataverse
</th>
<th style="text-align:left;">
DOI
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TTU (Transfer to Utility) R package - AQoL-6D vignette output
</td>
<td style="text-align:left;">
This dataset has been generated from fake data as an instructional aid. It is not to be used to inform decision making.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/D74QMP">10.7910/DVN/D74QMP</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
TTU (Transfer to Utility) R package - EQ-5D vignette output
</td>
<td style="text-align:left;">
This dataset is provided as a teaching aid. It is the output of tools from the TTU R package, applied to a synthetic dataset (Fake Data) of psychological distress and psychological wellbeing. It is not to be used to support decision-making.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/612HDC">10.7910/DVN/612HDC</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Synthetic (fake) youth mental health datasets and data dictionaries
</td>
<td style="text-align:left;">
The datasets in this collection are entirely fake. They were developed principally to demonstrate the workings of a number of utility scoring and mapping algorithms. However, they may be of more general use to others. In some limited cases, some of the included files could be used in exploratory simulation based analyses. However, you should read the metadata descriptors for each file to inform yourself of the validity and limitations of each fake dataset. To open the RDS format files included in this dataset, the R package ready4use needs to be installed (see <a href="https://ready4-dev.github.io/ready4use/">https://ready4-dev.github.io/ready4use/</a> ). It is also recommended that you install the youthvars package ( <https://ready4-dev.github.io/youthvars/>) as this provides useful tools for inspecting and validating each dataset.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/HJXYKQ">10.7910/DVN/HJXYKQ</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
ready4use R package vignette output
</td>
<td style="text-align:left;">
This dataset is provided so that others can compare the output they generate when implementing vignette code with that generated by the authors.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/W95KED">10.7910/DVN/W95KED</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Specific R Package - AQoL-6D Vignette Output
</td>
<td style="text-align:left;">
This dataset is provided so that others can apply the algorithms we have developed, consistent with the principles of the ready4 open science framework for data synthesis and simulation in mental health.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/GW7ZKC">10.7910/DVN/GW7ZKC</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Synthetic (fake) dataset for hypothetical replication of study mapping psychological distress and functioning measures to AQoL-6D health utility
</td>
<td style="text-align:left;">
This dataset is comprised of fake data that has been created to illustrate the potential transfer of a study algorithm for creating utility mapping models to new data. Outputs in this dataset are for instructional purposes only and should not be used to inform decision making.
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/LYBMB0">10.7910/DVN/LYBMB0</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
Synthetic (fake) dataset for hypothetical replication of study mapping psychological distress and functioning measures to CHU-9D health utility
</td>
<td style="text-align:left;">
This dataset is comprised of fake data that has been created to illustrate the potential transfer of a study algorithm for creating CHU-9D utility mapping models to new data. Outputs in this dataset are for instructional purposes only and should not be used to inform decision making
</td>
<td style="text-align:left;">
fakes
</td>
<td style="text-align:left;">
<a href="https://doi.org/10.7910/DVN/3R5TS3">10.7910/DVN/3R5TS3</a>
</td>
</tr>
</tbody>
</table>

</div>

</div>

