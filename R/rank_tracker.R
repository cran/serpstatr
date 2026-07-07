#' Get all regions for the project
#'
#' In Serpstat you are able to track ranking of your website in multiple
#' regions. This method returns all the regions in your Serpstat project.
#' You will need the results of this method to get rankings in selected region.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/a8f5bbf27001a-get-project-regions}{here}.
#'
#' @section API credits consumption: 0
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
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
#' sst_rt_project_regions(project_id = 12345)
#' }
#' @export
sst_rt_project_regions <- function(
    project_id,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
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
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/571085d3951b6-get-keywords-serp-results-history}{here}.
#'
#'
#' @section API credits consumption: 0
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
#' @param tags (optional) TRUE if keyword tags should be retrieved. Default is FALSE.
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
#' project_id <- 12345
#' region_id  <- sst_rt_project_regions(
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
    project_id,
    region_id,
    date_from     = Sys.Date() - 8,
    date_to       = Sys.Date() - 1,
    keywords      = NULL,
    tags          = FALSE,
    sort          = 'keyword',
    order         = 'desc',
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    projectId       = as.integer(project_id),
    projectRegionId = as.integer(region_id),
    dateFrom        = date_from,
    dateTo          = date_to,
    keywords        = as.list(keywords),
    withTags        = tags,
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
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/10db1d2228e1d-get-urls-serp-results-history}{here}.
#'
#'
#' @section API credits consumption: 0
#'
#' @param url (optional) The domain name (e.g. domain.com) or web page address
#'   (e.g. https://domain.com/page) to get the data for. By default the
#'   results are returned for the projects' domain name.
#' @inheritParams sst_rt_serp_history
#' @return Returns positions of selected domain in search engine results in
#'   selected region with corresponding URLs for these positions.
#' @examples
#' \dontrun{
#' project_id <- 12345
#' region_id  <- sst_rt_project_regions(
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
    project_id,
    region_id,
    date_from     = Sys.Date() - 8,
    date_to       = Sys.Date() - 1,
    keywords      = NULL,
    url           = NULL,
    tags          = FALSE,
    sort          = 'keyword',
    order         = 'desc',
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    projectId       = as.integer(project_id),
    projectRegionId = as.integer(region_id),
    dateFrom        = date_from,
    dateTo          = date_to,
    keywords        = as.list(keywords),
    domain          = paste0(url, ''),
    withTags        = tags,
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
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/7ec8cf3b3ae68-get-top-competitors-domains-history}{here}.
#'
#' @section API credits consumption: 0
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
#' project_id <- 12345
#' region_id  <- sst_rt_competitors(
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
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
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


#' getRtProject
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_rt_project <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getRtProject',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addRtProject
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param name (required) Project name
#' @param domain (required) Main domain to track
#' @param group (optional) Project group
#' @param parsing_type (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_add_rt_project <- function(
    name,
    domain,
    group = NULL,
    parsing_type = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        name = name,
        domain = domain,
        group = group,
        parsing_type = parsing_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.addRtProject',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjects
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param page (optional) Page number in the projects list
#'   
#' @param page_size (optional) Number of results per page in the project list.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_projects <- function(
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
    api_method = 'RtApiProjectProcedure.getProjects',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectStatus
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) Project identifier in numeric representation
#' @param region_id (required) Search region ID (get via getProjectRegions)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_status <- function(
    project_id,
    region_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        projectId = project_id,
        regionId = region_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProjectProcedure.getProjectStatus',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addProjectKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param keywords (required) Array of keywords
