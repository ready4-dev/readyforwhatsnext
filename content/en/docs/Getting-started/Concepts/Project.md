---
title: "Modelling project"
linkTitle: "Modelling project"
weight: 24
categories: 
- Documentation
tags:
- Modelling projects
- Project
- Project - concepts
description: >
  A ready4 modelling project develops a computational model, adds data and runs analyses.
---

As a [complex, collaborative and long-term undertaking](/docs/getting-started/motivation/), it is not feasible for ready4 to be financed by a single funder or progressed as a single project. Instead, our mode of development is via multiple independent modelling projects, each with their own project governance and funding, but which adopt a common [framework](/docs/framework/).

A ready4 modelling project will involve the three steps of:

- Developing and validating a [computational model](../model);

- Adding context-specific [data](/docs/datasets/) to that computational model; and

- Applying the computational model to the supplied data to undertake [analyses](/docs/analyses/).

### Step 1: Develop model
Each project's computational model is constructed by adopting one or more of the following strategies:

- selecting a subset of [existing ready4 modules](/docs/model/finding-modules/) and [using them](/docs/model/using-modules/) in unmodified form;
- selecting a subset of existing ready4 modules and [contributing code edits](/docs/contribution-guidelines/contribution-types/code/) to these modules to add desired functionality;
- selecting a subset of existing ready4 modules and using them as templates from which to author new [inheriting modules](/docs/framework/implementation/paradigm/#inheritence) (which can be code contributions to an existing [module library](/docs/getting-started/software/libraries/types/module/) or [distributed as part of a new library](/docs/model/authoring-modules/packaging-modules/)); and/or
- [authoring new ready4 modules](/docs/model/authoring-modules/) (most likely to be distributed in new code libraries). 

As part of the validation and verification process for all new and derived modules, tests should be defined, bundled as part of the relevant module libraries and rerun every time these libraries are edited.

### Step 2: Add data
By data we typically mean digitally stored information, principally relating to model parameter values, that can be added to the ready4 computational model to tailor it to a specific decision context (e.g. a particular population / jurisdiction / service / intervention) and set of underpinning beliefs (e.g. preferred evidence sources). Data for a ready4 modelling project will be from one or both of the following options:

- [finding and using existing open access data](/docs/datasets/finding-data/) from other ready4 projects;
- supplying new project specific data, [appropriately describing these data](/docs/datasets/authoring-data/label-data/) and (for non-confidential records) [sharing these data publicly](/docs/datasets/authoring-data/share-data/).


### Step 3: Run analyses
ready4 project analyses apply algorithms contained in ready4 modules to supplied data to generate insight and can be implemented by:

- adapting existing [replication programs](/docs/analyses/replication-code/); 
- [authoring new analysis programs](/docs/analyses/authoring-analyses/); and / or
- developing a [user-interface](/docs/analyses/decision-aids/) to allow non-technical users to run custom analyses.

When reporting analyses, using a [reporting template](/docs/analyses/reporting-templates/) can be useful.

