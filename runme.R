# Run each time an RMD is changed prior to commit. [IGNORE THIS]
# blogdown::build_site(run_hugo = F, build_rmd =T)
#source("R/Functions.R")
library(ready4)
project_dir_1L_chr <- getwd()
### DOCUMENTATION SECTION
## Render itemisation of currently available ready4 libraries
c(#"Framework",
  "Libraries") %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/Model/Modules/Finding"),
                       consent_1L_chr = "Y")  
# Render ready4 library installation instructions
c("Installation") %>%
write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/Getting-started"),
                     consent_1L_chr = "Y",
                     is_rmd_1L_lgl = F)
c("Add-Metadata") %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/tutorials/using-modules"),
                       consent_1L_chr = "Y")

c("Assess-Cost-Utility", ## Add scroll box args
  "Explore-Models",
  "Map-To-Utility",
  "Predict-Choice", ## Remove }}
  #"Predict-Utility",
  "Score-Health-Utility", ## Add scroll box args
  "Validate-Variables"
  ) %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/tutorials/using-modules"),
                       consent_1L_chr = "Y",
                       is_rmd_1L_lgl = F)
c("Example_1", "Example_2") %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/tutorials/using-modules/predict-utility"),
                       consent_1L_chr = "Y", is_rmd_1L_lgl = F)
c("Standard-Cost-Data-Codes",
  "Standard-Cost-Data-Fuzzy") %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/tutorials/using-modules"),
                       consent_1L_chr = "Y",
                       is_rmd_1L_lgl = F)
write_to_render_post("Individual",
                     path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/tutorials/finding"),
                     consent_1L_chr = "Y",
                     is_rmd_1L_lgl = F)
# Render Dataset articles
# c("Ingest","Label-Data","Share-Data") %>%
# write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/framework/use/authoring-data"),
#                      consent_1L_chr = "Y",
#                      is_rmd_1L_lgl = F)
c("Search") %>%
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/model/datasets/Finding-Data"),
                       consent_1L_chr = "Y",
                       is_rmd_1L_lgl = F)
# write_to_force_links_in(paste0(project_dir_1L_chr,"/content/en/docs/model/datasets/Finding-Data/Search/index.en.md"),
#                         consent_1L_chr = "Y")
# Render program and sub-routine summaries
c("Find"#, # Check exclusions in RMD - may need to be updated.
  #"Subroutines"
  ) %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/docs/Model/Analyses"),
                       consent_1L_chr = "Y")
c(#"Find"#, # Check exclusions in RMD - may need to be updated.
  "Reporting"
) %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/docs/Model"),
                       consent_1L_chr = "Y")
c("Clinical-Primary") %>% # Do not evaluate write fns, add scroll text and then restore link to online RMD
  write_to_render_post(path_to_main_dir_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/model/analyses/Replication-Code/Make-Fakes"),
                       consent_1L_chr = "Y",
                       is_rmd_1L_lgl = F)
#write_to_trim_html(paste0(project_dir_1L_chr,"/content/en/docs/model/analyses/Replication-Code/Make-Fakes/Clincal_Primary.md"))
###
###
### BLOG SECTION
# Render release summaries
c("Posters-Datasets",
  "Instructional-Datasets"#,
  #"Framework-Taxonomies"
  ) %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/blog/releases/datasets"),
                       consent_1L_chr = "Y")
c("People-Datasets",
  "Places-Datasets"
  ) %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/blog/releases/datasets/model-data"),
                       consent_1L_chr = "Y")
# c("Framework-Libraries") %>%
#   write_to_render_post(paste0(project_dir_1L_chr,"/content/en/blog/releases/libraries"),
#                        consent_1L_chr = "Y")
c("People-Module-Libraries","Places-Module-Libraries") %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/blog/releases/libraries"),
                       consent_1L_chr = "Y")
c("Programs", # Check exclusions in RMD - may need to be updated.
  "Subroutines"
  ) %>%
  write_to_render_post(paste0(project_dir_1L_chr,"/content/en/blog/releases/executables"),
                       consent_1L_chr = "Y")
#
# write_to_copy_rmds(dir_path_1L_chr = paste0(project_dir_1L_chr,"/content/en/docs/model/modules/using-modules/People"),
#                    fl_nm_1L_chr = "TEST",
#                    rmds_dir_1L_chr = "R/RMD Templates/Include_HTML")
# c("Map-Utility/aqol6dmap_use.md",
#   "Map-Utility/ttu_lng_aqol6d_csp.md",
#   "Model-Choice/dce_sa_analysis.md",
#   "Model-Choice/dce_sa_design.md") %>%
#   purrr::walk(~write_new_credentials(paste0(paste0(project_dir_1L_chr,"/content/en/docs/model/analyses/Replication-Code/",.x),
#                                      new_credentials_1L_chr = "2623be4aa6784e3fabca41e54a08160b",
#                                      old_credentials_1L_chr = "93f800c0e2594268b9482bea99e2e434", 
#                                      consent_1L_chr = "Y"))
# Prior to deployment
# write_new_credentials("./content/en/docs/Readyforwhatsnext/Spring To Life/Modules/Predict choice.md",
#                       old_credentials_1L_chr = "2623be4aa6784e3fabca41e54a08160b",
#                       new_credentials_1L_chr = "93f800c0e2594268b9482bea99e2e434") # For local preview
## Deploy dependencies app
# library(rsconnect)
# deployApp("R/Shiny/Dependencies")
