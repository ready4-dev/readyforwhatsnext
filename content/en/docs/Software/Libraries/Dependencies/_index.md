---
title: "Dependencies"
linkTitle: "Dependencies"
weight: 267
tags:
- Software
- Software - apps
- Software - functions
- Software - libraries
- Software - libraries (dependencies)
categories:
- Documentation
description: >
  Search for ready4 library and function dependencies using our interactive app.
---

As an open-source project, ready4 depends on the software created and shared by others. Using the [DependenciesGraphs R package](http://datastorm-open.github.io/DependenciesGraphs/), we have created the Shiny app below to:

- explore the inter-dependencies between ready4 libraries;
- highlight how our software depends on other R packages;
- itemise the contents each ready4 library;
- display function help files; and 
- map function inter-dependencies across multiple ready4 libraries.

To use the app, choose one of the two potential pathways:
- For **Pathway 1**, start at Step 1 (choose the libraries you wish to profile from the drop down menu and click on the Go button), before proceeding to Step 2 (click on one library that you wish to view the contents of), then Step 3 (click on the view functions button) and finally Step 4 (click on the function for which you would like to view documentation);
- For **Pathway 2**, start at Step 1 (choose libraries from the drop down menu), then Step 2 (click on the Find functions button), then Step 3 (select functions from the drop down menu) and finally Step 4 (click on the Make graph button).

Note, as the app is displayed on this page via an iFrame, it may be difficult to view on a phone. If so, you can try the following link: https://orygen.shinyapps.io/dependencies/

{{< iframe src = "https://orygen.shinyapps.io/dependencies/" >}}
