#' addKeywordListFreq
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/c18po8yuu2j06-add-keyword-list-freq}{here}.
#'
#' @param keywords (required) Keywords to get metrics (max 50000)
#' @param region_id (required) 
#' @param type_id (optional) 
#' @param search_engine_id (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_vc_add_keyword_list_freq <- function(
    keywords,
    region_id,
    type_id = NULL,
    search_engine_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keywords = keywords,
        regionId = region_id,
        typeId = type_id,
        seId = search_engine_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatTaskProcedure.addKeywordListFreq',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getTaskResult
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/v91plc4ro30g6-get-task-result}{here}.
#'
#' @param task_id (required) 
#' @param page (optional) Page number
#' @param page_size (optional) Number of results per a page
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_vc_get_task_result <- function(
    task_id,
    page = 1,
    page_size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        taskId = task_id,
        page = page,
        pageSize = page_size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatTaskProcedure.getTaskResult',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getTaskStatus
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ysi42jt8k737w-get-task-status}{here}.
#'
#' @param task_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_vc_get_task_status <- function(
    task_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        taskId = task_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatTaskProcedure.getTaskStatus',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

