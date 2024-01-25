---
title: "Priority 1: Launch a Minimum Viable Product (MVP)"
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
  We want to give potential users confidence that they can appropriately apply readyforwhatsnext to their decision problems by bringing all our existing development release and unreleased software to production release status.
---


## Why?
All our software, regardless of status is supplied [without any warranty](/docs/getting-started/terms/disclaimer/). However, our views about whether an item of software is potentially appropriate for others to use in undertaking real world [analyses](/docs/model/analyses/) can be inferred from its release status. If it is not a production release, we probably believe that it needs more development and testing and better documentation before it can be used for any purpose other than the specific studies in which we have already applied it. Partly for this reason, it is unlikely that any item of our software will be widely adopted until it is available as a production release. We also cannot meaningfully track uptake of our software until it becomes available in a dedicated production release [CRAN](https://cran.r-project.org/). We also need a critical mass of model modules available as production releases so that they can be combined to model moderately complex systems.

## What?
Bringing an initial set of development version and pipeline libraries to production release, will constitute the launch ofa **readyforwhatsnext Minimum Viable Product (MVP)**. The MVP will comprise an initial skeleton of production ready modules for modelling [people](/docs/model/modules/using-modules/people/), [places](/docs/model/modules/using-modules/places/), [platforms](/docs/model/modules/using-modules/platforms/) and [programs](/docs/model/modules/using-modules/programs/). 

The most important types of help we need with achieving this goal are [funding](/docs/contribution-guidelines/contribution-types/funding/),
[code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/) and [advice](/docs/contribution-guidelines/contribution-types/advisory/).

## How?
The main tasks to be completed to bring all of our existing [code libraries](/docs/model/modules/finding/libraries/) to production releases is as follows:

1. *(For unreleased software)* Address all issues preventing public release of code repositories (e.g. fixing errors preventing core functions working, removing all traces of potentially confidential artefacts from all versions/branches of repository, etc.).

2. *(For code libraries are implemented using only the functional programming paradigm)* Author and test new modules.

3. Write / update unit tests (tests of individual functions / modules for multiple potential uses / inputs that will be automatically run every time a new version of a library is pushed to the main branch of its development release repository).

4. Enhance the documentation that is automatically authored by algorithms from the [ready4 framework](https://www.ready4-dev.com/) we use to author readyforwhatsnext. This will involve some or all of: 

- minor modifications of function names / arguments / code;

- updating the taxonomies datasets used in the documentation writing algorithm; and/or 

- updating the documentation authoring algorithms (within the [ready4fun](https://ready4-dev.github.io/ready4fun/) and [ready4class](https://ready4-dev.github.io/ready4class/) packages).

5. Adding human authored documentation for the modules contained in each library.

6. *(For some libraries)* Adding a user-interface.

## When?
Our production releases will be submitted to the Comprehensive R Archive Network (CRAN). CRAN does not allow for submitted R packages to depend on development version R packages, so the dependency network of our code-libraries shapes the sequence in which we bring them to production releases.

How quickly we can launch production releases of all our code depends on how much and [what type of help](/docs/contribution-guidelines/contribution-types/) we get. Working within our current resources we expect the first of the 23 libraries listed to be released during late 2024 and the last during late 2026. With your help this release schedule can be sped up.
