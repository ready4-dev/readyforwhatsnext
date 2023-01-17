---
title: "Priority 3: Apply ready4 to undertake novel analyses"
linkTitle: "Apply"
date: 2017-01-05
weight: 303
tags:
- Project
- Project - contributions
- Project - contributions (priorities)
categories:
- Documentation
description: >
  We want all maintained [production releases](/docs/getting-started/software/status/production-releases/) of ready4 [module libraries](/docs/getting-started/software/libraries/types/module/) to be used to implement [replications and generalisations](/docs/getting-started/concepts/reproducible-replicable-generalisable/) of the original studies for which that software was developed.
---

## Why?
In this relatively early stage of ready4's development, the [authoring of new ready4 modules](/docs/model/authoring-modules/) can involve a significant investment of time and skills, an investment that is typically made in the context of implementing a [modelling project](/docs/getting-started/concepts/project/) as part of a scientific study. However, once developed these modules are intended to significantly streamline the implementation of
modelling [analyses](/docs/analyses/) that replicate or generalise the studies for which those modules were developed. For [modellers](/docs/getting-started/users/modeller/) and other [researchers](/docs/getting-started/stakeholders/researchers/), using ready4 for this purpose may provide the highest reward to effort ratio of any contribution to the ready4 [community](/community/).

## What?
The most important types of help we need with this priority area are [code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/), [advice](/docs/contribution-guidelines/contribution-types/advisory/) and [funding](/docs/contribution-guidelines/contribution-types/funding/).

## How?
The main tasks for implementing study replications and generalisations are:

1. Identify the [example study](/docs/examples/) to be replicated / generalised. 

2. Review that study's [analysis program](/docs/analyses/replication-code/):
- do the data for which a new analysis is planned have similar structure / concepts / sampling to the original [model data](/docs/datasets/) specified in this program?
- are [modules](/docs/getting-started/concepts/module/) used in that program from [production release](/docs/getting-started/software/status/production-releases/) module libraries and do any of them require authoring of [inheriting modules](/docs/framework/implementation/paradigm/object-oriented/#inheritence) to selectively update aspects of module data-structures or algorithms?.

3. [Create a new input dataset](/docs/datasets/authoring-data/), labelling and (for non-confidential data) storing the data in an online repository (which can be kept private for now).

4. *(If new inheriting modules are required)* Make a [code contribution](/docs/contribution-guidelines/contribution-types/code/) to create and test new inheriting modules.

5. Adapt the original study's analysis program to account for differences in input data, model modules and [study reporting](/docs/analyses/authoring-analyses/scientific-summaries/).

6. Share new new analysis program in the [ready4 Zenodo community](https://zenodo.org/communities/ready4/).

7. Ensure the online model input dataset is made public and submit it as a [Linked Dataverse Dataset](/docs/datasets/finding-data/ingest/#3-concepts) in the appropriate section of the [ready Dataverse](https://dataverse.harvard.edu/dataverse/ready4).


## When?
In most cases, we recommend waiting until production releases of relevant module libraries are available. We are currently planning or actively undertaking some initial study analysis generalisations using the [development versions](/docs/getting-started/software/status/development-releases/) of our [utility mapping](/docs/model/using-modules/people/map-to-utility/) and [choice modelling](/docs/model/using-modules/people/predict-choice/) module libraries. If any of our development version software is potentially relevant to a study you wish to undertake, we recommend that you first [get in touch with our project lead](https://mph-economist.netlify.app/#contact) to discuss the pros and cons of doing so.