#' Make a request to Serpstat API endpoint
#'
#' @param api_token Serpstat API token from the
#'   \href{https://serpstat.com/users/profile/}{profile page}.
#' @param api_method Internal name of API method.
#' @param api_params A list of API parameters used by api_method. More
#'   information about parameters in the
#'   \href{https://serpstat.com/api/}{official docs}.
#' @return The list with a response data.
#' @examples
#' \donttest{
#' api_params <- list(
#'   query = 'serpstat.com',
#'   page  = 1,
#'   size  = 5
#'   )
#' tryCatch({
#'   serpstatr:::sst_call_api_method(
#'     api_token  = Sys.getenv('SERPSTAT_API_TOKEN'),
#'     api_method = 'SerpstatLimitsProcedure.getStats',
#'     api_params = api_params
#'     )
#' })
#' }
sst_call_api_method <- function(api_token, api_method, api_params = NULL) {
  tryCatch({
    api_response <- httr::POST(
      url    = 'http://api.serpstat.com/v4',
      body   = list(
        id     = as.numeric(Sys.time()) * 1000,
        method = api_method,
        params = api_params
        ),
      encode = 'json',
      httr::add_headers(token = api_token)
      )
    api_response <- httr::content(api_response)

    if('list' %in% class(api_response)) {
      return(api_response)
    } else {
      stop(
        paste0(
          'There is a problem with Serpstat API. If you get this error, ',
          'please contact support at https://serpstat.com/support/ ',
          'with the details of what you are doing.'
          )
        )
    }
  }, error = function(e) {
    print(e)
  })
}

#' Preprocess the API response
#'
#' Every API call returns a JSON object. This object is transformed to a list.
#' Depending on return_method parameter the data element of this list will be a
#' list or data.frame.
#'
#' @param response_content The result of \code{\link{sst_call_api_method}} call.
#' @param return_method Accepted values are 'list' to return data object as list
#'   or 'df' to return data object as data.frame.
#' @return response_content with a data object as list or data.frame.
sst_return_check <- function(response_content, return_method) {

  if(!return_method %in% c('list', 'df')) {
    stop('return_method should be one of \'list\' or \'df\'')
  }

  if(!is.null(response_content$error)) {
    return(
      list(
        job_id = response_content$id,
        error  = response_content$error
      )
    )
  }

  if(is.null(response_content$result$data)) {
    final_data <- response_content$result
  } else {
    final_data <- response_content$result$data
  }

  if(return_method != 'list') {
    final_data <- sst_lists_to_df(final_data)
  }
  return(
    list(
      job_id       = response_content$id,
      data         = final_data,
      summary_info = response_content$result$summary_info
    )
  )
}

#' Convert list of lists to data.frame
#'
#' API response might contain nested lists with different number of elements.
#' This function fills missing elements and combine lists to a
#' data.frame.
#'
#' @param lists - a list of nested lists with different number of elements
#' @param fill - a value to fill missing values in lists
#' @return A data.frame with all missing values filed with specified value.
#' @examples
#' sst_lists_to_df(
#'   lists = list(
#'     first_list  = list(a = 1, b = 2),
#'     second_list = list(a = 2, c = 3)
#'   ),
#'   fill  = 'empty'
#' )
#' @export
sst_lists_to_df <- function(lists, fill = NA){
  column_names  <- unique(unlist(lapply(lists, names)))
  if(!is.null(column_names)){
    lists <- lapply(lists, function(x){
      single_list <- c(
        x,
        sapply(setdiff(column_names, names(x)), function(y) fill)
        )
      single_list <- single_list[order(names(single_list))]
    })
  }
  data_frame <- data.frame(do.call(rbind, lists),
                           row.names        = NULL,
                           stringsAsFactors = FALSE)
  if(is.null(column_names)) names(data_frame) <- 'column'
  return(data_frame)
}
