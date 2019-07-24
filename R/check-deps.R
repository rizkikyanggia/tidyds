#' Check dependency
#'
#' Check if the required packages is already installed or not.
#'
#' @param path path of directory
#'
#' @importFrom devtools as.package
#' @importFrom utils installed.packages
#' @importFrom usethis ui_done ui_oops ui_value ui_code
check_deps <- function(path =  ".") {
  pkg <- devtools::as.package(path)
  pkgs <- unlist(strsplit(gsub("\\n|\\s", "", x = pkg$imports), ","))
  for (i in seq_along(pkgs)) {
    if (pkgs[[i]] %in% installed.packages()[, 1]) {
      usethis::ui_done(paste(usethis::ui_value(pkgs[[i]]), "is already installed"))
    } else {
      usethis::ui_oops(paste(usethis::ui_value(pkgs[[i]]), "is not yet installed. Please run", usethis::ui_code(paste0('install.packages("', pkgs[[i]], '")'))))
    }
  }
}
