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
  To be [transparent, reusable and updatable](/docs/framework/standards/), ready4 is being implemented as a [modular](/docs/getting-started/concepts/module/) and [open source](/docs/software/terms/licenses/) [computational model](/docs/getting-started/concepts/model/#computational-model).
---

## Problem
[Health economic models](/docs/getting-started/concepts/model/) are a potentially useful tool to help health decision makers navigate complexity, but can have significant limitations such as:

- *Mistakes*: Errors, common in even relatively simple health economic models, become both more likely to occur and more difficult to detect as model complexity grows;

- *Poor transparency*: the validity of model analyses can be difficult to adequately ascertain if it is not clear who contributed to the model, what assumptions they made, how model algorithms were implemented, how those algorithms were tested and what data they were applied to;

- *Contested legitimacy*: the value judgments of the model development team (e.g. what types of question are most important for a model to address, what parts of the workings of the system of interest to represent and in what detail, what outcome variables to include, which stakeholders to consult, etc) may differ from those using or affected by model outputs;

- *Narrow applicability*: a model might be too simple to adequately explore some problems and too complex to reliably address others and be hard to transfer beyond a very specific decision context (e.g. within a specific jurisdiction);

- *Limited interoperability*: different approaches to model implementation, dissemination, ownership and reporting makes it more difficult for multiple models to be efficiently and safely combined;

- *Ease of misuse*: in the absence of clear documentation and prominent caveats, a model can easily be applied to decision problems to which it is poorly suited (potentially supporting decisions with serious negative consequences);

- *Restricted access*: a potential overcompensation for fear of model misuse is constructing high barriers to accessing model code and data - thus limiting model testing, reuse and refinement; and

- *Growing stale*: health economic models are rarely updated, meaning they can lose validity with time (e.g. input data becomes less relevant, new better performing algorithms are not incorporated, sudden major changes in environment / epidemiology / policy / service system are not accounted for).

## Reponse
To help address these issues, the ready4 [software framework](/docs/framework/) aims to support [transparent, reusable and updatable](/docs/framework/standards/) model implementations using R.


