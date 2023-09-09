#' Get all regions for the project
#'
#' In Serpstat you are able to track ranking of your website in multiple
#' regions. This method returns all the regions in your Serpstat project.
#' You will need the results of this method to get rankings in selected region.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/620-list-of-project-regions-with-their-statuses-getprojectregions/}{here}.
#'
#' @section API rows consumption: 0
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param project_id (required) The ID of your project in Serpstat. You can
#'   find this ID in the URL of any rank tracker report. As an example, in
#'   https://serpstat.com/rank-tracker/keywords/12345/positions?get_params the
#'   ID would be 12345.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns the regions of the project with their ID, state (active or
#'   not) and other region attributes.
#' @examples
#' \dontrun{
#' api_token  <- 'api_token'
#' project_id <- 12345
#' sst_rt_project_regions(api_token = api_token, project_id = project_id)
#' }
#' @export
sst_rt_project_regions <- function(
    api_token,
    project_id,
    return_method = 'list'
    ){
  api_params <- list(
    projectId = as.integer(project_id)
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiSearchEngineProcedure.getProjectRegions',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Get search results history in search region by keywords
#'
#' This method returns top 100 search results in Google.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/642-serp-history-by-the-project-keywords-getkeywordsserpresultshistory/}{here}.
#'
#'
#' @section API rows consumption: 0
#'
#' @param region_id (required) The ID of a region returned by
#'   \code{\link{sst_rt_project_regions}}.
#' @param date_from (optional) The date string in 'YYYY-MM-DD' format to
#'   specify the initial date of retrieved data. Default value is current date
#'   minus 8 days.
#' @param date_to (optional) The date string in 'YYYY-MM-DD' format to
#'   specify the final date of retrieved data. Must not exceed date_from + 30
#'   days. Default is yesterday.
#' @param keywords (optional) A vector of keywords for witch the data should be
#'   retrieved. Maximum 1000 keywords per request. By default all the data for
#'   all keywords in the project is returned.
#' @param sort (optional) Must be one of 'keyword' (default) to sort the
#'   results alphabetically or 'date' to sort the results by date.
#' @param order (optional) The sorting order. Must be one of string 'desc'
#'   (default) for descending sorting or 'asc' for ascending sorting.
#' @param page (optional) Response page number if there are many pages in response. The
#'   default value is 1.
#' @param size (optional) Response page size. Must be one of 20, 50, 100, 200, 500.The
#'   default value is 100.
#' @inheritParams sst_rt_project_regions
#' @return Returns the search engine results for specific dates and region
#'   including positions and URLs.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' project_id <- 12345
#' region_id  <- sst_rt_project_regions(
#'   api_token  = api_token,
#'   project_id = project_id
#'   )$data$regions[[1]]$id
#' sst_rt_serp_history(
#'   api_token     = api_token,
#'   project_id    = project_id,
#'   region_id     = region_id,
#'   date_from     = '2020-12-01',
#'   date_to       = '2020-12-30',
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   sort          = 'keyword',
#'   order         = 'desc',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'list'
#' )
#' }
#' @export
sst_rt_serp_history <- function(
    api_token,
    project_id,
    region_id,
    date_from     = Sys.Date() - 8,
    date_to       = Sys.Date() - 1,
    keywords      = NULL,
    sort          = 'keyword',
    order         = 'desc',
    page          = 1,
    size          = 100,
    return_method = 'list'
    ){
  api_params <- list(
    projectId       = as.integer(project_id),
    projectRegionId = as.integer(region_id),
    dateFrom        = date_from,
    dateTo          = date_to,
    keywords        = as.list(keywords),
    sort            = sort,
    order           = order,
    page            = page,
    pageSize        = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiSerpResultsProcedure.getKeywordsSerpResultsHistory',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Get ranking history for the domain or URL in selected search region
#'
#' This method method returns the rankings for specified domain is selected
#'   search region.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/632-poluchenie-spiska-stranitc-i-ih-pozitcij-po-domenu-geturlsserpresultshistory/}{here}.
#'
#'
#' @section API rows consumption: 0
#'
#' @param url (optional) The domain name (e.g. domain.com) or web page address
#'   (e.g. https://domain.com/page) to get the data for. By default the
#'   results are returned for the projects' domain name.
#' @inheritParams sst_rt_serp_history
#' @return Returns positions of selected domain in search engine results in
#'   selected region with corresponding URLs for these positions.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' project_id <- 12345
#' region_id  <- sst_rt_project_regions(
#'   api_token  = api_token,
#'   project_id = project_id
#'   )$data$regions[[1]]$id
#' sst_rt_positions_history(
#'   api_token     = api_token,
#'   project_id    = project_id,
#'   region_id     = region_id,
#'   date_from     = '2020-12-01',
#'   date_to       = '2020-12-30',
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   url           = 'serpstat.com',
#'   sort          = 'keyword',
#'   order         = 'desc',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'list'
#' )
#' }
#' @export
sst_rt_positions_history <- function(
    api_token,
    project_id,
    region_id,
    date_from     = Sys.Date() - 8,
    date_to       = Sys.Date() - 1,
    keywords      = NULL,
    url           = NULL,
    sort          = 'keyword',
    order         = 'desc',
    page          = 1,
    size          = 100,
    return_method = 'list'
    ){
  api_params <- list(
    projectId       = as.integer(project_id),
    projectRegionId = as.integer(region_id),
    dateFrom        = date_from,
    dateTo          = date_to,
    keywords        = as.list(keywords),
    domain          = paste0(url, ''),
    sort            = sort,
    order           = order,
    page            = page,
    pageSize        = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiSerpResultsProcedure.getUrlsSerpResultsHistory',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Get the data on competitors in search results
#'
#' This method method returns the competing in top20 search results domains
#'   that rank for at least two keywords that are added the project.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/622-list-of-domains-from-top-20-by-project-keywords-gettopcompetitorsdomainshistory/}{here}.
#'
#' @section API rows consumption: 0
#'
#' @param region_id (required) The ID of a region returned by
#'   \code{\link{sst_rt_project_regions}}.
#' @param date_from (optional) The date string in 'YYYY-MM-DD' format to
#'   specify the initial date of retrieved data. Default value is current date
#'   minus 8 days.
#' @param date_to (optional) The date string in 'YYYY-MM-DD' format to
#'   specify the final date of retrieved data. Must not exceed date_from + 30
#'   days.  Default value is yesterday.
#' @param sort (optional) Must be one of 'sum_traffic' (default, domain search
#'   traffic distribution), 'keywords_count' (number of keywords),
#'   'avg_position' (average domain position), 'position_ranges' (ranges of
#'   positions), 'ads_count' (number of ads in search engine results).
#' @param sort_range (optional) The subcategory of ranges of positions to sort
#'   by. Must be one of 'top1', 'top3', 'top5', 'top10', 'top20', 'top101' to
#'   sort by the number of keywords in specific positions range; or
#'   'keywords_count_top', 'keywords_count_bottom' to sort by the number of
#'   keywords in  search ads blocks; or 'avg_position_top',
#'   'avg_position_bottom' to sort by the average position in search ads blocks.
#' @param order (optional) The sorting order. Must be one of string 'desc'
#'   (default) for descending sorting or 'asc' for ascending sorting.
#' @param page (optional) Response page number if there are many pages in response. The
#'   default value is 1.
#' @param size (optional) Response page size. Must be one of 20, 50, 100, 200, 500.The
#'   default value is 100.
#' @param domains (optional) A vector of domain names for which the data
#'   should be retrieved. By default the data is retrieved for all domains
#'   that rank for at least two keywords that are added to the project.
#' @inheritParams sst_rt_project_regions
#' @return Returns traffic and keywords distributions, average positions of
#'   the domains by date.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' project_id <- 12345
#' region_id  <- sst_rt_competitors(
#'   api_token  = api_token,
#'   project_id = project_id
#'   )$data$regions[[1]]$id
#' sst_rt_competitors(
#'   api_token     = api_token,
#'   project_id    = project_id,
#'   region_id     = region_id,
#'   date_from     = '2020-12-01',
#'   date_to       = '2020-12-30',
#'   domains       = c('serpstat.com', 'serpstatbot.com'),
#'   sort          = 'sum_traffic',
#'   sort_range    = 'top1',
#'   order         = 'desc',
#'   page          = 1,
#'   size          = 20,
#'   return_method = 'list'
#' )
#' }
#' @export
sst_rt_competitors <- function(
    api_token,
    project_id,
    region_id,
    date_from     = Sys.Date() - 8,
    date_to       = Sys.Date() - 1,
    domains       = NULL,
    sort          = 'sum_traffic',
    sort_range    = 'top1',
    order         = 'desc',
    page          = 1,
    size          = 100,
    return_method = 'list'
    ){
  api_params <- list(
    projectId       = as.integer(project_id),
    projectRegionId = as.integer(region_id),
    dateFrom        = date_from,
    dateTo          = date_to,
    domains         = as.list(domains),
    sort            = sort,
    sortRange       = sort_range,
    order           = order,
    page            = page,
    pageSize        = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiSerpResultsProcedure.getTopCompetitorsDomainsHistory',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}
