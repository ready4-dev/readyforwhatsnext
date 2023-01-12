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
  We want all our existing [development releas](/docs/getting-started/software/status/unreleased/) and [unreleased](/docs/getting-started/software/status/development/) software to attain [production release](/docs/getting-started/software/status/production/) status.
---


## Why?
All our [software](/docs/getting-started/software/), regardless of [status](/docs/getting-started/software/status/) is supplied [without any warranty](/docs/getting-started/software/terms/disclaimer/). However, our views about whether an item of software is potentially appropriate for others to use in undertaking real world [analyses](/docs/analyses/) is reflected in its release status. If it is not a production release, we think it probably needs more testing and development before it can be used beyond the limited specific studies to which we have already applied it. In part due to this reason, it is unlikely that any item of our software will be widely adopted until it is available as a production release. We also cannot meaningfully track uptake of our software until it becomes available in a dedicated production release [repository](/docs/getting-started/software/repositories/).

## How?
The main tasks to be completed to bring all of our existing [code libraries](/docs/getting-started/software/libraries/) to production releases is as follows:

1. (For unreleased software) Address all issues preventing public release of code repositories (e.g. fixing errors preventing core functions working, removing all traces of potentially confidential artefacts from all versions/branches of repository, etc.).

2. (For code libraries are implemented using only the [functional programming](/docs/framework/implementation/paradigm/functional/) paradigm) Create and test new [modules](/docs/getting-started/concepts/module/).

3. Write / update unit tests.

4. Enhance algorithm generated documentation for all artefacts in a code library. This will involve some or all of: minor modifications of function names / arguments / code, updating the [taxonomies datasets used in the documentation writing algorithm](/docs/model/authoring-modules/authoring-algorithms/) and/or updating the algorithms itself (within the [ready4fun](https://ready4-dev.github.io/ready4fun/) and [ready4class](https://ready4-dev.github.io/ready4class/) packages).

5. Adding human authored documentation for the modules contained in each library.

## When?
Our production releases will be submitted to the Comprehensive R Archive Network (CRAN). CRAN does not allow for submitted R packages to depend on development version R packages, so the [dependency network](/docs/getting-started/software/libraries/dependencies/) of our code-libraries shapes the sequence in which we bring them to production releases.

The planned sequence for working on bringing current development release code libraries to production releases is: [ready4](https://ready4-dev.github.io/ready4/), [ready4show](https://ready4-dev.github.io/ready4show/), [ready4use](https://ready4-dev.github.io/ready4use/), [youthvars](https://ready4-dev.github.io/youthvars/), [scorz](https://ready4-dev.github.io/scorz/), [specific](https://ready4-dev.github.io/specific/), [TTU](https://ready4-dev.github.io/TTU/), [youthu](https://ready4-dev.github.io/youthu/), [mychoice](https://ready4-dev.github.io/mychoice/), [heterodox](https://ready4-dev.github.io/heterodox/), [bimp](https://ready4-dev.github.io/bimp/), [ready4fun](https://ready4-dev.github.io/ready4fun/), [ready4class](https://ready4-dev.github.io/ready4class/) and [ready4pack](https://ready4-dev.github.io/ready4pack/).

## What
The most important types of help we need with this priority area are [code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/) and [funding](/docs/contribution-guidelines/contribution-types/funding/).