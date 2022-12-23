require(XML)
require(shinydashboard)
require(DependenciesGraphs)
require(ready4use)
require(ready4show)
require(ready4pack)
require(TTU)
require(youthu)
require(mychoice)
require(heterodox)
require(youthvars)
make_framework_pkgs_chr <- function(){
  framework_pkgs_chr <- c("ready4","ready4fun","ready4class","ready4pack","ready4use","ready4show")
  return(framework_pkgs_chr)
}
make_modules_pks_chr <- function(what_chr = "all"){
  modules_pks_chr <- character(0)
  if("people" %in% what_chr | "all" %in% what_chr)
    modules_pks_chr <- c(modules_pks_chr,
                         c("youthvars","scorz","specific","TTU","youthu","mychoice","heterodox"))
  if("places" %in% what_chr)
    modules_pks_chr <- c(modules_pks_chr,
                         character(0))
  if("platforms" %in% what_chr)
    modules_pks_chr <- c(modules_pks_chr,
                         ccharacter(0))
  if("programs" %in% what_chr)
    modules_pks_chr <- c(modules_pks_chr,
                         c("bimp"))
  return(modules_pks_chr)
} 
make_network_plt <- function(dependencies_fn,
                             functions_xx = NULL,
                             pkgs_chr = character(0)){
  framework_pkgs_chr <- make_framework_pkgs_chr()
  modules_pks_chr <- make_modules_pks_chr()
  if(identical(pkgs_chr,character(0)))
    pkgs_chr <- c(framework_pkgs_chr, modules_pks_chr)
  if(is.null(functions_xx)){
    functions_xx <- rlang::exec(dependencies_fn,
                                pkgs_chr)
  }
  nodes_tb <- functions_xx[[1]] 
  nodes_tb <- nodes_tb %>%
    dplyr::mutate(group = dplyr::case_when(label == "ready4" ~ "foundation",
                                           label %in% framework_pkgs_chr[framework_pkgs_chr != "ready4"] ~ "authoring",
                                           label %in% modules_pks_chr ~ "modules",
                                           T ~ "third party"))
  # nodes_tb$group <- c("ready4 foundation",
  #                     rep("ready4 authoring",length(framework_pkgs_chr)-1),
  #                     rep("ready4 module",length(modules_pks_chr)),
  #                     rep("Third party dependency",nrow(nodes_tb)-(length(framework_pkgs_chr)+length(modules_pks_chr))))
  edges_tb <- functions_xx[[2]]
  network_plt <- visNetwork::visNetwork(nodes_tb, edges_tb) %>%
    visNetwork::visGroups(groupname = "foundation", color = "orange",  shadow = list(enabled = TRUE)) %>%
    visNetwork::visGroups(groupname = "authoring", color = "darkred" ,  shadow = list(enabled = TRUE))  %>%
    visNetwork::visGroups(groupname = "module", color = "green",  shadow = list(enabled = TRUE))  %>%
    visNetwork::visGroups(groupname = "third party", color = "grey",  shadow = list(enabled = TRUE))  %>%
    visNetwork::visEdges(arrows = "from") %>% 
    visNetwork::visOptions(highlightNearest = TRUE, 
                           selectedBy = "group",
                           nodesIdSelection = list(enabled = TRUE,
                                                   selected = "1")) %>% 
    visNetwork::visInteraction(dragNodes = T) %>% 
    visNetwork::visPhysics(solver = "repulsion", stabilization = list(enabled = FALSE, iterations = 5000, onlyDynamicEdges = FALSE)) %>%
    visNetwork::visLegend()
  return(network_plt)
}

curentd2 <<- NULL
curentd1 <<- NULL
curentd3 <<- NULL
 
