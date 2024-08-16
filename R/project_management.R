#' Create a new project
#'
#' Creates a new project in Serpstat.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/project-creation/}{here}.
#'
#' @section API credits consumption: 1 project credit.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param domain (required) Domain to get data for.
#' @param name (required) The name of the project. Can be different from the
#'   domain.
#' @param groups (optional) A list of project groups the project should be added
#'   to.
#' @return Returns the project ID for the created project.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_pm_create_project(
#'   api_token = api_token,
#'   domain    = 'serpstat.com',
#'   name      = 'Serpstat'
#'   )$data$project_id
#' }
#' @export
sst_pm_create_project <- function(
    api_token,
    domain,
    name,
    groups = NULL
    ){
  api_params <- list(
    domain = domain,
    name   = name,
    groups = groups
    )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'ProjectProcedure.createProject',
    api_params = api_params
    )
  return(response_content)
}

#' Delete the existing project
#'
#' Deletes the existing project in Serpstat by project ID.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/project-deletion/}{here}.
#'
#' @section API credits consumption: returns 1 project credit.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param project_id (required) ID of the project in Serpstat.
#' @return Returns the state of the deletion operation.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_pm_delete_project(
#'   api_token  = api_token,
#'   project_id = 12345
#'   )
#' }
#' @export
sst_pm_delete_project <- function(api_token, project_id = NULL){
  api_params       <- list(project_id = project_id)
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'ProjectProcedure.deleteProject',
    api_params = api_params
    )
  return(response_content)
  }

#' List existing projects
#'
#' Gets a list of existing projects available for the users with their basic
#' information.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/get-list-of-projects/}{here}.
#'
#' @section API credits consumption: 0.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns basic information on all the projects.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_pm_list_projects(
#'   api_token  = api_token,
#'   page       = 2,
#'   size       = 10
#'   )
#' }
#' @export
sst_pm_list_projects <- function(
    api_token,
    page          = 1,
    size          = 100,
    return_method = 'list'
    ){
  api_params       <- list(page = page, size = size)
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'ProjectProcedure.getProjects',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}
