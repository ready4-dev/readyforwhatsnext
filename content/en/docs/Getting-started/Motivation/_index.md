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
  To be accountable, flexible and up to date, ready4 is being implemented as a [modular](/docs/getting-started/concepts/module/) and [open source](/docs/getting-started/software/terms/licenses/) [computational model](/docs/getting-started/concepts/model/#computational-model).
---

## Problem
Improving the mental health and wellbeing of young people is a global public health priority. However, identifying the optimal policy and system design choices to meet this challenge is not straightforward. [Models](/docs/getting-started/concepts/model/) are a potentially useful tool to help decision makers navigate complexity, but can have significant limitations such as:

- *Mistakes*: Errors, common in even relatively simple health economic models, become both more likely to occur and more difficult to detect as model complexity grows;

- *Poor transparency*: the validity of model analyses can be difficult to adequately ascertain if it is not clear who contributed to the model, what assumptions they made, how model algorithms were implemented, how those algorithms were tested and what data they were applied to;

- *Contested legitimacy*: the value judgments of the model development team (e.g. what types of question are most important for a model to address, what parts of the workings of the system of interest to represent and in what detail, what outcome variables to include, which stakeholders to consult, etc) may differ from those using or affected by model outputs;

- *Narrow applicability*: a model might be too simple to adequately explore some problems and too complex to reliably address others and be hard to generalise beyond a very specific decision context (e.g. within a specific jurisdiction);

- *Limited interoperability*: different approaches to model implementation, dissemination, ownership and reporting makes it more difficult for multiple models to be efficiently and safely combined;

- *Ease of misuse*: in the absence of clear documentation and prominent caveats, a model can easily be applied to decision problems to which it is poorly suited (potentially supporting decisions with serious negative consequences);

- *Restricted access*: a potential overcompensation for fear of model misuse is constructing high barriers to accessing model code and data - thus limiting model testing, reuse and refinement; and

- *Growing stale*: health economic models are rarely updated, meaning they can lose validity with time (e.g. input data becomes less relevant, new better performing algorithms are not incorporated, sudden major changes in environment / epidemiology / policy / service system are not accounted for).

## Reponse
To help address these issues, ready4 is being implemented as a modular and open source computational model of youth mental health that aims to be accountable, reusable and updatable.

### Accountable
Model code and data are publicly available in online [code repositories](/docs/getting-started/software/repositories/) and [data collections](/docs/datasets/finding-data/search/). Algorithms are [documented and transparently and regularly tested](/docs/getting-started/software/libraries/documentation/). Model development occurs [in the open](https://github.com/ready4-dev) and [invites community participation](/community/), with each individual's [contribution](/docs/contribution-guidelines/) publicly identifiable. [Analyses](/docs/analyses/) are [reproducible and replicable](/docs/getting-started/concepts/reproducible-replicable-generalisable/#reproduction-and-replication).

### Reusable
[Model modules](/docs/model/) and [datasets](/docs/datasets/) originally developed in one modelling project can be independently [reused](/docs/model/using-modules/) in other projects. As they share a common [framework](/docs/framework/), model modules can be combined in other models and analyses to address [multiple topics](/docs/examples/). Due to ready4's [code implementation paradigms](/docs/framework/implementation/paradigm/), model modules are easier to [generalise](/docs/getting-started/concepts/reproducible-replicable-generalisable/#generalising) for use in other decision contexts.

### Updatable
Model code, data and analyses are versioned, with an ongoing program of making [new and updated releases](/blog/releases/). Software is [maintained](/docs/contribution-guidelines/priorities/curate/), with opportunities for users and contributors to flag issues, request features and supply [code contributions](/docs/contribution-guidelines/contribution-types/code/).


