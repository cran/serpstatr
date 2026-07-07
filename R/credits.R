#' getAuditStats
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ulxuqx7ekbs4q-get-audit-stats}{here}.
#'
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_cr_get_audit_stats <- function(
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatLimitsProcedure.getAuditStats',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

