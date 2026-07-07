#' Add crawling task
#'
#' Submits keywords to crawl regular SERP and local results.
#'
#' @section API docs:
#'  Check all the values for request and response fields
#'  \href{https://api-docs.serpstat.com/docs/serpstat-public-api/fd78zl20ap9w1-add-task}{here}.
#'
#' @section API credits consumption:
#'  Depends on the number of keywords and pages to parse.
#'
#' @param keywords (required) A character vector or comma-separated string of
#'   keywords.
#' @param country_id (required) Country identifier (e.g. 23 for United States).
#'   Range: 1-247.
#' @param se_id (optional) Search engine ID. Default is 1 (Google).
#' @param region_id (optional) Region or city identifier.
#' @param language_id (optional) Language ID. Default is 1 (English).
#'   Range: 1-48.
#' @param device_type_id (optional) Device type ID. Default is 1 (Desktop).
#'   Range: 1-2.
#' @param results_type (optional) Type of Google results. Default is
#'   "regular_aio". Allowed values: "regular", "local", "regular_aio".
#' @param pages (optional) Number of SERP pages to parse. Default is 1.
#'   Range: 1-10.
#' @param api_token (optional) Serpstat API token. Default is
#'   Sys.getenv("SERPSTAT_API_TOKEN").
#' @param return_method (optional) Accepted values are "list" (default) to
#'   return data object as list or "df" to return data object as data.frame.
#' @return Returns the task ID.
#' @examples
#' \dontrun{
#' sst_sc_add_task(
#'   keywords = c("explain the gauss rifle principle",
#'                "why iphone better than samsung"),
#'   country_id = 23
#' )
#' }
#' @export
sst_sc_add_task <- function(
  keywords,
  country_id,
  se_id          = 1,
  region_id      = NULL,
  language_id    = 1,
  device_type_id = 1,
  results_type   = "regular_aio",
  pages          = 1,
  api_token      = Sys.getenv("SERPSTAT_API_TOKEN"),
  return_method  = "list"
) {

  api_params <- list(
    keywords  = paste(keywords, collapse = ","),
    seId      = se_id,
    countryId = as.integer(country_id)
  )

  if (!is.null(region_id)) {
    api_params$regionId <- as.integer(region_id)
  }
  if (!is.null(language_id)) {
    api_params$langId <- as.integer(language_id)
  }
  if (!is.null(device_type_id)) {
    api_params$typeId <- as.integer(device_type_id)
  }
  if (!is.null(results_type)) {
    api_params$type <- as.character(results_type)
  }
  if (!is.null(pages)) {
    api_params$pages <- as.integer(pages)
  }

  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = "tasks.addTask",
    api_params = api_params
  )

  sst_return_check(response_content, return_method)
}

#' Get crawling task result
#'
#' Retrieves parsing results of a crawling task.
#'
#' @section API docs:
#'  Check all the values for request and response fields
#'  \href{https://api-docs.serpstat.com/docs/serpstat-public-api/50bwxkycuia8p-get-task-result}{here}.
#'
#' @section API credits consumption: 0
#'
#' @param task_id (required) Crawling identifier.
#' @param page (optional) Page number for pagination. Results are grouped in
#'   pages of 100 keywords. Default is 1.
#' @param api_token (optional) Serpstat API token. Default is
#'   Sys.getenv("SERPSTAT_API_TOKEN").
#' @param return_method (optional) Accepted values are "list" (default) to
#'   return data object as list or "df" to return data object as data.frame.
#' @return Returns the parsing results for the specified task.
#' @examples
#' \dontrun{
#' sst_sc_get_task_result(
#'   task_id = 5484945
#' )
#' }
#' @export
sst_sc_get_task_result <- function(
  task_id,
  page          = 1,
  api_token     = Sys.getenv("SERPSTAT_API_TOKEN"),
  return_method = "list"
) {

  api_params <- list(
    taskId = task_id,
    page   = as.integer(page)
  )

  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = "tasks.getTaskResult",
    api_params = api_params
  )

  sst_return_check(response_content, return_method)
}


#' addKeywordList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/9elengxj24hwb-add-keyword-list}{here}.
#'
#' @param keywords (required) Keywords with commas for parsing.
#'   
#'   Example: `["samsung, iphone", "nike, adidas"]`
#' @param search_engine_id (required) Search engine identifier
#'   
#'   * **1** — Google
#' @param country_id (required) 
#' @param region_id (optional) 
#' @param language_id (optional) 
#' @param type_id (optional) 
#' @param type (optional) 
#' @param pages (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sc_add_keyword_list <- function(
    keywords,
    search_engine_id,
    country_id,
    region_id = NULL,
    language_id = NULL,
    type_id = NULL,
    type = NULL,
    pages = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keywords = keywords,
        seId = search_engine_id,
        countryId = country_id,
        regionId = region_id,
        langId = language_id,
        typeId = type_id,
        type = type,
        pages = pages
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'tasks.addKeywordList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getKeywordSerp
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/bfwx6sfgzlioz-get-keyword-serp}{here}.
#'
#' @param task_id (required) 
#' @param keyword_id (required) Id number of a required keyword for getting a raw SERP (you can get it in the SERP crawling response from the method `tasks.getTaskResult`)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sc_get_keyword_serp <- function(
    task_id,
    keyword_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        taskId = task_id,
        keywordId = keyword_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'tasks.getKeywordSerp',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getParsingBalance
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/hx1b8q97pwu9y-get-parsing-balance}{here}.
#'
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sc_get_parsing_balance <- function(
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'tasks.getParsingBalance',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/2jkkku527phy7-get-list}{here}.
#'
#' @param page (optional) Page Number
#' @param page_size (optional) Page size
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sc_get_list <- function(
    page = 1,
    page_size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        page = page,
        pageSize = page_size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'tasks.getList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

