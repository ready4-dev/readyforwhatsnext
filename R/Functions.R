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




 







