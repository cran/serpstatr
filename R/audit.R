#' Start a website audit
#'
#' Starts a project website audit with the current audit settings. Uses default
#' audit settings if no settings were changed.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/bxdwdayrka3kf-start}{here}.
#'
#' @section API credits consumption: 1 audit credit for each checked page.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
#' @param project_id (required) ID of the project in Serpstat.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns the ID of the audit report.
#' @examples
#' \dontrun{
#' sst_au_start(
#'   project_id = 12345
#'   )$data$reportId
#' }
#' @export
sst_au_start <- function(api_token = Sys.getenv('SERPSTAT_API_TOKEN'), project_id = NULL, return_method = 'list'){
  api_params       <- list(projectId = project_id)
  response_content <- sst_call_api_method(
    api_token = api_token,
    api_method = 'AuditSite.start',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Website audit summary
#'
#' Returns the basic stats for the finished audit returns, including number of
#' checked pages, issues by priority, domain optimization score.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/uup6axm96za8m-get-basic-info}{here}.
#'
#' @section API credits consumption: 0.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
#' @param report_id (required) ID of the audit report to get data from.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns the basic metrics for audited website.
#' @examples
#' \dontrun{
#' sst_au_get_summary(
#'   report_id = report_id
#'   )$data
#' }
#' @export
sst_au_get_summary <- function(api_token = Sys.getenv('SERPSTAT_API_TOKEN'), report_id = NULL, return_method = 'list'){
  api_params       <- list(reportId = report_id)
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getBasicInfo',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}


#' getReportWithoutDetails
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/poj5fmggexd0y-get-report-without-details}{here}.
#'
#' @param report_id (required) 
#' @param compare_report_id (optional) Another unique identifier for an audit report from the same project to compare
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_report_without_details <- function(
    report_id,
    compare_report_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        compareReportId = compare_report_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getReportWithoutDetails',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getErrorElements
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/b9nl4a4f1vm7z-get-error-elements}{here}.
#'
#' @param report_id (required) 
#' @param compare_report_id (required) Another unique identifier for an audit report from the same project to compare
#' @param project_id (required) 
#' @param error_name (required) 
#' @param mode (optional) Error display mode:
#'   
#'   Mode | Description
#'   ---------|----------
#'    all | all errors
#'    new | new errors
#'   solved | fixed errors
#'   
#' @param limit (optional) count of returned items in response
#' @param offset (optional) batch number required for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_error_elements <- function(
    report_id,
    compare_report_id,
    project_id,
    error_name,
    mode = NULL,
    limit = NULL,
    offset = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        compareReportId = compare_report_id,
        projectId = project_id,
        errorName = error_name,
        mode = mode,
        limit = limit,
        offset = offset
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getErrorElements',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getSubElementsByCrc
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/arshynmdh3s1q-get-sub-elements-by-crc}{here}.
#'
#' @param report_id (required) 
#' @param project_id (required) 
#' @param error_name (required) 
#' @param crc (required) URL crc
#' @param compare_report_id (optional) 
#' @param mode (optional) Error display mode:
#'   
#'   Mode | Description
#'   ---------|----------
#'    all | all errors
#'    new | new errors
#'   solved | fixed errors
#' @param limit (optional) count of returned items in response
#' @param offset (optional) batch number required for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_sub_elements_by_crc <- function(
    report_id,
    project_id,
    error_name,
    crc,
    compare_report_id = NULL,
    mode = NULL,
    limit = NULL,
    offset = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        projectId = project_id,
        errorName = error_name,
        crc = crc,
        compareReportId = compare_report_id,
        mode = mode,
        limit = limit,
        offset = offset
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getSubElementsByCrc',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getCategoriesStatistic
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/0bpj0tlgitnfu-get-categories-statistic}{here}.
#'
#' @param report_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_categories_statistic <- function(
    report_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getCategoriesStatistic',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getHistoryByCountError
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/uvufljcemtfnu-get-history-by-count-error}{here}.
#'
#' @param project_id (required) 
#' @param error_name (required) 
#' @param limit (required) count of returned items in response
#' @param offset (required) batch number required for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_history_by_count_error <- function(
    project_id,
    error_name,
    limit,
    offset,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id,
        errorName = error_name,
        limit = limit,
        offset = offset
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getHistoryByCountError',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/tp62ypjqyn61q-get-list}{here}.
#'
#' @param project_id (required) 
#' @param limit (optional) count of returned items in response
#' @param offset (optional) batch number required for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_list <- function(
    project_id,
    limit = NULL,
    offset = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id,
        limit = limit,
        offset = offset
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getScanUserUrlList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/0cm1u3jkll0vm-get-scan-user-url-list}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_scan_user_url_list <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getScanUserUrlList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getDefaultSettings
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/017jsjfwsyomu-get-default-settings}{here}.
#'
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_default_settings <- function(
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getDefaultSettings',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getSettings
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/wps54rvakd0hi-get-settings}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_settings <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.getSettings',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' setSettings
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/od01obqk4amtd-set-settings}{here}.
#'
#' @param project_id (required) 
#' @param main_settings (required) 
#' @param mail_trigger_settings (required) Trigger mail settings
#' @param schedule_settings (required) Scan schedule settings
#' @param scan_setting (required) Scan type settings
#' @param dont_scan_keywords_block (optional) The Serpstat robot will exclude pages from crawling if the URL contains any of the specified words. This setting applies when the scan type is set to Sitemap too. Optional block, defaults to `\{checked: false, keywords: ""\}`.
#' @param only_scan_keywords_block (optional) The Serpstat robot will crawl pages with the following words in the URL. The setting is relevant for the scan type Sitemap too. Optional block, defaults to `\{checked: false, keywords: ""\}`.
#' @param base_auth_block (optional) If the site is restricted access, provide access for verification. Optional block, defaults to `\{login: "", password: ""\}`.
#' @param errors_settings (optional) Optional settings for error thresholds. If omitted, default values are used.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_set_settings <- function(
    project_id,
    main_settings,
    mail_trigger_settings,
    schedule_settings,
    scan_setting,
    dont_scan_keywords_block = NULL,
    only_scan_keywords_block = NULL,
    base_auth_block = NULL,
    errors_settings = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id,
        mainSettings = main_settings,
        mailTriggerSettings = mail_trigger_settings,
        scheduleSettings = schedule_settings,
        scanSetting = scan_setting,
        dontScanKeywordsBlock = dont_scan_keywords_block,
        onlyScanKeywordsBlock = only_scan_keywords_block,
        baseAuthBlock = base_auth_block,
        errorsSettings = errors_settings
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.setSettings',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' stop
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/qnjzfe92bci42-stop}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_stop_site <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.stop',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' export
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/p4x2q7dwptyvz-export}{here}.
#'
#' @param report_id (required) 
#' @param export_type (required) Type of export file:
#'   
#'   Type | Description
#'   ---------|----------
#'    mgxlsx | XLSX file
#'    mgxlsx_mfiles | Google Sheet 
#'    puppeter_pdf  | PDF file
#'   
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_export <- function(
    report_id,
    export_type,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        exportType = export_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditSite.export',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' scan
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/3ca7uk9bdicd8-scan}{here}.
#'
#' @param name (required) Name of your project
#' @param url (required) Page url to scan
#' @param user_agent (required) 
#' @param http_auth_login (optional) Login for Basic HTTP authentication
#' @param http_auth_pass (optional) Password for Basic HTTP authentication
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_scan <- function(
    name,
    url,
    user_agent,
    http_auth_login = NULL,
    http_auth_pass = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        name = name,
        url = url,
        userAgent = user_agent,
        httpAuthLogin = http_auth_login,
        httpAuthPass = http_auth_pass
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.scan',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' rescan
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/s9evwv4mp1341-rescan}{here}.
#'
#' @param page_id (required) 
#' @param name (required) Name of your project. You can change project name in this method if necessary
#' @param user_agent (required) 
#' @param http_auth_login (optional) Login for Basic HTTP authentication
#' @param http_auth_pass (optional) Password for Basic HTTP authentication
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_rescan <- function(
    page_id,
    name,
    user_agent,
    http_auth_login = NULL,
    http_auth_pass = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        pageId = page_id,
        name = name,
        userAgent = user_agent,
        httpAuthLogin = http_auth_login,
        httpAuthPass = http_auth_pass
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.rescan',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' stop
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/fghia9xpgzjzd-stop}{here}.
#'
#' @param page_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_stop_page <- function(
    page_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        pageId = page_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.stop',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' remove
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/5fritcrzy7ww1-remove}{here}.
#'
#' @param page_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_remove <- function(
    page_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        pageId = page_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.remove',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getPageAudit
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/lebl8ip72i17u-get-page-audit}{here}.
#'
#' @param page_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_page_audit <- function(
    page_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        pageId = page_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.getPageAudit',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getAudit
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/xlw2titchn5w2-get-audit}{here}.
#'
#' @param report_id (required) 
#' @param compare_report_id (optional) `id` of your another report from your project to compare.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_audit <- function(
    report_id,
    compare_report_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        compareReportId = compare_report_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.getAudit',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getErrorRows
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/uuspflakzd2yi-get-error-rows}{here}.
#'
#' @param report_id (required) 
#' @param error (required) 
#' @param compare_report_id (optional) `id` of your another report from your project to compare.
#' @param mode (optional)  type of errors (all | new | solved) by default all
#' @param page (optional) 
#' @param size (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_error_rows <- function(
    report_id,
    error,
    compare_report_id = NULL,
    mode = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        error = error,
        compareReportId = compare_report_id,
        mode = mode,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.getErrorRows',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getPagesList
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/5xn8vauu8w6dk-get-pages-list}{here}.
#'
#' @param limit (optional) count of returned items in response
#' @param offset (optional)  batch number required for pagination
#' @param team_member_id (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_pages_list <- function(
    limit = NULL,
    offset = NULL,
    team_member_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        limit = limit,
        offset = offset,
        teamMemberId = team_member_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.getPagesList',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getReportsListByPage
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/dx0k6lh7g0z7c-get-reports-list-by-page}{here}.
#'
#' @param page_id (required) 
#' @param limit (optional) count of returned items in response
#' @param offset (optional) batch number required for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_get_reports_list_by_page <- function(
    page_id,
    limit = NULL,
    offset = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        pageId = page_id,
        limit = limit,
        offset = offset
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.getReportsListByPage',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' pageNames
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/mf6khxhf3h4dm-page-names}{here}.
#'
#' @param team_member_id (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_page_names <- function(
    team_member_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        teamMemberId = team_member_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.pageNames',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' userLog
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/igusdr32uo9wi-user-log}{here}.
#'
#' @param report_id (optional) 
#' @param page_size (optional) Number of results per page in response
#' @param page (optional) page number for pagination
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_au_user_log <- function(
    report_id = NULL,
    page_size = 100,
    page = 1,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        reportId = report_id,
        pageSize = page_size,
        page = page
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'AuditOnePage.userLog',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

