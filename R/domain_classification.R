#' addTask
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/6bxxs5y9y3pf5-add-task}{here}.
#'
#' @param domains (required) An array of domain names
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_dc_add_task <- function(
    domains,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        domains = domains
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'DomainClassification.addTask',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getTask
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/cr2rhxq0g4qeh-get-task}{here}.
#'
#' @param task_id (required) Task identifier
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_dc_get_task <- function(
    task_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        task_id = task_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'DomainClassification.getTask',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getTaskList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/v4t7hbaw82qal-get-task-list}{here}.
#'
#' @param page (required) Page number in response
#' @param size (required) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_dc_get_task_list <- function(
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'DomainClassification.getTaskList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

