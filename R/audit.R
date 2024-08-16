#' Start a website audit
#'
#' Starts a project website audit with the current audit settings. Uses default
#' audit settings if no settings were changed.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/510-audit-start-auditsitestart/}{here}.
#'
#' @section API credits consumption: 1 audit credit for each checked page.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param project_id (required) ID of the project in Serpstat.
#' @return Returns the ID of the audit report.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_au_start(
#'   api_token  = api_token,
#'   project_id = 12345
#'   )$data$reportId
#' }
#' @export
sst_au_start <- function(api_token, project_id = NULL){
  api_params       <- list(projectId = project_id)
  response_content <- sst_call_api_method(
    api_token = api_token,
    api_method = 'AuditSite.start',
    api_params = api_params
    )
  return(response_content)
}

#' Website audit summary
#'
#' Returns the basic stats for the finished audit returns, including number of
#' checked pages, issues by priority, domain optimization score.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/516-audit-basic-information-getbasicinfo/}{here}.
#'
#' @section API credits consumption: 0.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param report_id (required) ID of the audit report to get data from.
#' @return Returns the basic metrics for audited website.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_au_get_summary(
#'   api_token = api_key,
#'   report_id = report_id
#'   )$data
#' }
#' @export
sst_au_get_summary <- function(api_token, report_id = NULL){
  api_params       <- list(reportId = report_id)
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getBasicInfo',
    api_params = api_params
    )
  return(response_content)
}
