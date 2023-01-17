---
title: "Priority 1: Launch production versions of existing software"
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
  We want all our existing [development release](/docs/getting-started/software/status/development-releases/) and [unreleased](/docs/getting-started/software/status/unreleased/) software to attain [production release](/docs/getting-started/software/status/production-releases/) status.
---


## Why?
All our [software](/docs/getting-started/software/), regardless of [status](/docs/getting-started/software/status/) is supplied [without any warranty](/docs/getting-started/software/terms/disclaimer/). However, our views about whether an item of software is potentially appropriate for others to use in undertaking real world [analyses](/docs/analyses/) is reflected in its release status. If it is not a production release, we probably believe that it needs more development and testing and better documentation before it can be used for any purpose other than the specific studies in which we have already applied it. Partly for this reason, it is unlikely that any item of our software will be widely adopted until it is available as a production release. We also cannot meaningfully track uptake of our software until it becomes available in a dedicated production release [repository](/docs/getting-started/software/repositories/).


## What?
The most important types of help we need with this priority area are [code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/) and [funding](/docs/contribution-guidelines/contribution-types/funding/).

## How?
The main tasks to be completed to bring all of our existing [code libraries](/docs/getting-started/software/libraries/) to production releases is as follows:

1. *(For unreleased software)* Address all issues preventing public release of code repositories (e.g. fixing errors preventing core functions working, removing all traces of potentially confidential artefacts from all versions/branches of repository, etc.).

2. *(For code libraries are implemented using only the [functional programming](/docs/framework/implementation/paradigm/functional/) paradigm)* [Author](/docs/model/authoring-modules/) and test new [modules](/docs/getting-started/concepts/module/).

3. Write / update unit tests (tests of individual functions / modules for multiple potential uses / inputs that will be automatically run every time a new version of a library is pushed to the main branch of its development release repository).

4. Enhance algorithm generated documentation. This will involve some or all of: 

- minor modifications of function names / arguments / code;

- updating the [taxonomies datasets used in the documentation writing algorithm](/docs/model/authoring-modules/authoring-algorithms/); and/or 

- updating the documentation authoring algorithms (within the [ready4fun](https://ready4-dev.github.io/ready4fun/) and [ready4class](https://ready4-dev.github.io/ready4class/) packages).

5. Adding human authored documentation for the modules contained in each library.

6. *(For some libraries)* Adding a [user-interface](/docs/getting-started/software/user-interfaces/).

## When?
Our production releases will be submitted to the Comprehensive R Archive Network (CRAN). CRAN does not allow for submitted R packages to depend on development version R packages, so the [dependency network](/docs/getting-started/software/libraries/dependencies/) of our code-libraries shapes the sequence in which we bring them to production releases.

The planned sequence for bringing current development release code libraries to production releases is: 

1. Three of the six [framework libraries](/docs/getting-started/software/libraries/types/framework/) - the [ready4](https://ready4-dev.github.io/ready4/) foundation followed by the [ready4show](https://ready4-dev.github.io/ready4show/) and [ready4use](https://ready4-dev.github.io/ready4use/) authoring tools.

2. The seven [module libraries](docs/getting-started/software/libraries/types/module/) that are sufficiently developed to have been used in [real world scientific studies](/docs/examples/), in the following order: [youthvars](https://ready4-dev.github.io/youthvars/), [scorz](https://ready4-dev.github.io/scorz/), [specific](https://ready4-dev.github.io/specific/), [TTU](https://ready4-dev.github.io/TTU/), [youthu](https://ready4-dev.github.io/youthu/), [mychoice](https://ready4-dev.github.io/mychoice/) and [heterodox](https://ready4-dev.github.io/heterodox/). 

3. The very early stage [bimp](https://ready4-dev.github.io/bimp/) library from the [modelling programs pipeline](/docs/model/pipeline/pipeline-programs/), 

4. The three remaining computational model authoring tools framework libraries, starting with [ready4fun](https://ready4-dev.github.io/ready4fun/), then [ready4class](https://ready4-dev.github.io/ready4class/) and finally [ready4pack](https://ready4-dev.github.io/ready4pack/).

The planned sequence for bringing unreleased code first to development releases and then to production releases is:

1. Four development module libraries from the [modelling places pipeline](/docs/model/pipeline/pipeline-places/).

2. Two module libraries from the [modelling people pipeline](/docs/model/pipeline/pipeline-people/) (the synthetic household creation library and that agent based modelling library).

3. Three libraries from the [modelling platforms pipeline](/docs/model/pipeline/pipeline-platforms/) (the primary mental health service discrete event simulation, followed by the early psychosis cohort model, followed by the service system eligibility and referral policy optimisation model).

How quickly we can launch production releases of all our code depends on how much and [what type of help](/docs/contribution-guidelines/contribution-types/) we get. Working within our current resources we expect to get all current projects to production releases within the 2023-2025 window. With help this release schedule can be sped up.