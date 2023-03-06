library(ready4)
# library(tidyRSS)
#library(zen4R) # https://cran.r-project.org/web/packages/zen4R/vignettes/zen4R.html#package_overview
make_dss_tb <- function(dvs_tb,
                        what_1L_chr = "all"){
  dss_tb <- dvs_tb %>% dplyr::filter(!is.na(Contents)) %>% 
    dplyr::select(Contents, Datasets_Meta, Dataverse) %>% 
    purrr::pmap_dfr(~{
      ..2 %>% purrr::map_dfr(~{
        fields_ls <- .x$fields
        tibble::tibble(Title = fields_ls$value[which(fields_ls$typeName ==  "title")][[1]], 
                       Description = fields_ls$value[which(fields_ls$typeName == "dsDescription")][[1]][[1]][[4]])
      }) %>% 
        dplyr::mutate(Dataverse = ..3, DOI = ..1)
    })
  if(what_1L_chr == "real") 
    dss_tb <- dss_tb %>% dplyr::filter(Dataverse != "fakes")
  if(what_1L_chr == "fakes") 
    dss_tb <- dss_tb %>% dplyr::filter(Dataverse == "fakes")
  if(what_1L_chr == "people")
    dss_tb <- dss_tb %>% dplyr::filter(Dataverse %in% c("TTU", "springtolife"))
  if(what_1L_chr == "places")
    dss_tb <- dss_tb %>% dplyr::filter(Dataverse %in% c("springtides") | DOI == "https://doi.org/10.7910/DVN/JHSCDJ")
  return(dss_tb)
}
make_ds_releases_tbl <- function (ds_dois_chr, 
                                  format_1L_chr = "%d-%b-%Y", 
                                  server_1L_chr = "dataverse.harvard.edu",
                                  as_kbl_1L_lgl = T,
                                  ...) 
{
  ds_releases_xx <- ds_dois_chr %>% purrr::map_dfr(~{
    meta_ls <- dataverse::dataset_versions(.x, server = server_1L_chr)
    doi_1L_chr <- .x
    1:length(meta_ls) %>% 
      purrr::map_dfr(~tibble::tibble(Date = meta_ls[[.x]]$releaseTime,
                                     Dataset = meta_ls[[1]]$metadataBlocks$citation$fields[[1]]$value,
                                     DOI = paste0("https://doi.org/", doi_1L_chr), 
                                     Version = paste0(meta_ls[[.x]]$versionNumber, 
                                                      ".",
                                                      meta_ls[[.x]]$versionMinorNumber),
                                     `Number of files` = length(meta_ls[[1]]$files)))
  }) %>% 
    dplyr::arrange(dplyr::desc(Date)) %>% 
    dplyr::mutate(Date = Date %>% 
                    format.Date(format_1L_chr) %>% 
                    as.character()) %>%
    dplyr::filter(!is.na(Date))
  if (as_kbl_1L_lgl) {
    ds_releases_xx <- ds_releases_xx %>% dplyr::mutate(Dataset = Dataset %>% 
                                                         kableExtra::cell_spec(format = "html", link = DOI)) %>% 
      dplyr::select(Date, Dataset, 
                    Version, `Number of files`)
    ds_releases_xx <- ds_releases_xx %>% 
      kableExtra::kable("html", escape = FALSE) %>%
      kableExtra::kable_styling(...)
    
  }
  return(ds_releases_xx)
}
make_modules_tb <- function (pkg_extensions_tb = NULL, cls_extensions_tb = NULL, 
          gh_repo_1L_chr = "ready4-dev/ready4", gh_tag_1L_chr = "Documentation_0.0", 
          include_1L_chr = "modules", what_chr = "all") 
{
  if (is.null(pkg_extensions_tb)) 
    pkg_extensions_tb <- make_libraries_tb(include_1L_chr = include_1L_chr, 
                                           what_chr = what_chr)
  if (is.null(cls_extensions_tb)) 
    cls_extensions_tb <- get_cls_extensions(pkg_extensions_tb, 
                                            gh_repo_1L_chr = gh_repo_1L_chr, gh_tag_1L_chr = gh_tag_1L_chr, 
                                            validate_1L_lgl = T)
  modules_tb <- dplyr::inner_join(cls_extensions_tb, pkg_extensions_tb, 
                                  by = "pt_ns_chr") %>%
    dplyr::arrange(type_chr, old_class_lgl)
  
  order_int <- modules_tb$Reference %>% purrr::flatten_int() %>% unique() %>% purrr::discard(is.na)
  modules_tb <- modules_tb %>%
    dplyr::mutate(Reference = dplyr::case_when(!is.na(Reference) ~ purrr::map(Reference, 
                                                                              ~ {
                                                                                new_int <- which(.x ==order_int)
                                                                                if(length(new_int)==1)
                                                                                  new_int <-  rep(new_int,2)
                                                                                new_int
                                                                              }),
                                               T ~ Reference)
    )  
  order_int <- modules_tb$Vignettes_URLs %>% # Prefer to keep this if removing potential duplicate order_int
    purrr::map(~{
      if(is.na(.x[[1]])){
        NA_integer_#.x[[1]]
      }else{
        .x %>% 
          purrr::map_int(~ stringr::str_sub(.x,start=-5) %>% 
                           stringr::str_remove_all("</a>") %>% 
                           as.numeric())
      }
    }) %>% purrr::flatten_int()  %>% 
    purrr::discard(is.na) %>% unique()
  modules_tb <- modules_tb %>%
    dplyr::mutate(Vignettes_URLs = dplyr::case_when(!is.na(Reference) ~ purrr::map(Vignettes_URLs, 
                                                                              ~ {
                                                                                if(is.na(.x[1])){
                                                                                  new_chr <-  NA_character_
                                                                                }else{
                                                                                  old_int <- .x %>% 
                                                                                    purrr::map_int(~ {
                                                                                      start_1L_int <- 1 + (.x %>% stringr::str_locate("\"     \" >") %>% purrr::pluck(2))
                                                                                      stringr::str_sub(.x,start=start_1L_int) %>% 
                                                                                        stringr::str_remove_all("</a>") %>% 
                                                                                        as.numeric()})
                                                                                  #new_int <- which(old_int ==order_int)
                                                                                  new_chr <- .x %>% 
                                                                                    purrr::map2_chr(old_int,
                                                                                                    ~{
                                                                                      end_1L_int <- (.x %>% stringr::str_locate("\"     \" >") %>% purrr::pluck(2))
                                                                                      paste0(stringr::str_sub(.x,end=end_1L_int),
                                                                                             which(.y==order_int),
                                                                                             "</a>")
                                                                                    })
                                                                                }
                                                                                
                                                                                # if(length(new_int)==1)
                                                                                #   new_int <-  rep(new_int,2)
                                                                                new_chr
                                                                              }),
                                               T ~ Vignettes_URLs)
    )  
  modules_tb <- modules_tb %>%
    dplyr::mutate(Class = purrr::pmap(list(pt_ns_chr, 
                                                                                               type_chr, old_class_lgl), ~{
                                                                                                 kableExtra::cell_spec(..2, "html", link = paste0("https://ready4-dev.github.io/", 
                                                                                                                                                  ..1, "/reference/", ifelse(..3, ..2, paste0(..2, 
                                                                                                                                                                                              "-class")), ".html"))
                                                                                               })) %>% dplyr::mutate(Examples = purrr::map2(Vignettes_URLs, 
                                                                                                                                            type_chr, ~get_examples(.x, term_1L_chr = .y)))

  modules_tb <- modules_tb %>% dplyr::mutate(Description = purrr::map2_chr(Class, 
                                                                           old_class_lgl, ~{
                                                                             rvest::read_html((.x %>% stringr::str_match("href=\"\\s*(.*?)\\s*\" style"))[, 
                                                                                                                                                          2]) %>% rvest::html_elements(ifelse(.y, "h1", 
                                                                                                                                                                                              "p")) %>% rvest::html_text2() %>% purrr::pluck(1)
                                                                           }) %>% stringi::stri_replace_last_regex("\\.", "")) %>% 
    dplyr::select(Class, Description, Library, Examples, 
                  old_class_lgl)
  return(modules_tb)
}
print_packages <- function (pkg_extensions_tb = NULL, include_1L_chr = "modules", 
                            scroll_height_1L_chr = character(0), scroll_width_1L_chr = character(0), 
                            ...) 
{
  if (is.null(pkg_extensions_tb)) 
    pkg_extensions_tb <- make_libraries_tb(include_1L_chr = include_1L_chr)
  if(nrow(pkg_extensions_tb) == 1){
    pkg_extensions_tb <- rbind(pkg_extensions_tb,pkg_extensions_tb)
    is_single_1L_lgl <- T
  }else{
    is_single_1L_lgl <- F
  }
  pkg_extensions_tb <- pkg_extensions_tb %>% dplyr::mutate(Badges = purrr::map(pt_ns_chr, 
                                                                               ~get_badge_urls(.x))) %>% dplyr::mutate(Type = "") %>% 
    dplyr::mutate(DOI = "") %>% dplyr::mutate(Logo = "")
  ready4_badges_chr <- purrr::map_chr(pkg_extensions_tb$Badges, 
                                      ~.x$ready4_1L_chr)
  zenodo_badges_chr <- purrr::map_chr(pkg_extensions_tb$Badges, 
                                      ~{
                                        badge_1L_chr <- .x$zenodo_1L_chr
                                        ifelse(identical(badge_1L_chr, character(0)), "https://zenodo.org/badge/DOI/10.5281/zenodo.5646668.svg", 
                                               badge_1L_chr)
                                      })
  logos_chr <- purrr::map_chr(pkg_extensions_tb$pt_ns_chr, 
                              ~paste0("https://ready4-dev.github.io/", .x, "/logo.png"))
  homepages_chr <- pkg_extensions_tb$Link
  pkg_extensions_tb <- pkg_extensions_tb %>% dplyr::mutate(Purpose = Title %>% 
                                                             purrr::map2_chr(pt_ns_chr, ~stringr::str_remove(.x, paste0(.y, 
                                                                                                                        ": ")))) %>% dplyr::rename(Package = Logo, Website = Link, 
                                                                                                                                                   Examples = Vignettes_URLs)
  pkg_extensions_tb <- pkg_extensions_tb %>% dplyr::mutate(Examples = purrr::map(Examples, 
                                                                                 ~if (is.na(.x[1])) {
                                                                                   ""
                                                                                 }
                                                                                 else {
                                                                                   .x
                                                                                 })) %>% dplyr::mutate(Documentation = purrr::pmap(list(manual_urls_ls, 
                                                                                                                                        Citation, Website), ~{
                                                                                                                                          if (identical(..1, character(0)) | is.na(..1[1]) | length(..1) != 
                                                                                                                                              2) {
                                                                                                                                            manual_txt_chr <- character(0)
                                                                                                                                          }
                                                                                                                                          else {
                                                                                                                                            manual_txt_chr <- c("Manual - Short (PDF)", "Manual - Full (PDF)")
                                                                                                                                          }
                                                                                                                                          kableExtra::cell_spec(c("Citation", "Website", manual_txt_chr), 
                                                                                                                                                                "html", link = c(..2, ..3, ..1))
                                                                                                                                        })) %>% dplyr::mutate(Code = purrr::map(code_urls_ls, ~{
                                                                                                                                          if (is.na(.x[1])) {
                                                                                                                                            ""
                                                                                                                                          }
                                                                                                                                          else {
                                                                                                                                            kableExtra::cell_spec(c("Dev", "Archive"), "html", 
                                                                                                                                                                  link = .x)
                                                                                                                                          }
                                                                                                                                        })) %>% dplyr::select(Type, Package, Purpose, Documentation, 
                                                                                                                                                              Code, Examples)
  pkg_extensions_kbl <- pkg_extensions_tb %>% kableExtra::kable("html", 
                                                                escape = FALSE) %>%
    kableExtra::kable_styling(bootstrap_options = c("hover",
                                                    "condensed")) %>%
    kableExtra::column_spec(which(names(pkg_extensions_tb) == "Type"),
                            image = ready4_badges_chr) %>%
    kableExtra::column_spec(which(names(pkg_extensions_tb) == "DOI"),
                            image = zenodo_badges_chr) %>%
    kableExtra::column_spec(which(names(pkg_extensions_tb) == "Package"), 
                            image = kableExtra::spec_image(logos_chr, 
                                                           height = 160, width = 160)) %>%
    kableExtra::column_spec(which(names(pkg_extensions_tb) == "Website"),
                            link = homepages_chr) 
  if(is_single_1L_lgl){
    code_ls <- pkg_extensions_kbl[1] %>% strsplit(split = "<tr>") 
    code_ls <- code_ls[[1]][-3]
    pkg_extensions_kbl[1] <- code_ls %>% paste0(collapse = "")
  }
  
  pkg_extensions_kbl <- pkg_extensions_kbl %>%
    add_scroll_box(scroll_height_1L_chr = scroll_height_1L_chr, 
                   scroll_width_1L_chr = scroll_width_1L_chr, ...)
  return(pkg_extensions_kbl)
}



 







