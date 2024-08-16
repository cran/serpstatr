#' Backlinks summary
#'
#' Returns the overview of the backlinks profile for the domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/887-summary-report-getsummaryv2-new-version/}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for
#'   domain only (site.com). See API docs for more details.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns aggregated backlinks data for the domain.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_bl_domain_summary(
#'   api_token     = api_token,
#'   domain        = 'serpstat.com',
#'   search_type   = 'domain',
#'   return_method = 'list'
#' )$data
#' }
#' @export
sst_bl_domain_summary <- function(
    api_token,
    domain,
    search_type   = 'domain',
    return_method = 'list'
)
{
  api_params      <- list(
    query      = domain,
    searchType = search_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getSummaryV2',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Referring domains
#'
#' Returns the list of referring domains with main backlinks metrics for each
#' domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/312-reffering-domains/}{here}.
#'
#' @section API credits consumption: 1 per each domain in response.
#'
#' @section Sorting:
#'   You can sort the response using \code{sort} argument. The sorting order is
#'   defined using \code{order} argument.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param domain (required) A domain name to analyze.
#' @param search_type (required) Default value is 'domain' for domain data only
#'   (site.com). See API docs for more details.
#' @param page (optional) Response page number if there are many pages in response.
#'   Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param sort (optional) A field to sort the response. Default is
#'   'domain_rank'. See API docs for more details.
#' @param order (optional)  The order of sorting. Default is 'desc' for
#'   descending order. See API docs for more details.
#' @param filter (optional) The nested list of filtering options. See API docs
#'   for more details.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns aggregated backlinks data for each referring domain.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_bl_referring_domains(
#'   api_token        = api_token,
#'   domain           = 'serpstat.com',
#'   page             = 1,
#'   size             = 100,
#'   sort             = 'domain_rank',
#'   order            = 'desc',
#'   filter           = NULL,
#'   return_method    = 'list'
#' )$data
#' }
#' @export
sst_bl_referring_domains <- function(
    api_token,
    domain,
    search_type      = 'domain',
    page             = 1,
    size             = 100,
    sort             = 'domain_rank',
    order            = 'desc',
    filter           = NULL,
    return_method    = 'list'
)
{
  api_params      <- list(
    query         = domain,
    searchType    = search_type,
    page          = page,
    size          = size,
    sort          = sort,
    order         = order,
    complexFilter = filter
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getRefDomains',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}
