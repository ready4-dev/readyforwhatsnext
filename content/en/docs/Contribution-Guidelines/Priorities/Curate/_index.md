---
title: "Priority 2: Maintain readyforwhatsnext"
linkTitle: "Mantain"
date: 2017-01-05
weight: 302
tags:
- Project
- Project - contributions
- Project - contributions (priorities)
categories:
- Documentation
description: >
  We want the readyforwhatsnext to continually improve and update in response to the needs of potential users and stakeholders.
---


## Why?
A significant limitation of many health economic models is that they are not updated and can become progressively less valid with time. The importance of maintaining a computational model increases if, like readyforwhatsnext, it is intended to have multiple applications and users. As we progressively make production releases to [launch the MVP model](docs/contribution-guidelines/priorities/launch/), we intend that people will start using it. As readyforwhatsnext becomes more widely used, its limitations (errors, bugs, restrictive functionality and confusing / inadequate documentation) are more likely to become exposed and to require remediation. Addressing such issues needs to implemented skillfully and considerately to avoid unintended consequences on existing model users (e.g. to ensure software edits to fix one problem do not prevent previously written replication code or downstream dependencies from executing correctly). Open source projects like readyforwhatsnext also need to make changes in response to decisions by third parties - such as edits to upstream dependencies and changes in the policies of hosting repositories and to update citation / acknowledgement information to appropriately reflect new contributors.


## What?
All readyforwhatsnext model software needs to be maintained and updated to identify and fix bugs, enhance functionality and usability, respond to changes in upstream dependencies and to conscientiously deprecate outdated code. Open access datasets made available for use in modelling analyses need to be actively curated to ensure they remain relevant to current decision contexts. [Decision aids](/docs/model/decision-aids/) need to be reviewed and updated to ensure they continue to use the most up to date and appropriate modules and input data.

The most important types of help we need with this priority area are [funding](/docs/contribution-guidelines/contribution-types/funding/), [code contributions](/docs/contribution-guidelines/contribution-types/code/), [community support](/docs/contribution-guidelines/contribution-types/community/) and [advice](/docs/contribution-guidelines/contribution-types/advisory/).

## How?
The main tasks for the maintenance of framework and model software are to:

1. Appropriately configure and update the settings of the [ready4 GitHub organisation](https://github.com/ready4-dev) and its constituent repositories to facilitate easy to follow and efficient maintenance workflows.

2. *Proactively*:

- author ongoing improvements to software testing, documentation and functionality; 

- make archived releases of key development milestones in the [ready4 Zenodo community](https://zenodo.org/communities/ready4); and

- submit new production releases to the Comprehensive R Archive Network (CRAN).

3. *Reactively* elicit, review and address feedback and contributions from readyforwhatsnext [community](/community/) (e.g. bugs, issues and feature-requests).

The main tasks for curating model data collections include:

1. Implementing ongoing improvements and updates to meta-data descriptors of data collections and individual files.

2. Facilitating the linking of datasets to and from the [ready4 Dataverse](https://dataverse.harvard.edu/dataverse/ready4).

3. Reviewing all collections within the ready4 Dataverse to identify datasets or files that are potentially out of date.

4. Creating and publishing new versions of affected datasets with the necessary additions, deletions and edits and updated metadata. Prior versions of data collections remain publicly available.

5. Informing the readyforwhatsnext [community](/community/) of the updated collections.

The main tasks for curating decision aids include:

1. Monitoring the repositories of the software and the data used by the app for important updates.

2. Deploying an updated app bundle of software and data to a test environment on [Shinyapps.io](https://www.shinyapps.io/).

3. Testing the new deployment and elicit user feedback.

4. Implementing any required fixes identified during testing.

5. Deploying the updated app to a Shinyapps.io production environment.

6. Informing the readyforwhatsnext [community](/community/) of the updated decision aid.

## When?
Maintenance is an ongoing and current responsibility. Maintenance obligations are expected to grow considerably as we [launch more production releases](/docs/contribution-guidelines/priorities/launch/), [extend the readyforwhatsnext model](/docs/contribution-guidelines/priorities/extend/) and [grow a user community](/docs/contribution-guidelines/priorities/support/).
