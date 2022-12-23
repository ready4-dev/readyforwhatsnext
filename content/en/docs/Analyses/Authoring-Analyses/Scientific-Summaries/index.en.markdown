---
title: "Authoring scientific manuscripts"
linkTitle: "Authoring manuscripts"
date: "2022-12-24"
description: "Tools from the ready4show R package support authoring of scientific summaries of analyses with ready4."
weight: 92
categories: 
- Documentation
tags: 
- Automated reports
- Library - ready4show
- Reproducibility
output: hugodown::md_document
---
<script src="{{< blogdown/postref >}}index.en_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/lightable/lightable.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/lightable/lightable.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/lightable/lightable.css" rel="stylesheet" />
<script src="{{< blogdown/postref >}}index.en_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index.en_files/lightable/lightable.css" rel="stylesheet" />

{{% pageinfo %}}
This below section renders a vignette article from the ready4show library. You can use the following links to:

* [view the vignette on the library website (adds useful hyperlinks to code blocks)](https://ready4-dev.github.io/ready4show/articles/V_01.html)
* [view the source file](https://github.com/ready4-dev/ready4show/blob/master/vignettes/V_01.Rmd) from that article, and;
* [edit its contents](https://github.com/ready4-dev/ready4show/edit/master/vignettes/V_01.Rmd) (requires a GitHub account).
{{% /pageinfo %}}



















```r
library(ready4)
library(ready4show)
library(bookdown)
library(rticles)
```

## Motivation
Open science workflows should ideally span an unbroken chain between data-ingest to production of a scientific summary such as a manuscript. Such extensive workflows provide an explicit means of linking all content in a scientific summary with the analysis that it reports. 

## Implementation
`ready4show` includes a number of classes and methods that help integrate manuscript authoring into a reproducible workflow. These tools are principally intended for use with the [ready4 youth mental health system model](https://www.ready4-dev.com).

### Create a synopsis of the manuscript to be authored
To start with we create `X`, an instance of `Ready4showSynopsis`, a ready4 module (S4 class). We can use `X` to record metadata about the manuscript to be authored (including details about the study being summarised and the title and format of the intended output).


```r
X <- Ready4showSynopsis(background_1L_chr = "Our study is entirely fictional.",
                        coi_1L_chr = "None declared.",
                        conclusion_1L_chr = "These fake results are not interesting.",
                        digits_int = 3L,
                        ethics_1L_chr = "The study was reviewed and granted approval by Awesome University's Human Research Ethics Committee (1111111.1).",
                        funding_1L_chr = "The study was funded by Generous Benefactor.",
                        interval_chr = "three months",
                        keywords_chr = c("entirely","fake","do", "not","cite"),
                        outp_formats_chr = "PDF",
                        sample_desc_1L_chr = "The study sample is fake data that pretends to be young people aged 12 to 25 years who attended Australian primary care services for mental health related needs between November 2019 to August 2020.",
                        title_1L_chr = "A hypothetical study using fake data")
```

### Add authorship details
Authorship details can be added to slots of `X` that contain `ready4show_authors` and `ready4show_instututes` ready4 sub-modules.

As we can see from the below call to `exhibitSlot`, `X` was created with no authorship information.


```r
exhibitSlot(X,
            "authors_r3",
            scroll_box_args_ls = list(width = "100%")) 
```

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; "><table class=" lightable-paper lightable-hover lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> First-name </th>
   <th style="text-align:left;"> Middle-name </th>
   <th style="text-align:left;"> Last-name </th>
   <th style="text-align:left;"> Title </th>
   <th style="text-align:left;"> Qualifications </th>
   <th style="text-align:left;"> Institutes </th>
   <th style="text-align:left;"> Sequence Position </th>
   <th style="text-align:left;"> Corresponding </th>
   <th style="text-align:left;"> Email </th>
   <th style="text-align:left;"> Joint-first </th>
  </tr>
 </thead>
<tbody>
  <tr>

  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> </td></tr></tfoot>
</table></div>

We can add details on each author by repeated calls to the `renewSlot` method.


```r
X <- renewSlot(X,
          "authors_r3",
          first_nm_chr = "Alejandra",
          middle_nm_chr = "Rocio",
          last_nm_chr = "Scienceace",
          title_chr = "Dr",
          qualifications_chr = "MD, PhD",
          institute_chr = "Institute_A, Institute_B",
          sequence_int = 1,
          is_corresponding_lgl = T,
          email_chr = "fake_email@fake_institute.com") %>%
  renewSlot("authors_r3",
            first_nm_chr = "Fionn",
            middle_nm_chr = "Seamus",
            last_nm_chr = "Researchchamp",
            title_chr = "Prof",
            qualifications_chr = "MSc, PhD",
            institute_chr = "Institute_C, Institute_B",
            sequence_int = 2,
            email_chr = "fake_email@unreal_institute.com") 
```

The updated authorship table can now be inspected.


```r
X %>%
  exhibitSlot("authors_r3",
              scroll_box_args_ls = list(width = "100%")) 
```

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; "><table class=" lightable-paper lightable-hover lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> First-name </th>
   <th style="text-align:right;"> Middle-name </th>
   <th style="text-align:left;"> Last-name </th>
   <th style="text-align:right;"> Title </th>
   <th style="text-align:left;"> Qualifications </th>
   <th style="text-align:right;"> Institutes </th>
   <th style="text-align:left;"> Sequence Position </th>
   <th style="text-align:right;"> Corresponding </th>
   <th style="text-align:left;"> Email </th>
   <th style="text-align:right;"> Joint-first </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Alejandra </td>
   <td style="text-align:right;"> Rocio </td>
   <td style="text-align:left;"> Scienceace </td>
   <td style="text-align:right;"> Dr </td>
   <td style="text-align:left;"> MD, PhD </td>
   <td style="text-align:right;"> Institute_A, Institute_B </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:right;"> TRUE </td>
   <td style="text-align:left;"> fake_email@fake_institute.com </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fionn </td>
   <td style="text-align:right;"> Seamus </td>
   <td style="text-align:left;"> Researchchamp </td>
   <td style="text-align:right;"> Prof </td>
   <td style="text-align:left;"> MSc, PhD </td>
   <td style="text-align:right;"> Institute_C, Institute_B </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> fake_email@unreal_institute.com </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> </td></tr></tfoot>
</table></div>

We now need to add additional information for each author institute.


```r
X <- renewSlot(X,
          "institutes_r3",
          short_name_chr = "Institute_A", 
          long_name_chr = "Awesome University, Shanghai") %>%
  renewSlot("institutes_r3",
            short_name_chr = "Institute_B", 
            long_name_chr = "August Institution, London") %>%
  renewSlot("institutes_r3",
            new_val_xx = "use_renew_mthd",
            short_name_chr = "Institute_C", 
            long_name_chr = "Highly Ranked Uni, Montreal")
```

The updated institutes table can now be inspected.


```r
X %>%
  exhibitSlot("institutes_r3",
              scroll_box_args_ls = list(width = "100%")) 
```

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; "><table class=" lightable-paper lightable-hover lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Reference </th>
   <th style="text-align:right;"> Name </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Institute_A </td>
   <td style="text-align:right;"> Awesome University, Shanghai </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Institute_B </td>
   <td style="text-align:right;"> August Institution, London </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Institute_C </td>
   <td style="text-align:right;"> Highly Ranked Uni, Montreal </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> </td></tr></tfoot>
</table></div>

### Add correspondences
We can also add a look-up table about any changes we wish to make from the analysis code of how names of variables / parameters are presented in the manuscript text.


```r
X <- renewSlot(X,
               "correspondences_r3",
               old_nms_chr = c("PHQ9", "GAD7"),
               new_nms_chr = c("PHQ-9", "GAD-7"))
```

These edits can now be inspected with a call to `exhibitSlot`.


```r
X %>%
  exhibitSlot("correspondences_r3",
              scroll_box_args_ls = list(width = "100%")) # Add Exhibit Method
```

<div style="border: 1px solid #ddd; padding: 5px; overflow-x: scroll; width:100%; "><table class=" lightable-paper lightable-hover lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0; font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Old name </th>
   <th style="text-align:right;"> New name </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PHQ9 </td>
   <td style="text-align:right;"> PHQ-9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> GAD7 </td>
   <td style="text-align:right;"> GAD-7 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> </td></tr></tfoot>
</table></div>

### Specify output directory
We now update `X` with details of the directory to which we wish to write the manuscript we are authoring and all its supporting files.


```r
X <- renewSlot(X,
               "a_Ready4showPaths@outp_data_dir_1L_chr",
               new_val_xx = tempdir())
```

### Create dataset of literate programming files
Our next step is to copy a dataset of files that can implement a literate program to generate our manuscript. If you have a template you wish to work with, you can specify its local path using the `a_Ready4showPaths@mkdn_source_dir_1L_chr` slot of the `X`. Skip this step if you wish to use [the default markdown dataset](https://github.com/ready4-dev/ms_tmpl), which leverages popular rmarkdown toolkits such as `bookdown` and `rticles`. 


```r
## Not run
# procureSlot(X,
#             "a_Ready4showPaths@mkdn_source_dir_1L_chr",
#             new_val_xx  = "PATH TO MARKDOWN DATASET")
```

We create the dataset copy with the `authorData` method.




```r
authorData(X)
```

Having created a local copy of the template literate program files dataset, it is now possible to manually edit the markdown files to author the manuscript. However, in this example we are skipping this step and will continue to use the unedited template in conjunction with the metadata we have specified in `X`. We combine the two to author a manuscript using the `authorReport` method.


```r
authorReport(X)
```

If we wish, we can now ammend `X` and then rerun the `authorReport` method to generate Word and HTML versions of the manuscript.


```r
renewSlot(X,
          "outp_formats_chr",
          new_val_xx = "Word") %>%
  authorReport()
```

```r
renewSlot(X,
          "outp_formats_chr",
          new_val_xx = "HTML") %>%
  authorReport()
```


The outputed files are as follows:

- [PDF version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.pdf) (and [LaTeX file that generated it](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.tex))
- [Word version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.docx)
- [HTML version](https://github.com/ready4-dev/ready4show/releases/download/Documentation_0.0/Manuscript.html) 



