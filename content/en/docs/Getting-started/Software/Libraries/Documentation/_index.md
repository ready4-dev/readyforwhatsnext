---
title: "Code library documentation"
linkTitle: "Documentation"
weight: 266
categories: 
- Documentation
tags: 
- Software
- Software - libraries
- Software - libraries (documentation)
description: >
  Each ready4 code library is supported by a standardised set of documentation resources.
---

All ready4 code libraries have:

- a website, the URL of which typically takes the form of `"https://ready4-dev.github.io/PACKAGE_NAME"` (for example the website for the foundational ready4 R package is https://ready4-dev.github.io/ready4 );

- a brief PDF manual itemising the subset of classes, methods and functions that will be of interest to most end users, the URL of which takes the form of `"https://github.com/ready4-dev/PACKAGE_NAME/releases/download/Documentation_0.0/PACKAGE_NAME_User.pdf"` (for example, https://github.com/ready4-dev/ready4/releases/download/Documentation_0.0/ready4_User.pdf);

- a more comprehensive PDF manual itemising all included classes, methods and functions, including those that may only be of interest to developers of ready4 libraries, the URL of which takes the form of `"https://github.com/ready4-dev/PACKAGE_NAME/releases/download/Documentation_0.0/PACKAGE_NAME_Developer.pdf"` (for example, https://github.com/ready4-dev/ready4/releases/download/Documentation_0.0/ready4_Developer.pdf); and

- a publicly accessible record of the results of all continuous integration checks performed on each version of the source code, the url of which takes the form of `"https://github.com/ready4-dev/PACKAGE_NAME/actions"` (for example, https://github.com/ready4-dev/ready4/actions).

All ready4 code libraries include interactive help. Once you have installed and loaded a library, you can view its contents by using the command `library(help="PACKAGE_NAME")` (for example, `library(help="ready4")`). 

Note that the manuals and files used by the interactive help are currently all automatically authored by tools from our ready4fun package and are therefore quite basic (and in some cases use clumsy English). In the future we hope to augment this machine generated documentation with human-authored documentation.

Most ready4 libraries (the exceptions are those at very early stages of development) have one or more vignette articles that provide examples of how to use it. These are available from the "Articles" section of each library's website.



