
---
title: "The role of functional programming in ready4 development"
linkTitle: "Functional"
date: "2022-12-24"
description: "ready4 uses functional programming to maximise the re-usability of model algorithms."
weight: 62
categories: 
- Documentation
tags: 
- Framework
- Framework - authoring tools
- Framework - authoring tools (modules)
- Programming
- Programming - functional
- Software
- Software - libraries
- Software - libraries (ready4fun)
---

Although the [object-oriented programming (OOP)](/docs/framework/implementation/paradigm/object-oriented/) approach ready4 implements has many advantages, it can also have some limitations. Some of these limitations have been colorfully highlighted by a popular quote attributed to Joe Armstrong:

> "The problem with object-oriented languages is they've got all this implicit environment that they carry around with them. You wanted a banana but what you got was a gorilla holding the banana and the entire jungle."

In practical terms, this means that if not carefully planned, using OOP can create barriers to code-reuse as algorithms come bundled with artefacts of no/low relevance to many potential users. To help maximise the accessibility and re-usability of ready4 algorithms, these algorithms are primarily written using the functional programming paradigm. Only once an algorithm has been implemented using functions are they then linked to a data-structure by means of a calling method. The typical development workflow for a ready4 computational [modelling project](/docs/getting-started/concepts/project/) might therefore look something the following three step process:

1. A modelling study algorithm is implemented as a [program](/docs/getting-started/software/executables/programs/).

2. To help generalise the methods used in the study algorithm, it is decomposed into functions, which are bundled as a [code library](/docs/getting-started/software/libraries/) (or libraries). The program is updated to use the newly authored functions.

3. A [ready4 module](/docs/framework/implementation/modularity/) is authored to define a data-structure along with a method (or methods) that call the functions to implement the generalised version of the study algorithm. The new module is added to the previously created code library and the program is again updated so that the algorithm is now implemented by supplying data to the ready4 module and then calling the desired method(s).

[Modellers](/docs/getting-started/users/modeller/) using ready4 for the most part will only use ready4 modules and will rarely interact directly with the functions that implement module methods. However, these functions are potentially of significant usefulness to [coders](/docs/getting-started/users/coder/) authoring new algorithms. A helpful way of exploring currently available functions is to use the [ready4 dependencies app](/docs/getting-started/software/libraries/dependencies/). All ready4 [functions are created with minimal, but consistent documentation](/docs/model/authoring-modules/authoring-algorithms/) with the aid of tools from the [ready4fun](https://ready4-dev.github.io/ready4fun/) library.
