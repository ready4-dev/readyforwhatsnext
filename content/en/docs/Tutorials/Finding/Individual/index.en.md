---
title: "Finding specific modules and sub-modules"
linkTitle: "Modules"
date: "2024-01-25"
description: "How to find individual readyforwhatsnext modules and sub-modules."
weight: 2
categories: 
- Documentation
tags: 
- Model
- Model - modules
- Model - sub-modules
output: hugodown::md_document
rmd_hash: 03a7b3817548f57d
html_dependencies:
- <script src="kePrint-0.0.1/kePrint.js"></script>
- <link href="lightable-0.0.1/lightable.css" rel="stylesheet" />

---

{{% pageinfo %}} This below section renders a vignette article from the ready4 library. You can use the following links to:

-   [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4/articles/V_05.html)
-   [view the source file](https://github.com/ready4-dev/ready4/blob/main/vignettes/V_05.Rmd) from that article, and;
-   [edit its contents](https://github.com/ready4-dev/ready4/edit/main/vignettes/V_05.Rmd) (requires a GitHub account). {{% /pageinfo %}}

<div class="highlight">

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ready4-dev.github.io/ready4/'>ready4</a></span><span class='o'>)</span></span></code></pre>

</div>

## Motivation

When considering whether to use model modules, model developers and users will often want to see examples of each module's application The `ready4` package includes tools to allow a modelling project's maintainers to perform automated searches for vignette examples of model modules and to output tabular summaries of these modules that are suitable for inclusion on documentation website pages.

## Implementation

Details of how to search for themed collections of modules is described in [another article](https://www.ready4-dev.com/docs/software/libraries/types/module/). A table itemising individual model modules and sub-modules authored with `ready4` can be generated using `make_modules_tb`. This function scrapes relevant data from the websites of module libraries that have been developed within a specified project's GitHub organisation and may take a couple of minutes to execute. In this example, we are going to examine modules from a [youth mental health model](https://www.ready4-dev.com/docs/model/).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>modules_tb</span> <span class='o'>&lt;-</span>  <span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/make_modules_tb.html'>make_modules_tb</a></span><span class='o'>(</span>gh_repo_1L_chr <span class='o'>=</span> <span class='s'>"ready4-dev/ready4"</span><span class='o'>)</span></span></code></pre>

</div>

A slightly quicker method to achieve a similar result is to use the `get_modules_tb` function. This function retrieves an archived version (and therefore potentially less up to date) of the modules summary table.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># Not run</span></span>
<span><span class='c'># modules_tb &lt;- get_modules_tb(gh_repo_1L_chr = "ready4-dev/ready4")</span></span></code></pre>

</div>

The `modules_tb` object itemises both ready4 modules (which always use R's "S4" class type) and sub-modules ("S3" class type). To display a HTML summary of just ready4 modules, you can use the `print_modules` function.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_modules.html'>print_modules</a></span><span class='o'>(</span><span class='nv'>modules_tb</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"S4"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Examples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusACT-class.html" style="     ">AusACT</a>
</td>
<td style="text-align:left;">
Meta data for processing ACT population projections
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusHeadspace-class.html" style="     ">AusHeadspace</a>
</td>
<td style="text-align:left;">
Meta data for constructing Headspace Centre geometries
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusLookup-class.html" style="     ">AusLookup</a>
</td>
<td style="text-align:left;">
Lookup tables for Australian geometry and spatial attribute data
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusOrygen-class.html" style="     ">AusOrygen</a>
</td>
<td style="text-align:left;">
Meta data for constructing OYH Specialist Mental Health Catchment geometries
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusProjections-class.html" style="     ">AusProjections</a>
</td>
<td style="text-align:left;">
Meta data for constructing custom Australian population projections boundary
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/aus/reference/AusTasmania-class.html" style="     ">AusTasmania</a>
</td>
<td style="text-align:left;">
Meta data for processing Tasmanian population projections
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlyCorrespondences-class.html" style="     ">CostlyCorrespondences</a>
</td>
<td style="text-align:left;">
Collection of input, standards definition and results datasets for projects to generate standardised costing datasets
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/costly/articles/V_02.html" style="     ">2</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlyCountries-class.html" style="     ">CostlyCountries</a>
</td>
<td style="text-align:left;">
Collection of input, standards definition and results datasets for projects to generate standardised country data for use in costing datasets
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/costly/articles/V_02.html" style="     ">2</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlyCurrencies-class.html" style="     ">CostlyCurrencies</a>
</td>
<td style="text-align:left;">
Collection of input, standards definition and results datasets for projects to generate standardised currency data for use in costing datasets
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/articles/V_02.html" style="     ">2</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlySeed-class.html" style="     ">CostlySeed</a>
</td>
<td style="text-align:left;">
Original (non-standardised) dataset (and metadata)
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/costly/articles/V_02.html" style="     ">2</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlySource-class.html" style="     ">CostlySource</a>
</td>
<td style="text-align:left;">
Input dataset (and metadata) for generating standardised costing datasets
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/reference/CostlyStandards-class.html" style="     ">CostlyStandards</a>
</td>
<td style="text-align:left;">
Dataset (and metadata) defining the allowable values of specified variables
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/costly/articles/V_01.html" style="     ">1</a>, <a href="https://ready4-dev.github.io/costly/articles/V_02.html" style="     ">2</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/reference/ScorzAqol6-class.html" style="     ">ScorzAqol6</a>
</td>
<td style="text-align:left;">
A dataset and metadata to support implementation of an AQoL-6D scoring algorithm
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/reference/ScorzAqol6Adol-class.html" style="     ">ScorzAqol6Adol</a>
</td>
<td style="text-align:left;">
A dataset and metadata to support implementation of a scoring algorithm for the adolescent version of AQoL-6D
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/articles/V_01.html" style="     ">3</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/reference/ScorzAqol6Adult-class.html" style="     ">ScorzAqol6Adult</a>
</td>
<td style="text-align:left;">
A dataset and metadata to support implementation of a scoring algorithm for the adult version of AQoL-6D
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/reference/ScorzEuroQol5-class.html" style="     ">ScorzEuroQol5</a>
</td>
<td style="text-align:left;">
A dataset and metadata to support implementation of an EQ-5D scoring algorithm
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/articles/V_02.html" style="     ">4</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/scorz/reference/ScorzProfile-class.html" style="     ">ScorzProfile</a>
</td>
<td style="text-align:left;">
A dataset to be scored, its associated metadata and details of the scoring instrument
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificConverter-class.html" style="     ">SpecificConverter</a>
</td>
<td style="text-align:left;">
Container for seed objects used for creating SpecificModels modules
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/articles/V_01.html" style="     ">5</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificFixed-class.html" style="     ">SpecificFixed</a>
</td>
<td style="text-align:left;">
Modelling project dataset, input parameters and complete fixed models results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificInitiator-class.html" style="     ">SpecificInitiator</a>
</td>
<td style="text-align:left;">
Modelling project dataset, input parameters and empty results placeholder
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificMixed-class.html" style="     ">SpecificMixed</a>
</td>
<td style="text-align:left;">
Modelling project dataset, input parameters and complete mixed models results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificModels-class.html" style="     ">SpecificModels</a>
</td>
<td style="text-align:left;">
Modelling project dataset, input parameters and model comparison results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificParameters-class.html" style="     ">SpecificParameters</a>
</td>
<td style="text-align:left;">
Input parameters that specify candidate models to be explored
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificPredictors-class.html" style="     ">SpecificPredictors</a>
</td>
<td style="text-align:left;">
Modelling project dataset, input parameters and predictor comparison results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificPrivate-class.html" style="     ">SpecificPrivate</a>
</td>
<td style="text-align:left;">
Analysis outputs not intended for public dissemination
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificProject-class.html" style="     ">SpecificProject</a>
</td>
<td style="text-align:left;">
Modelling project dataset, parameters and results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificResults-class.html" style="     ">SpecificResults</a>
</td>
<td style="text-align:left;">
Analysis results
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificShareable-class.html" style="     ">SpecificShareable</a>
</td>
<td style="text-align:left;">
Analysis outputs intended for public dissemination
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/SpecificSynopsis-class.html" style="     ">SpecificSynopsis</a>
</td>
<td style="text-align:left;">
Input, Output and Authorship Data For Generating Reports
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/TTU/reference/TTUProject-class.html" style="     ">TTUProject</a>
</td>
<td style="text-align:left;">
Input And Output Data For Undertaking and Reporting Utility Mapping Studies
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/TTU/articles/V_01.html" style="     ">6</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/TTU/reference/TTUReports-class.html" style="     ">TTUReports</a>
</td>
<td style="text-align:left;">
Metadata to produce utility mapping study reports
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/TTU/reference/TTUSynopsis-class.html" style="     ">TTUSynopsis</a>
</td>
<td style="text-align:left;">
Input, Output and Authorship Data For Generating Utility Mapping Study Reports
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityArguments-class.html" style="     ">VicinityArguments</a>
</td>
<td style="text-align:left;">
Function arguments for constructing a spatial object
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityLocal-class.html" style="     ">VicinityLocal</a>
</td>
<td style="text-align:left;">
Object defining data to be saved in local directory
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityLocalProcessed-class.html" style="     ">VicinityLocalProcessed</a>
</td>
<td style="text-align:left;">
Object defining data to be saved in local directory in a processed (R) format
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityLocalRaw-class.html" style="     ">VicinityLocalRaw</a>
</td>
<td style="text-align:left;">
Object defining data to be saved in local directory in a raw (unprocessed) format
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityLookup-class.html" style="     ">VicinityLookup</a>
</td>
<td style="text-align:left;">
Look up tables for spatiotemporal data
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityMacro-class.html" style="     ">VicinityMacro</a>
</td>
<td style="text-align:left;">
Macro level context
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityMesoArea-class.html" style="     ">VicinityMesoArea</a>
</td>
<td style="text-align:left;">
Meso level context - area
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityMesoRegion-class.html" style="     ">VicinityMesoRegion</a>
</td>
<td style="text-align:left;">
Meso level context - region
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityMicro-class.html" style="     ">VicinityMicro</a>
</td>
<td style="text-align:left;">
Micro level context
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinityProfile-class.html" style="     ">VicinityProfile</a>
</td>
<td style="text-align:left;">
Information to create a profiled area object
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/VicinitySpaceTime-class.html" style="     ">VicinitySpaceTime</a>
</td>
<td style="text-align:left;">
Spatiotemporal environment
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/YouthvarsDescriptives-class.html" style="     ">YouthvarsDescriptives</a>
</td>
<td style="text-align:left;">
Metadata about descriptive statistics to be generated
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/YouthvarsProfile-class.html" style="     ">YouthvarsProfile</a>
</td>
<td style="text-align:left;">
A dataset and its associated dictionary, descriptive statistics and metadata
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_02.html" style="     ">8</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/YouthvarsSeries-class.html" style="     ">YouthvarsSeries</a>
</td>
<td style="text-align:left;">
A longitudinal dataset and its associated dictionary, descriptive statistics and metadata
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_02.html" style="     ">8</a>
</td>
</tr>
</tbody>
</table>

</div>

You can use the same function to display only ready4 sub-modules.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ready4-dev.github.io/ready4/reference/print_modules.html'>print_modules</a></span><span class='o'>(</span><span class='nv'>modules_tb</span>, what_1L_chr <span class='o'>=</span> <span class='s'>"S3"</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<table class="table table-hover table-condensed" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Examples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/specific_models.html" style="     ">specific_models</a>
</td>
<td style="text-align:left;">
Candidate models lookup table
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/specific/reference/specific_predictors.html" style="     ">specific_predictors</a>
</td>
<td style="text-align:left;">
Candidate predictors lookup table
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_abbreviations.html" style="     ">vicinity_abbreviations</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table for spatial data abbreviations
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_identifiers.html" style="     ">vicinity_identifiers</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table of unique feature identifiers used for different spatial objects
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_mapes.html" style="     ">vicinity_mapes</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object that stores spatial simulation parameters relating to Mean Absolute Prediction Errors
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_parameters.html" style="     ">vicinity_parameters</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object that stores simulation structural parameters relating to the spatial environment
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_points.html" style="     ">vicinity_points</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table of the longitude and latitude cordinates of sites of services / homes
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_processed.html" style="     ">vicinity_processed</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table of meta-data for spatial data packs (imported and pre-processed data)
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_raw.html" style="     ">vicinity_raw</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table of metadata about raw (un-processed) spatial data to import
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_resolutions.html" style="     ">vicinity_resolutions</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table of the relative resolutions of different spatial objects
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_templates.html" style="     ">vicinity_templates</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object lookup table for base file used in creation of certain spatial objects
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/vicinity/reference/vicinity_values.html" style="     ">vicinity_values</a>
</td>
<td style="text-align:left;">
ready4 S3 class for tibble object that stores simulation parameter values for each iteration
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_aqol6d_adol.html" style="     ">youthvars_aqol6d_adol</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Assessment of Quality of Life Six Dimension Health Utility - Adolescent Version (AQoL6d Adolescent)
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_bads.html" style="     ">youthvars_bads</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Behavioural Activation for Depression Scale (BADS) scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_chu9d_adolaus.html" style="     ">youthvars_chu9d_adolaus</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Child Health Utility Nine Dimension Health Utility - Australian Adolescent Scoring (CHU-9D Australian Adolescent)
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_gad7.html" style="     ">youthvars_gad7</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Generalised Anxiety Disorder Scale (GAD-7) scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_k10.html" style="     ">youthvars_k10</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Kessler Psychological Distress Scale (K10) - US Scoring System scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_k10_aus.html" style="     ">youthvars_k10_aus</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Kessler Psychological Distress Scale (K10) - Australian Scoring System scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_k6.html" style="     ">youthvars_k6</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Kessler Psychological Distress Scale (K6) - US Scoring System scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_k6_aus.html" style="     ">youthvars_k6_aus</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class)for Kessler Psychological Distress Scale (K6) - Australian Scoring System scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_oasis.html" style="     ">youthvars_oasis</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Overall Anxiety Severity and Impairment Scale (OASIS) scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_phq9.html" style="     ">youthvars_phq9</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Patient Health Questionnaire (PHQ-9) scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_scared.html" style="     ">youthvars_scared</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Screen for Child Anxiety Related Disorders (SCARED) scores
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
<tr>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/reference/youthvars_sofas.html" style="     ">youthvars_sofas</a>
</td>
<td style="text-align:left;">
youthvars ready4 sub-module (S3 class) for Social and Occupational Functioning Assessment Scale (SOFAS)
</td>
<td style="text-align:left;">
<a href="https://ready4-dev.github.io/youthvars/articles/V_01.html" style="     ">7</a>
</td>
</tr>
</tbody>
</table>

</div>