#' @param tags (optional) Tags for keywords (created automatically if don't exist)
#' @param url (optional) Target URL for rank checking
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_add_project_keywords <- function(
    project_id,
    keywords,
    tags = NULL,
    url = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        keywords = keywords,
        tags = tags,
        url = url
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.addProjectKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param keyword_ids (optional) Filter by keyword ID array
#' @param search_string (optional) 
#' @param tags (optional) Filter by tags (empty array = all tags)
#' @param page (optional) 
#' @param size (optional) 
#' @param sort (optional) 
#' @param order (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_keywords <- function(
    project_id,
    keyword_ids = NULL,
    search_string = NULL,
    tags = NULL,
    page = 1,
    size = 100,
    sort = NULL,
    order = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        keyword_ids = keyword_ids,
        search_string = search_string,
        tags = tags,
        page = page,
        size = size,
        sort = sort,
        order = order
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' updateProjectKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param keywords (required) List of keywords to update. From 1 to 100 elements.
#' @param regions (optional) List of project region IDs to apply the update to. If not provided or all provided IDs do not belong to the project, the update applies to all project regions. Max 100 elements.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_update_project_keywords <- function(
    project_id,
    keywords,
    regions = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        keywords = keywords,
        regions = regions
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.updateProjectKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deleteProjectKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param keyword_ids (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_delete_project_keywords <- function(
    project_id,
    keyword_ids,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        keyword_ids = keyword_ids
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.deleteProjectKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' createProjectTags
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param tags (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_create_project_tags <- function(
    project_id,
    tags,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        tags = tags
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.createProjectTags',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deleteProjectTags
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param tag_uuids (required) Array of tag UUIDs to delete
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_delete_project_tags <- function(
    project_id,
    tag_uuids,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        tag_uuids = tag_uuids
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.deleteProjectTags',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectTags
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_tags <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectTags',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addProjectCompetitor
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_add_project_competitor <- function(
    project_id = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.addProjectCompetitor',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectCompetitors
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_competitors <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectCompetitors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deleteProjectCompetitor
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param competitor_uuid (required) Competitor UUID, can be obtained from `getProjectCompetitors`
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_delete_project_competitor <- function(
    competitor_uuid,
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        competitor_uuid = competitor_uuid,
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.deleteProjectCompetitor',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectPositions
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param project_region_ids (required) Filter by project regions (get via getProjectRegions)
#' @param domains (optional) Filter by domains (UUID) - main + mirrors + competitors
#' @param filter (optional) 
#' @param page (optional) 
#' @param page_size (optional) 
#' @param date_from (optional) 
#' @param date_to (optional) 
#' @param sort (optional) 
#' @param order (optional) 
#' @param sort_region (optional) 
#' @param tag_ids (optional) 
#' @param keyword_ids (optional) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_positions <- function(
    project_id,
    project_region_ids,
    domains = NULL,
    filter = NULL,
    page = 1,
    page_size = 100,
    date_from = NULL,
    date_to = NULL,
    sort = NULL,
    order = NULL,
    sort_region = NULL,
    tag_ids = NULL,
    keyword_ids = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        project_region_ids = project_region_ids,
        domains = domains,
        filter = filter,
        page = page,
        page_size = page_size,
        date_from = date_from,
        date_to = date_to,
        sort = sort,
        order = order,
        sort_region = sort_region,
        tag_ids = tag_ids,
        keyword_ids = keyword_ids
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectPositions',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getRtSchedule
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_rt_schedule <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getRtSchedule',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' setRtSchedule
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_set_rt_schedule <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.setRtSchedule',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deleteProjectMirror
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param mirror_uuid (required) Mirror UUID (from getProjectMirrors)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_delete_project_mirror <- function(
    project_id,
    mirror_uuid,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        mirror_uuid = mirror_uuid
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.deleteProjectMirror',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addProjectMirror
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_add_project_mirror <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.addProjectMirror',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectMirrors
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_mirrors <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectMirrors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getProjectRegions
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_project_regions <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getProjectRegions',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' deleteProjectRegion
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param region_id (required) Tracking region ID (from getProjectRegions)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_delete_project_region <- function(
    project_id,
    region_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        region_id = region_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.deleteProjectRegion',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' addProjectRegion
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_add_project_region <- function(
    project_id,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.addProjectRegion',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getCities
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param district_id (required) District ID (from getDistricts method)
#' @param search_engine (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_cities <- function(
    district_id,
    search_engine,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        district_id = district_id,
        search_engine = search_engine
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getCities',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getDistricts
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param country_id (required) Country ID (from getCountries method)
#' @param search_engine (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_districts <- function(
    country_id,
    search_engine,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        country_id = country_id,
        search_engine = search_engine
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getDistricts',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getCountries
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param search_engine (required) 
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_get_countries <- function(
    search_engine,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        search_engine = search_engine
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.getCountries',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' createAndRunProjectTracking
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param domain (required) Main domain
#' @param keywords (required) 
#' @param name (optional) Project name
#' @param group (optional) Project group
#' @param regions (optional) Tracking regions (auto-detected if not specified)
#' @param parsing_type (optional) 
#' @param mirrors (optional) Domain mirrors (max. 10)
#' @param schedule (optional) 
#' @param competitors (optional) Competitors (max. 10)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_create_and_run_project_tracking <- function(
    domain,
    keywords,
    name = NULL,
    group = NULL,
    regions = NULL,
    parsing_type = NULL,
    mirrors = NULL,
    schedule = NULL,
    competitors = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        domain = domain,
        keywords = keywords,
        name = name,
        group = group,
        regions = regions,
        parsing_type = parsing_type,
        mirrors = mirrors,
        schedule = schedule,
        competitors = competitors
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.createAndRunProjectTracking',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' runProjectTracking
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api}{here}.
#'
#' @param project_id (required) 
#' @param keyword_ids (optional) Keyword IDs (if empty, runs for all keywords)
#' @param region_ids (optional) Region IDs (if empty, runs for all regions)
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_rt_run_project_tracking <- function(
    project_id,
    keyword_ids = NULL,
    region_ids = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        project_id = project_id,
        keyword_ids = keyword_ids,
        region_ids = region_ids
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'RtApiProcedure.runProjectTracking',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

