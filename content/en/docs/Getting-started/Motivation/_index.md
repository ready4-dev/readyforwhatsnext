---
title: "Motivation"
linkTitle: "Motivation"
weight: 21
categories: 
- Documentation
tags:
- Project
- Project - purpose
description: >
  ready4 is being implemented as a modular, open-source project to develop an accountable, flexible and up to date model.
---

## Problem
Improving the mental health and wellbeing of young people is a global public health priority. However, identifying the optimal policy and system design choices to meet this challenge is not straightforward. [Models](/docs/getting-started/concepts/model/) are of potentially great use for decision makers, but even when implemented by skilled teams,  can have significant limitations such as:

- *Mistakes*: Errors, common in even relatively simple health economic models, become more likely to occur and more difficult to detect as model complexity grows.

- *Poor transparency*: the validity of model analyses can be difficult to adequately ascertain if it is not clear who contributed to the model, what assumptions they made, how model algorithms were implemented, how those algorithms were tested and what data they were applied to;

- *Contested legitimacy*: the value judgments of the model development team (e.g. what types of question are most important for a model to address, what parts of the workings of the system of interest to represent and in what detail, what outcome variables to include) may differ from those using or affected by model outputs;

- *Narrow applicability*: a model might be too simple to adequately address some problems and too complex to reliably explore others and be potentially hard to generalise beyond a very specific decision context (e.g. within a specific jurisdiction);

- *Limited interoperability*: different approaches to model implementation, dissemination, ownership and reporting makes it more difficult for multiple models to be efficiently and safely combined;

- *Ease of misuse*: in the absence of clear documentation and prominent caveats, a model can easily be applied to decision problems to which it is poorly suited (potentially supporting decisions with serious negative consequences);

- *Restricted access*: a potential overcompensation for fear of model misuse is to be highly restrictive in access to model code and data - and thus limit the testing, use and refinement of the model; and

- *Growing stale*: health economic models are rarely updated, meaning they can go stale (input data becomes less relevant / new better performing algorithms are not incorporated) and fail to adapt to new states of the world (e.g. sudden major changes in environment / epidemiology / policy / service system).

## Reponse
To help address these issues, ready4 is being implemented as a [modular](/docs/getting-started/concepts/module/) and [open source](/docs/getting-started/software/terms/licenses/) [computational model](/docs/getting-started/concepts/model/#computational-model) of youth mental health that aims to be accountable, flexible and up to date:

### Accountable
Model code and data are publicly available in online [code repositories](/docs/getting-started/software/repositories/) and [data collections](/docs/datasets/finding-data/search/). Algorithms are [documented and transparently and regularly tested](/docs/getting-started/software/libraries/documentation/). Model development occurs [in the open](https://github.com/ready4-dev) and [invites community participation](/community/), with each individual's [contribution](/docs/contribution-guidelines/) publicly identifiable. [Analyses](/docs/analyses/) are [reproducible and replicable](/docs/getting-started/concepts/reproducible-replicable-generalisable/#reproduction-and-replication).

### Flexible
Individual (model modules and datasets) are independently [re-usable](/docs/model/using-modules/) to address [multiple topics](/docs/examples/). As they share a common [framework](/docs/framework/), model modules can be combined in other models and analyses. Due to the [code implementation paradigms](/docs/framework/implementation/paradigm/) selected, model modules are easier to [generalise](/docs/getting-started/concepts/reproducible-replicable-generalisable/#generalising) for use in other decision contexts.

### Up to date
Model code, data and analyses are versioned, with an ongoing program of making [new and updated releases](/blog/releases/). Software is [publicly curated](/docs/contribution-guidelines/priorities/curate/), with opportunities for users and contributors to flag issues, request features and supply [code contributions](/docs/contribution-guidelines/contribution-types/code/).


