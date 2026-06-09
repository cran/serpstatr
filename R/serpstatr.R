#' serpstatr:  Serpstat API wrapper for R.
#'
#' The serpstatr package covers main Serpstat API methods. 
#' All the names of the functions start with \code{sst_} to reduce
#' the name conflict with other packages.
#'
#' All the required arguments are checked by the API endpoint. So you would not
#' get an error in R but the response would contain \code{error} object.
#'
#' @section Functions naming:
#' The names of the package functions start with \code{sst_sa_}
#' \itemize{
#'   \item \code{\link{sst_sa_database_info}}
#'   \item \code{\link{sst_sa_stats}}
#' }
#'
#' @docType package
#' @name serpstatr
#' @keywords internal 
"_PACKAGE"
