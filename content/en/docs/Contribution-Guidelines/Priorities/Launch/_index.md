---
title: "Priority 1: Launch ready4 Minimum Viable Product (MVP)"
linkTitle: "Launch"
date: 2017-01-05
weight: 301
tags:
- Project
- Project - contributions
- Project - contributions (priorities)
categories:
- Documentation
description: >
  We want to give potential [users](/docs/getting-started/users/) confidence that they can appropriately apply ready4 to their decision problems by bringing all our existing [development release](/docs/software/status/development-releases/) and [unreleased](/docs/software/status/unreleased/) software to [production release](/docs/software/status/production-releases/) status.
---


## Why?
All our [software](/docs/software/), regardless of [status](/docs/software/status/) is supplied [without any warranty](/docs/software/terms/disclaimer/). However, our views about whether an item of software is potentially appropriate for others to use in undertaking real world [analyses](/docs/model/analyses/) can be inferred from its release status. If it is not a production release, we probably believe that it needs more development and testing and better [documentation](/docs/software/libraries/documentation/) before it can be used for any purpose other than the specific studies in which we have already applied it. Partly for this reason, it is unlikely that any item of our software will be widely adopted until it is available as a production release. We also cannot meaningfully track uptake of our software until it becomes available in a dedicated production release [repository](/docs/software/repositories/). We need a critical mass of [modules](/docs/getting-started/concepts/module/) available as production releases so that they can be combined to model moderately complex systems.

## What?
By bringing all our [current development version](docs/getting-started/software/libraries/types/) and [pipeline](/docs/model/modules/pipeline/) libraries to production release, we aim to launch the **ready4 Minimum Viable Product (MVP)**. The MVP will comprise our [software framework](/docs/framework/) plus an initial skeleton of production ready modules for modelling [people](/docs/model/modules/using-modules/people/), [places](/docs/model/modules/using-modules/places/), [platforms](/docs/model/modules/using-modules/platforms/) and [programs](/docs/model/modules/using-modules/programs/). 

The most important types of help we need with achieving this goal are [funding](/docs/contribution-guidelines/contribution-types/funding/),
[code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/) and [advice](/docs/contribution-guidelines/contribution-types/advisory/).

## How?
The main tasks to be completed to bring all of our existing [code libraries](/docs/software/libraries/) to production releases is as follows:

1. *(For unreleased software)* Address all issues preventing public release of code repositories (e.g. fixing errors preventing core functions working, removing all traces of potentially confidential artefacts from all versions/branches of repository, etc.).

2. *(For code libraries are implemented using only the [functional programming](/docs/framework/implementation/paradigm/functional/) paradigm)* [Author](/docs/framework/use/authoring-modules/) and test new modules.

3. Write / update unit tests (tests of individual functions / modules for multiple potential uses / inputs that will be automatically run every time a new version of a library is pushed to the main branch of its development release repository).

4. Enhance the documentation that is automatically authored by algorithms from our [model authoring tools](/docs/software/libraries/installation/authoring-tools/code-development/). This will involve some or all of: 

- minor modifications of function names / arguments / code;

- updating the [taxonomies datasets used in the documentation writing algorithm](/docs/framework/use/authoring-modules/authoring-algorithms/); and/or 

- updating the documentation authoring algorithms (within the [ready4fun](https://ready4-dev.github.io/ready4fun/) and [ready4class](https://ready4-dev.github.io/ready4class/) packages).

5. Adding human authored documentation for the modules contained in each library.

6. *(For some libraries)* Adding a [user-interface](/docs/software/user-interfaces/).

## When?
Our production releases will be submitted to the Comprehensive R Archive Network (CRAN). CRAN does not allow for submitted R packages to depend on development version R packages, so the [dependency network](/docs/software/libraries/dependencies/) of our code-libraries shapes the sequence in which we bring them to production releases.

The planned sequence for bringing current development release code libraries to production releases is: 

1. Three of the six [framework libraries](/docs/software/libraries/types/framework/) - the [ready4](https://ready4-dev.github.io/ready4/) foundation followed by the [ready4show](https://ready4-dev.github.io/ready4show/) and [ready4use](https://ready4-dev.github.io/ready4use/) authoring tools.

2. The nine [module libraries](/docs/software/libraries/types/module/) that are sufficiently developed to have been used in [real world scientific studies or policy analyses](/docs/examples/), in the following order: [youthvars](https://ready4-dev.github.io/youthvars/), [scorz](https://ready4-dev.github.io/scorz/), [specific](https://ready4-dev.github.io/specific/), [TTU](https://ready4-dev.github.io/TTU/), [youthu](https://ready4-dev.github.io/youthu/), [mychoice](https://ready4-dev.github.io/mychoice/), [vicinity](https://ready4-dev.github.io/vicinity/), [aus](https://ready4-dev.github.io/aus/) and [heterodox](https://ready4-dev.github.io/heterodox/). 

3. The very early stage [bimp](https://ready4-dev.github.io/bimp/) library from the [modelling programs pipeline](/docs/model/modules/pipeline/pipeline-programs/), 

4. The three remaining computational model authoring tools framework libraries, starting with [ready4fun](https://ready4-dev.github.io/ready4fun/), then [ready4class](https://ready4-dev.github.io/ready4class/) and finally [ready4pack](https://ready4-dev.github.io/ready4pack/).

The planned sequence for bringing unreleased code first to development releases and then to production releases is:

1. The two development module libraries from the [modelling places pipeline](/docs/model/modules/pipeline/pipeline-places/) (the prevalence predictor and user interface libraries).

2. The two module libraries from the [modelling people pipeline](/docs/model/modules/pipeline/pipeline-people/) (the synthetic household creation library and that agent based modelling library).

3. The three module libraries from the [modelling platforms pipeline](/docs/model/modules/pipeline/pipeline-platforms/) (the primary mental health service discrete event simulation, followed by the early psychosis cohort model, followed by the service system eligibility and referral policy optimisation model).

How quickly we can launch production releases of all our code depends on how much and [what type of help](/docs/contribution-guidelines/contribution-types/) we get. Working within our current resources we expect the first of the 23 libraries listed to be released the first half of 2024 and the last during late 2026. With your help this release schedule can be sped up.
