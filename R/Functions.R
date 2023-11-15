library(ready4)
# library(tidyRSS)
# library(zen4R) # https://cran.r-project.org/web/packages/zen4R/vignettes/zen4R.html#package_overview
# Potential difference in make_ds_releases_tbl - don't delete just yet
# make_ds_releases_tbl <- function (ds_dois_chr,
#                                   format_1L_chr = "%d-%b-%Y",
#                                   key_1L_chr = NULL,
#                                   server_1L_chr = "dataverse.harvard.edu",
#                                   as_kbl_1L_lgl = T,
#                                   ...)
# {
#   ds_releases_xx <- ds_dois_chr %>% purrr::map_dfr(~{
#     meta_ls <- dataverse::dataset_versions(.x, server = server_1L_chr, key = key_1L_chr)
#     doi_1L_chr <- .x
#     1:length(meta_ls) %>%
#       purrr::map_dfr(~tibble::tibble(Date = meta_ls[[.x]]$releaseTime,
#                                      Dataset = meta_ls[[1]]$metadataBlocks$citation$fields[[1]]$value,
#                                      DOI = paste0("https://doi.org/", doi_1L_chr),
#                                      Version = paste0(meta_ls[[.x]]$versionNumber,
#                                                       ".",
#                                                       meta_ls[[.x]]$versionMinorNumber),
#                                      `Number of files` = length(meta_ls[[1]]$files)))
#   }) %>%
#     dplyr::arrange(dplyr::desc(Date)) %>%
#     dplyr::mutate(Date = Date %>%
#                     format.Date(format_1L_chr) %>%
#                     as.character()) %>%
#     dplyr::filter(!is.na(Date))
#   if (as_kbl_1L_lgl) {
#     ds_releases_xx <- ds_releases_xx %>% dplyr::mutate(Dataset = Dataset %>%
#                                                          kableExtra::cell_spec(format = "html", link = DOI)) %>%
#       dplyr::select(Date, Dataset,
#                     Version, `Number of files`)
#     ds_releases_xx <- ds_releases_xx %>%
#       kableExtra::kable("html", escape = FALSE) %>%
#       kableExtra::kable_styling(...)
#     
#   }
#   return(ds_releases_xx)
# }
# make_programs_tbl <- function(what_1L_chr = "Program",
#                               as_kbl_1L_lgl = F,
#                               exclude_chr = "dce_sa_cards",
#                               format_1L_chr = "%d-%b-%Y",
#                               gh_repo_1L_chr = "ready4-dev/ready4",
#                               gh_tag_1L_chr = "Documentation_0.0",
#                               tidy_desc_1L_lgl = T,
#                               url_stub_1L_chr = "https://ready4-dev.github.io/",
#                               zenodo_1L_chr = "ready4",
#                               ...){
#   programs_xx <- make_code_releases_tbl(what_1L_chr, as_kbl_1L_lgl = F, exclude_chr = exclude_chr,
#                                         gh_repo_1L_chr = gh_repo_1L_chr,
#                                         gh_tag_1L_chr = gh_tag_1L_chr,
#                                         tidy_desc_1L_lgl = F, url_stub_1L_chr = url_stub_1L_chr) %>%
#     dplyr::group_by(!!rlang::sym(what_1L_chr)) %>%
#     dplyr::filter(dplyr::row_number()==1) %>%
#     dplyr::arrange(!!rlang::sym(what_1L_chr)) %>%
#     dplyr::ungroup()
#   zenodo_xx <- zen4R::ZenodoManager$new()
#   community_ls <- zenodo_xx$getCommunityById(zenodo_1L_chr)
#   records_chr <- readLines(url(community_ls$links$records))
#   records_chr <- records_chr %>% strsplit("\\{\"created\": ") %>% purrr::pluck(1)
#   records_chr <- records_chr[2:length(records_chr)]
#   records_ls <- records_chr %>% purrr::map(~{
#     individual_chr <- .x %>% strsplit(",") %>% purrr::pluck(1)
#     individual_chr[individual_chr %>% purrr::map_lgl(~startsWith(.x," \"doi_url\"") | startsWith(.x," \"metadata\"") | startsWith(.x," \"description\""))]
#   })
#   indices_int <- programs_xx$Description %>% purrr::map2_int(programs_xx %>% dplyr::pull(1),~ {
#     description_1L_chr <- .x
#     title_1L_chr <- .y
#     index_1L_int <- which(records_ls %>% 
#                             purrr::map_lgl(~{any(.x %>% purrr::map_lgl(~{
#                               modified_1L_chr <- gsub("<.*?>", "", .x) %>% stringr::str_remove_all("\\\\n") %>% stringr::str_remove(" \"description\": \"") %>% stringr::str_remove("\"")
#                               stringr::str_equal(modified_1L_chr,description_1L_chr) | stringr::str_detect(modified_1L_chr,description_1L_chr) 
#                             }
#                             )) | .x[2] %>% stringr::str_remove(" \"metadata\": \\{\"title\": \"") %>% startsWith(paste0(title_1L_chr,":"))
#                             }))
#     ifelse(identical(index_1L_int,integer(0)),
#            NA_integer_,
#            index_1L_int)})
#   programs_xx$DOI <- indices_int %>%
#     purrr::map_chr(~ records_ls[[.x]][1] %>% strsplit("\"") %>% purrr::pluck(1) %>% purrr::pluck(4))
#   programs_xx$GitHub <- gsub("/releases/.*","",programs_xx$URL)
#   if(tidy_desc_1L_lgl)
#     programs_xx <- programs_xx %>%
#     dplyr::mutate(Description = Description %>%
#                     purrr::map2_chr(!!rlang::sym(what_1L_chr),
#                                     ~ stringr::str_remove(.x,paste0(.y,": "))))
#   if(as_kbl_1L_lgl){
#     programs_xx <- programs_xx  %>%
#       dplyr::mutate(Release = Release %>% stringr::str_remove_all("Release ") %>%
#                       stringr::str_remove_all("v"),
#                     Date = Date %>% format.Date(format_1L_chr) %>% as.character()) %>%
#       dplyr::mutate(Source = purrr::pmap(list(GitHub, DOI),
#                                          ~{
#                                            kableExtra::cell_spec(c("Dev", "Archive"),
#                                                                  format = "html",
#                                                                  link = c(..1, ..2))
#                                          }
#       )) %>%
#       dplyr::select(!!rlang::sym(what_1L_chr), Release, Date, Description, Source)
#     programs_xx <- programs_xx %>%
#       kableExtra::kable("html", escape = FALSE) %>%
#       kableExtra::kable_styling(...)
#   }
#   return(programs_xx)
# }