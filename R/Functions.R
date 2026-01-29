library(ready4)
# library(tidyRSS)
# library(zen4R) # https://cran.r-project.org/web/packages/zen4R/vignettes/zen4R.html#package_overview
# get_excluded_repos <- function (gh_repo_1L_chr = "ready4-dev/ready4", gh_tag_1L_chr = "Documentation_0.0"){
#   exclude_chr <- NULL
#   dmt_urls_xx <- get_gracefully(NULL, fn = piggyback::pb_download_url, 
#                                 args_ls = list(repo = gh_repo_1L_chr, tag = gh_tag_1L_chr, 
#                                                .token = ""), not_chr_1L_lgl = FALSE)
#   if (!is.null(dmt_urls_xx)) {
#     dmt_urls_chr <- dmt_urls_xx
#     if (any(dmt_urls_chr %>% endsWith("exclude_chr.RDS"))) {
#       exclude_chr <- get_gracefully(dmt_urls_chr[dmt_urls_chr %>% 
#                                                    endsWith("exclude_chr.RDS")], not_chr_1L_lgl = FALSE)
#     } else {
#       exclude_chr <- character(0)
#     }
#   }
#   return(exclude_chr)
# }
# 
# make_code_releases_tbl <- function (repo_type_1L_chr = c("Framework", "Module", "Package", 
#                                                          "Program", "Subroutine", "Program_and_Subroutine"), as_kbl_1L_lgl = TRUE, 
#                                     brochure_repos_chr = character(0), exclude_chr = character(0), 
#                                     format_1L_chr = "%d-%b-%Y", framework_repos_chr = character(0), 
#                                     gh_repo_1L_chr = "ready4-dev/ready4", gh_tag_1L_chr = "Documentation_0.0", 
#                                     model_repos_chr = character(0), program_repos_chr = character(0), 
#                                     org_1L_chr = "ready4-dev", repos_chr = character(0), subroutine_repos_chr = character(0), 
#                                     tidy_desc_1L_lgl = TRUE, url_stub_1L_chr = "https://ready4-dev.github.io/", 
#                                     ...) 
# {
#   if (!requireNamespace("tidyRSS", quietly = TRUE)) {
#     stop("tidyRSS package is required - please install it and rerun the last command.")
#   }
#   repo_type_1L_chr <- match.arg(repo_type_1L_chr)
#   releases_xx <- NULL
#   if (identical(brochure_repos_chr, character(0))) {
#     brochure_repos_chr <- "ready4web"
#   }
#   if (identical(exclude_chr, character(0))) {
#     exclude_chr <- get_excluded_repos(gh_repo_1L_chr = gh_repo_1L_chr, 
#                                       gh_tag_1L_chr = gh_tag_1L_chr)
#   }
#   if (identical(framework_repos_chr, character(0))) {
#     framework_repos_chr <- make_framework_pkgs_chr(gh_repo_1L_chr = gh_repo_1L_chr, 
#                                                    gh_tag_1L_chr = gh_tag_1L_chr)
#   }
#   if (identical(model_repos_chr, character(0))) {
#     model_repos_chr <- make_modules_pkgs_chr(gh_repo_1L_chr = gh_repo_1L_chr, 
#                                              gh_tag_1L_chr = gh_tag_1L_chr, what_chr = "all")
#   }
#   if (identical(subroutine_repos_chr, character(0))) {
#     subroutine_repos_chr <- get_subroutine_repos(gh_repo_1L_chr = gh_repo_1L_chr, 
#                                                  gh_tag_1L_chr = gh_tag_1L_chr)
#   }
#   if (!is.null(exclude_chr) && !is.null(framework_repos_chr) && 
#       !is.null(model_repos_chr) && !is.null(subroutine_repos_chr)) {
#     if (identical(program_repos_chr, character(0))) {
#       program_repos_chr <- setdiff(get_gh_repos(org_1L_chr), 
#                                    c(brochure_repos_chr, exclude_chr, framework_repos_chr, 
#                                      model_repos_chr, subroutine_repos_chr))
#     }
#     if (identical(repos_chr, character(0))) {
#       if (repo_type_1L_chr == "Framework") {
#         repos_chr <- framework_repos_chr
#       }
#       if (repo_type_1L_chr == "Module") {
#         repos_chr <- model_repos_chr
#       }
#       if (repo_type_1L_chr %in% c("Program", "Subroutine", 
#                                   "Program_and_Subroutine")) {
#         if (repo_type_1L_chr == "Subroutine") {
#           repos_chr <- subroutine_repos_chr
#         }
#         if (repo_type_1L_chr == "Program") {
#           repos_chr <- program_repos_chr
#         }
#         if (repo_type_1L_chr == "Program_and_Subroutine") {
#           repos_chr <- c(program_repos_chr, subroutine_repos_chr)
#         }
#       }
#       else {
#         repo_type_1L_chr <- "Package"
#       }
#     }
#     releases_xx <- repos_chr %>% purrr::map_dfr(~get_gracefully(paste0("https://github.com/", 
#                                                                        org_1L_chr, "/", .x, "/releases.atom"), fn = tidyRSS::tidyfeed, 
#                                                                 not_chr_1L_lgl = TRUE))
#     if (nrow(releases_xx) == 0) {
#       releases_xx <- NULL
#     }
#     if (!is.null(releases_xx)) {
#       releases_xx <- releases_xx %>% dplyr::arrange(dplyr::desc(.data$entry_last_updated)) %>% 
#         dplyr::select("feed_title", "entry_title", "entry_last_updated", 
#                       "entry_content", "entry_link") %>% dplyr::mutate(feed_title = .data$feed_title %>% 
#                                                                          stringr::str_remove_all("Release notes from ")) %>% 
#         dplyr::rename(`:=`(!!rlang::sym(repo_type_1L_chr), 
#                            "feed_title"), Release = "entry_title", Date = "entry_last_updated", 
#                       Description = "entry_content", URL = "entry_link") %>% 
#         dplyr::filter(.data$Release != "Documentation_0.0")
#       if (tidy_desc_1L_lgl) {
#         releases_xx <- releases_xx %>% dplyr::mutate(Description = .data$Description %>% 
#                                                        purrr::map2_chr(!!rlang::sym(repo_type_1L_chr), 
#                                                                        ~stringr::str_remove(.x, paste0(.y, ": "))))
#       }
#       if (as_kbl_1L_lgl) {
#         releases_xx <- releases_xx %>% dplyr::mutate(Release = .data$Release %>% 
#                                                        stringr::str_remove_all("Release ") %>% stringr::str_remove_all("v") %>% 
#                                                        kableExtra::cell_spec(format = "html", link = .data$URL), 
#                                                      Date = .data$Date %>% format.Date(format_1L_chr) %>% 
#                                                        as.character()) %>% dplyr::select("Date", 
#                                                                                          !!rlang::sym(repo_type_1L_chr), "Release", 
#                                                                                          "Description")
#         if (repo_type_1L_chr %in% c("Package", "Module", 
#                                     "Framework")) {
#           logos_chr <- purrr::map_chr(releases_xx %>% 
#                                         dplyr::pull(repo_type_1L_chr), ~paste0(url_stub_1L_chr, 
#                                                                                .x, "/logo.png"))
#           releases_xx <- releases_xx %>% dplyr::mutate(`:=`(!!rlang::sym(repo_type_1L_chr), 
#                                                             ""))
#           indx_1L_int <- which(names(releases_xx) %in% 
#                                  c("Package", "Module", "Framework"))
#         }
#         releases_xx <- releases_xx %>% kableExtra::kable("html", 
#                                                          escape = FALSE) %>% kableExtra::kable_styling(...)
#         if (repo_type_1L_chr %in% c("Package", "Module", 
#                                     "Framework")) 
#           releases_xx <- releases_xx %>% kableExtra::column_spec(indx_1L_int, 
#                                                                  image = kableExtra::spec_image(logos_chr, 
#                                                                                                 height = 160, width = 160))
#       }
#     }
#   }
#   return(releases_xx)
# }
# make_programs_tbl <- function (what_1L_chr = c("Program", "Subroutine", "Program_and_Subroutine"), 
#                                as_kbl_1L_lgl = FALSE, exclude_chr = character(0), format_1L_chr = "%d-%b-%Y", 
#                                gh_repo_1L_chr = "ready4-dev/ready4", gh_tag_1L_chr = "Documentation_0.0", 
#                                org_1L_chr = "ready4-dev",
#                                tidy_desc_1L_lgl = TRUE, url_stub_1L_chr = "https://ready4-dev.github.io/", 
#                                zenodo_1L_chr = "ready4", ...) 
# {
#   if (!requireNamespace("zen4R", quietly = TRUE)) {
#     stop("zen4R package is required - please install it and rerun the last command.")
#   }
#   what_1L_chr <- match.arg(what_1L_chr)
#   programs_xx <- make_code_releases_tbl(what_1L_chr, as_kbl_1L_lgl = FALSE, 
#                                         exclude_chr = exclude_chr, gh_repo_1L_chr = gh_repo_1L_chr, 
#                                         gh_tag_1L_chr = gh_tag_1L_chr, org_1L_chr = org_1L_chr,
#                                         tidy_desc_1L_lgl = FALSE, 
#                                         url_stub_1L_chr = url_stub_1L_chr)
#   if (!is.null(programs_xx)) {
#     programs_xx <- programs_xx %>% dplyr::group_by(!!rlang::sym(what_1L_chr)) %>% 
#       dplyr::filter(dplyr::row_number() == 1) %>% dplyr::arrange(!!rlang::sym(what_1L_chr)) %>% 
#       dplyr::ungroup()
#     zenodo_xx <- zen4R::ZenodoManager$new()
#     community_ls <- zenodo_xx$getCommunityById(zenodo_1L_chr)
#     records_chr <- readLines(url(community_ls$links$records))
#     records_chr <- records_chr %>% strsplit("\\{\"created\": ") %>% 
#       purrr::pluck(1)
#     records_chr <- records_chr[2:length(records_chr)]
#     records_ls <- records_chr %>% purrr::map(~{
#       individual_chr <- .x %>% strsplit(",") %>% purrr::pluck(1)
#       individual_chr[individual_chr %>% purrr::map_lgl(~startsWith(.x, 
#                                                                    " \"doi_url\"") | startsWith(.x, " \"metadata\"") | 
#                                                          startsWith(.x, " \"description\""))]
#     })
#     indices_int <- programs_xx$Description %>% purrr::map2_int(programs_xx %>% 
#                                                                  dplyr::pull(1), ~{
#                                                                    description_1L_chr <- .x
#                                                                    title_1L_chr <- .y
#                                                                    index_1L_int <- which(records_ls %>% purrr::map_lgl(~{
#                                                                      any(.x %>% purrr::map_lgl(~{
#                                                                        modified_1L_chr <- gsub("<.*?>", "", .x) %>% 
#                                                                          stringr::str_remove_all("\\\\n") %>% stringr::str_remove(" \"description\": \"") %>% 
#                                                                          stringr::str_remove("\"")
#                                                                        stringr::str_equal(modified_1L_chr, description_1L_chr) | 
#                                                                          stringr::str_detect(modified_1L_chr, description_1L_chr)
#                                                                      })) | .x[2] %>% stringr::str_remove(" \"metadata\": \\{\"title\": \"") %>% 
#                                                                        startsWith(paste0(title_1L_chr, ":"))
#                                                                    }))
#                                                                    ifelse(identical(index_1L_int, integer(0)), NA_integer_, 
#                                                                           index_1L_int)
#                                                                  })
#     programs_xx$DOI <- indices_int %>% purrr::map_chr(~records_ls[[.x]][1] %>% 
#                                                         strsplit("\"") %>% purrr::pluck(1) %>% purrr::pluck(4))
#     programs_xx$GitHub <- gsub("/releases/.*", "", programs_xx$URL)
#     if (tidy_desc_1L_lgl) 
#       programs_xx <- programs_xx %>% dplyr::mutate(Description = .data$Description %>% 
#                                                      purrr::map2_chr(!!rlang::sym(what_1L_chr), ~stringr::str_remove(.x, 
#                                                                                                                      paste0(.y, ": "))))
#     if (as_kbl_1L_lgl) {
#       programs_xx <- programs_xx %>% dplyr::mutate(Release = .data$Release %>% 
#                                                      stringr::str_remove_all("Release ") %>% stringr::str_remove_all("v"), 
#                                                    Date = .data$Date %>% format.Date(format_1L_chr) %>% 
#                                                      as.character()) %>% dplyr::mutate(Source = purrr::pmap(list(.data$GitHub, 
#                                                                                                                  .data$DOI), ~{
#                                                                                                                    kableExtra::cell_spec(c("Dev", "Archive"), format = "html", 
#                                                                                                                                          link = c(..1, ..2))
#                                                                                                                  })) %>% dplyr::select(!!rlang::sym(what_1L_chr), 
#                                                                                                                                        "Release", "Date", "Description", "Source")
#       programs_xx <- programs_xx %>% kableExtra::kable("html", 
#                                                        escape = FALSE) %>% kableExtra::kable_styling(...)
#     }
#   }
#   return(programs_xx)
# }


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