#' activateUser
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/2uviz6u84c92z-activate-user}{here}.
#'
#' @param user_id (required) User identifier at Serpstat.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_tm_activate_user <- function(
    user_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        user_id = user_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'TeamManagement.activateUser',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addUser
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/eugask0z2vg4e-add-user}{here}.
#'
#' @param email (required) user email
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_tm_add_user <- function(
    email,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        email = email
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'TeamManagement.addUser',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/9565ktu8y7f0f-get-list}{here}.
#'
#' @param search (optional) Optional part of email of member you need to find
#' @param page (optional) page number for pagination
#' @param size (optional) records per page
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_tm_get_list <- function(
    search = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        search = search,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'TeamManagement.getList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deactivateUser
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/b0ui1egjoh609-deactivate-user}{here}.
#'
#' @param user_id (required) User identifier at Serpstat. Can be obtained via `TeamManagement.getList` method
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_tm_deactivate_user <- function(
    user_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        user_id = user_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'TeamManagement.deactivateUser',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' removeUser
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/1jznkuymvwuh7-remove-user}{here}.
#'
#' @param user_id (required) User id at Serpstat. Can be found using `TeamManagement.getList` method.
#' @param merge_projects (required) `true` - transfer user's projects to the team owner.
#'   `false` - projects will be deleted
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_tm_remove_user <- function(
    user_id,
    merge_projects,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        user_id = user_id,
        merge_projects = merge_projects
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'TeamManagement.removeUser',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

