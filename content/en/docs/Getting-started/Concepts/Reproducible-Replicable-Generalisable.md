---
title: "Reproducible, Replicable and Generalisable"
linkTitle: "Reproducible science"
weight: 24
categories: 
- Documentation
tags:
- Project
- Project - concepts
description: >
  Some core concepts relating to reproducible research have multiple conflicting definitions - this is how we use them.
---

Although there is widespread support from the scientific community on the importance of reproducible research, the definition of key terms such as reproducibility, replicability and generalisability across disciplines and methodologies (e.g. the extent to which computational modelling is used). In some cases, entirely different terms (e.g. repeatability) are preferred. The meanings we intend when using these terms are listed below.

## Reproduction and Replication
The distinctions we make between reproduction and replication have been guided by the approach outlined in a report by the [National Academies of Sciences, Engineering and Medicine](https://nap.nationalacademies.org/catalog/25303/reproducibility-and-replicability-in-science). However, we have adapted their definitions slightly as the meanings in that report were framed in terms of study findings / outcomes, whereas our usage relates more to intended objectives when deploying tools.

### Meanings
#### Reproduction
Applying the same [analysis](/docs/analyses/) code to the same input [data](/docs/datasets/) with the expectation of generating identical outputs (with the exception of trivial artefacts like datestamps for when analysis reports were produced).

#### Replication
Applying analysis code used in a study to new input data. The analysis code is reused with only minimal edits that are necessary to account for differences in input data paths and variable names and to study metadata (e.g. investigator names, sample descriptions). The new data can be real or fake, but will include the same structure and concepts / measures as those found in the original study's dataset. If the new data is a sample from the same population as the original study, then the expectation when undertaking replications is for results across studies to be broadly similar. 

### Examples
[Examples of both reproduction and replication code](/docs/analyses/replication-code/) are available. When publishing analysis code we try to adopt (there are exceptions) the following rules of thumb: 

1. If the data required to re-run a study analysis are publicly available (or declared by the analysis program itself), then we publish the code as a reproduction program (e.g. [a program for creating a synthetic population](/docs/analyses/replication-code/make-fakes/clinical-primary/)).

2. If the data required to re-run a study analysis are not publicly available, we publish the replication version of the code. The replication version of the code may be configured to ingest a synthetic (fake) representation of the study dataset as with this [utility mapping replication program](/docs/analyses/replication-code/map-utility/ttu_lng_aqol6d_csp/). Details of the (minimal) steps required to revert the replication code to a version that can be used for reproduction purposes are typically embedded within the program itself.

## Generalised
It is common for discussions of scientific studies in mental health to consider the extent to which **findings** can be generalised (e.g. if a well conducted study concludes with high confidence that an intervention is cost-effective in Australia, is it valid to infer that it is likely to be cost-effective in the United Kingdom?). However, we are more interested in the generalisability of computational models (e.g. the extent to which the data-structures and algorithms expressed in computer code can be used to explore similar topics in both Australia and the United Kingdom). Our usage of the term "generalised" (and by extention "generalisability") reflects this motivation.

### Meaning 
Adapting the computational model, in whole or in part, from one study to new data and/or to new research questions. The new data will possess some differences in structure and / or concepts / measures and these differences may be why research questions need to be reformulated.

When we use the term generalised, we are typically referring to either (a) authoring or (b) using on of the following:

1. An analysis [program](/docs/getting-started/software/executables/programs/) (or [sub-routine](/docs/getting-started/software/executables/subroutines/)) that has been adapted from a template [executable](/docs/getting-started/software/executables/) from another study to account for differences in the input data / research question. 

2. Creating [inheriting data-structures and algorithms](/docs/framework/implementation/paradigm/object-oriented/) to selectively re-use, discard and replace elements of a study's computational model based on relevance to another study's requirements.

3. (Multi-purpose) function [libraries](/docs/getting-started/software/libraries/) that have been created by [decomposing a study's (single purpose) analysis program](/docs/framework/implementation/paradigm/functional/).


### Examples
Examples of all three approaches can be seen by examining the documentation and source code of the [scorz module library](https://ready4-dev.github.io/scorz/index.html). The scorz library was originally developed to provide an R implementation of algorithms in other languages for scoring adolescent AQoL-6D health utility as part of a [utility mapping study](https://www.medrxiv.org/content/10.1101/2021.07.07.21260129v3) (which also used the analysis program mentioned above). 

1. Generalising an analysis program to account for differences in input data / research question can be illustrated by comparing two programs from the scorz library website - the first program scores [adolescent AQoL-6D](https://ready4-dev.github.io/scorz/articles/V_01.html) health utility and the second has been modified to score [EQ-5D](https://ready4-dev.github.io/scorz/articles/V_02.html) health utility.

2. Inspecting those example programs shows that one of the key adaptations in the EQ-5D program is to use the [ScorzEuroQol5](https://ready4-dev.github.io/scorz/reference/ScorzEuroQol5-class.html) [module](docs/getting-started/concepts/module/) instead of the [ScorzAqol6Adol](https://ready4-dev.github.io/scorz/reference/ScorzAqol6Adol-class.html) module. Both of these inherit from another module - [ScorzProfile](https://ready4-dev.github.io/scorz/reference/ScorzProfile-class.html). This arrangement means that all three modules share some features (in terms of both structure and parts of algorithms) but selectively differ (e.g. aspects that are necessarily different for scoring different instruments).

3. The algorithms attached to each module from the scorz library are principally implemented by [functions (that can be viewed here)](https://github.com/ready4-dev/scorz/tree/main/data-raw/fns) that were created when decomposing an early draft of the above mentioned study algorithm.