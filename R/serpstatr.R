#' serpstatr:  Serpstat API wrapper for R.
#'
#' The serpstatr package currently covers only main search analytics API
#' functions. All the names of the functions start with \code{sst_} to reduce
#' the name conflict with other packages.
#'
#' All the required arguments are checked by the API endpoint. So you would not
#' get an error in R but the response would contain \code{error} object.
#'
#' @section Search analytics functions:
#' The names of these functions start with \code{sst_sa_}
#' \itemize{
#'   \item \code{\link{sst_sa_database_info}}
#'   \item \code{\link{sst_sa_stats}}
#'   \item \code{\link{sst_sa_domains_info}}
#'   \item \code{\link{sst_sa_domain_keywords}}
#'   \item \code{\link{sst_sa_keywords_info}}
#'   \item \code{\link{sst_sa_keywords}}
#'   \item \code{\link{sst_sa_keyword_top}}
#' }
#'
#' @section Helper functions:
#' \itemize{
#'   \item \code{\link{sst_lists_to_df}}
#' }
#'
#' @docType package
#' @name serpstatr
NULL
