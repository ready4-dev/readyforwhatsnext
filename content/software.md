---
aliases:
- software
author: Matthew Hamilton
date: "2021-02-24"
description: About our open source software.
title: Software
---

To help ensure the models we develop are as transparent as possible and to make their algorithms as useful to others as possible, all our software is free and open-source. Our [Libraries](/toolkits/) are currently all written in R and our [Programs](/programs/) are principally written in R Markdown.

## Versions, Storage and Installation
We use multiple types of online repository for hosting our software and related documentation and metadata.

- Archive: Permanent, uniquely identified (with DOI) archive copies of those versions of software items that we have issued as “releases” (for example, versions of the software at the time the analysis was undertaken) are stored within the [ready4 Zenodo community](https://zenodo.org/communities/ready4). Metadata on software we have archived on Zenodo are typically indexed by and retrievable from [OpenAire](https://explore.openaire.eu/). 

- Development: Impermanent (as these repositories can be moved or deleted at any time) copies of all versions of our software items over their entire development history (including the most up to date development version) are stored in the [ready4 GitHub organisation](https://github.com/ready4-dev). 

- Production: We have yet to make production releases of our software, which we intend to primarily submit to [CRAN](https://cran.r-project.org/). Unless and until a software item is submitted to a production code repository like CRAN, the recommended platform from which to install our software is that software's GitHub repository.

- Documentation: All our code libraries have a documentation website, the URL of which typically takes the form of `https://ready4-dev.github.io/PACKAGE_NAME` (for example https://ready4-dev.github.io/ready4). Documentation for programs is typically contained in the program bundle, either as a PDF render of the RMarkdown soruce file (for self-contained programs) or as notes contained in a README file (for sub-routines).

## Citing and re-using our software
Each archived version of any software item we have released has its own unique Digital Object Identifier (DOI). Citing a specific version therefore requires the version specific DOI plus text such as “version 0.0.9.3”.  Each software item also has a generic DOI that can be used to refer to all versions of the software. Note that, if clicked on, the generic DOI will resolve to the latest archived version.

To make it easier to cite our software, each software item includes a CITATION.cff file. Inclusion of this file means that the repositories storing our software can generate appropriate citations in the format of most relevance to you. Currently:
 - Zenodo provides a free text field under the heading “Cite as” which enables you to generate a wide range of citation manager and journal specific citation outputs. There is also an “Export” tool that will generate citation metadata in multiple output formats;
 -	OpenAire Explore has a “Cite this software” button that allows you to generate a citation in multiple journal formats or to download BibTeX or RIS files;
 - Github repositories have a “Cite this repository” button that can generate both BibTeX and APA output as well as link to the Citation.cff file.

Additionally, with have included an additional CITATION file in each of our R libraries so that you can generate a citation from within an R session using the `citation` function (for example: `citation("ready4")`.

## Using and extending our software
You are encouraged to make as widespread use of our software, including the creation of derivative works, as you see fit, so long as it is consistent with each item's license. Our software is typically licensed under [GPL-3](https://ready4-dev.github.io/ready4/LICENSE.html), a permissive open-source licensing regime.