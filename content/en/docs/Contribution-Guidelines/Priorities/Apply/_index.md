---
title: "Priority 3: Apply readyforwhatsnext to undertake replications and transfers"
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
  We want readyforwhatsnext to be used to implement replications and transfersof the original studies for which that software was developed.
---

## Why?
Authoring of new readyforwhatsnext modules] can involve a significant investment of time and skills, an investment that is typically made in the context of implementing a modelling project for a scientific study. However, once authored, these modules may significantly streamline the implementation ofmay apply - more replications and generalisations mean more [open access data](//docs/model/datasets/) and module customisations available to other users, enhancing the practical utility of readyforwhatsnext.

## What?
We plan to demonstrate that studies implemented with readyforwhatsnext are relatively straightforward and efficient to replicate and transfer. The most important initial types of help we need with achieving this goal are [funding](/docs/contribution-guidelines/contribution-types/funding/), [projects](/docs/contribution-guidelines/contribution-types/use/), [code contributions](/docs/contribution-guidelines/contribution-types/code/) and [advice](/docs/contribution-guidelines/contribution-types/advisory/).

## How?
The main tasks for implementing study replications and transfers are:

1. Identify the [example study](/docs/examples/) to be replicated or transferred. 

2. Review that study's [analysis program](/docs/model/analyses/replication-code/):
- do the data used in this program have similar structure / concepts / sampling to the data for which a new analysis is planned?
- are modules used in that program from production release module libraries and do any of them require authoring of inheriting modules to selectively update aspects of module data-structures or algorithms?

3. Create a new input dataset, labelling and (for non-confidential data) storing the data in an online repository (which can be kept private for now).

4. *(If new inheriting modules are required)* Make a [code contribution](/docs/contribution-guidelines/contribution-types/code/) to create and test new inheriting modules.

5. Adapt the original study's analysis program to account for differences in input data, model modules and study reporting.

6. Share new new analysis program in the [ready4 Zenodo community](https://zenodo.org/communities/ready4/).

7. Ensure the online model input dataset is made public and submit it as a Linked Dataverse Dataset in the appropriate section of the [ready4 Dataverse](https://dataverse.harvard.edu/dataverse/ready4).


## When?
In most cases, we recommend waiting until production releases of relevant module libraries are available. However, we are currently planning or actively undertaking some initial study analysis transfers using the development versions of our [utility mapping](/docs/model/modules/using-modules/people/map-to-utility/) and [choice modelling](/docs/model/modules/using-modules/people/predict-choice/) module libraries. We are undertaking this work in parallel with testing and, where necessary, extending the required modules. We suggest that, should you believe that any of our development version software is potentially relevant to a study you wish to undertake, you first [get in touch with our project lead](https://mph-economist.netlify.app/#contact) to discuss the pros / cons and timing of using this software.
