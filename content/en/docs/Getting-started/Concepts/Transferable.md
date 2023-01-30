---
title: "Transferability"
linkTitle: "Transferability"
weight: 25
categories: 
- Documentation
tags:
- Project
- Project - concepts
description: >
  Some models have the potential to be used in multiple contexts - but will often need adaptation for this to be appropriate.
---

It is common for discussions of scientific studies to consider the extent to which findings can be **generalised** (e.g. if a well conducted study concludes with high confidence that an intervention is cost-effective in Australia, is it valid to infer that it is likely to be cost-effective in the United Kingdom?). However, we are more interested in the **transferability** of computational models (e.g. the extent to which the data-structures and algorithms from a computational model developed for an Australian context can be used to explore similar topics in the United Kingdom). Our usage of the term "transferring" (and by extension "transferability", "transferable", "transfers") reflects this motivation.

### Transferring - our meaning 
Adapting a computational model, in whole or in part, to extend the types of data and/or research questions to which it can be applied. The new types of data will possess some differences in structure and / or concepts from that to which the computational model had previously been applied and these differences may be why research questions need to be reformulated.

When we use the term transferring, we are typically referring to either (a) authoring or (b) using on of the following:

1. An analysis [program](/docs/getting-started/software/executables/programs/) (or [sub-routine](/docs/getting-started/software/executables/subroutines/)) that has been adapted from an [executable](/docs/getting-started/software/executables/) from another study to account for differences in the input data / research question. 

2. [Inheriting data-structures and algorithms](/docs/framework/implementation/paradigm/object-oriented/) that selectively re-use, discard and replace elements of a study's computational model based on an alternative use-case.

3. (Multi-purpose) function [libraries](/docs/getting-started/software/libraries/) that have been created by [decomposing a study's (single purpose) analysis program](/docs/framework/implementation/paradigm/functional/).


### Examples
The [scorz module library](https://ready4-dev.github.io/scorz/index.html) was originally developed to provide an R implementation of algorithms in other languages for scoring adolescent AQoL-6D health utility as part of a [utility mapping study](https://www.medrxiv.org/content/10.1101/2021.07.07.21260129v3) (which also used the analysis program mentioned above). Examples of all three approaches mentioned in the previous section can be seen by examining the documentation and source code of the scorz library: 

1. Two vignette programs from the scorz library website score different utility instruments. The first program scores [adolescent AQoL-6D](https://ready4-dev.github.io/scorz/articles/V_01.html) health utility and acts as a template for the second, which has been modified to score [EQ-5D](https://ready4-dev.github.io/scorz/articles/V_02.html) health utility.

2. Inspecting those example programs shows that one of the key adaptations in the EQ-5D program is to use the [ScorzEuroQol5](https://ready4-dev.github.io/scorz/reference/ScorzEuroQol5-class.html) [module](/docs/getting-started/concepts/module/) instead of the [ScorzAqol6Adol](https://ready4-dev.github.io/scorz/reference/ScorzAqol6Adol-class.html) module. Both of these modules inherit from  [ScorzProfile](https://ready4-dev.github.io/scorz/reference/ScorzProfile-class.html). This arrangement means that all three modules share some features (in terms of both structure and algorithms) but selectively differ (e.g. aspects that are necessarily different for scoring different instruments).

3. The algorithms attached to each module from the scorz library are principally implemented by functions ([the source code for which can be viewed here](https://github.com/ready4-dev/scorz/tree/main/data-raw/fns)) that were created when decomposing an early draft of the above mentioned study algorithm. These functions are called by module methods ([source code viewable here](https://github.com/ready4-dev/scorz/blob/main/data-raw/s4_fns/renew.R)).