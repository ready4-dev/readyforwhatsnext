[![Netlify Status](https://api.netlify.com/api/v1/badges/9f581e95-8d2a-4fb8-81fa-d064870ecb1f/deploy-status)](https://app.netlify.com/sites/health-sci-j-demo/deploys)

![Health Sciences Journal - Hugo Theme](https://raw.githubusercontent.com/epistemehealth/health-science-journal/master/images/tn.png)

# Health Sciences Journal Theme

A Hugo theme that mirrors the appearance of an [OJS](https://github.com/pkp/ojs) journal using the [health sciences theme](https://github.com/pkp/healthSciences).

# Demo

A demo instance of the theme is hosted on [Netlify](https://health-sci-j-demo.netlify.app/) and on the [Hugo themes gallery](https://themes.gohugo.io/health-science-journal/).

# Features

The theme can replicate the journal front end, including homepage, tables of contents, and journal information pages. Its key use cases are to mirror a journal or to publish a journal with a separate front end from the submission system. This allows a journal to ensure content remains available during maintenance tasks, such as OJS updates, and to provide faster loading times for readers.

Article pages will:
* Show article details, including authors, abstract, funding, keywords, and references
* Provide the article's citation in 10 different options for in-browser display or for export in RIS, Endnote, Bib, and CSL-JSON formats.
* Embed article citation details in meta tags (Dublin Core and for Google Scholar) and COinS (for Zotero).
* Allow for viewing for PDF and XML galleys using eLife lens
* Display the Crossmark logo if crossmark_enabled is set to `true` in config.toml.

A small number of enhancements have also been made including:
* Lens viewer now includes the journal logo and a back button
* Homepage background images can be served in multiple resolutions to improve responsiveness
* Some citation display formats have been updated or adjusted, including MLA and Vancouver.

# Installation

* Download from Github: https://github.com/epistemehealth/health-science-journal/archive/master.zip
* Clone repository: https://github.com/epistemehealth/health-science-journal.git

To view a demo in a local installation:

```
$ git clone https://github.com/epistemehealth/health-science-journal.git
$ cd health-science-journal
$ cd exampleSite
$ hugo server --minify --themesDir ../..
```

# Configuration

Configure `config.toml` with your publisher and journal information, including:

* Journal title
* eISSN and print ISSN
* Publisher information
* A current issue path, if not using the most recent issue as the current issue
* Default social media information for opengraph and Twitter cards
* Whether to use external CDNs or to use local copies of dependencies
* Footer content can also be customised here

# Journal static pages

Static content can be added to `content\about` and `content\contact`. The contact page is designed to follow a specific layout used by OJS.

Any number of static pages can be added to the `about` section.

# Publishing content

Content should be added to `content\article\path`. Issue paths can be volume numbers, issue numbers, years, or any other arbitrary path. Within each issue, an `_index.md` is required and will set the issue title, description, cover image and cascade key variables like the publication date of the issue, volume number, and issue number down to individual articles.

To publish an individual article, use the `.md` templates provided to input metadata for each article. Contents pages will list article types according to `articleType_weight` for each issue. Within each article type, articles will be listed according to publication date.

PDF and XML galleys can be viewed in browser, with JATS XML galleys rendering using eLife Lens. The version of Lens in this theme has been modified slightly to remove some eLife-specific code and to add space for a journal logo and a back button to return to article details.

## Canonical URLs

One of the use cases for this theme is to generate a static mirror of the journal. Pages therefore have params for `canonicalurl` and canonical galleys, so that those pages can be rendered with `rel="canonical"` tags for search engines.

In `config.toml`, the `mirrorfor` param is used to designate the base URL for the journal. If `mirrorfor` is not set then no `rel="canonical"` tags will be used.

# Support and Future Development

Issues, such as bugs, can be lodged against this repository. This theme is being developed alongside an OJS plugin to handle labelling of remote galleys, so that OJS can be used as the back end submission system and OAI repository while the static front end can be served separately. An alternative option is to use the Hugo theme to generate a static OAI repository.

# License and Acknowledgements

Except where otherwise stated, this theme can be used under a GPL license.

This theme is based on the GPL-licensed health sciences theme by the Public Knowledge Project at Simon Fraser University.

This theme relies on javascript libraries and fonts used under the relevant MIT, Apache, and SIL Open Font licenses.

The example site and demo include stock images made available under CC0 licenses.
