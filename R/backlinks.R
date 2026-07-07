#' Backlinks summary
#'
#' Returns the overview of the backlinks profile for the domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ylg7q8n96yjci-get-summary-v2}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for
#'   domain only (site.com). See API docs for more details.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns aggregated backlinks data for the domain.
#' @examples
#' \dontrun{
#' sst_bl_domain_summary(
#'   domain        = 'serpstat.com',
#'   search_type   = 'domain',
#'   return_method = 'list'
#' )$data
#' }
#' @export
sst_bl_domain_summary <- function(
    domain,
    search_type   = 'domain',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
)
{
  api_params      <- list(
    query      = domain,
    searchType = search_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getSummaryV2',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Referring domains
#'
#' Returns the list of referring domains with main backlinks metrics for each
#' domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/uhy05n77e38uy-get-ref-domains}{here}.
#'
#' @section API credits consumption: 1 per each domain in response.
#'
#' @section Sorting:
#'   You can sort the response using \code{sort} argument. The sorting order is
#'   defined using \code{order} argument.
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
#' @param domain (required) A domain name to analyze.
#' @param search_type (required) Default value is 'domain' for domain data only
#'   (site.com). See API docs for more details.
#' @param page (optional) Response page number if there are many pages in response.
#'   Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param sort (optional) A field to sort the response. Default is
#'   'domain_rank'. See API docs for more details.
#' @param order (optional)  The order of sorting. Default is 'desc' for
#'   descending order. See API docs for more details.
#' @param filter (optional) The nested list of filtering options. See API docs
#'   for more details.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns aggregated backlinks data for each referring domain.
#' @examples
#' \dontrun{
#' sst_bl_referring_domains(
#'   domain           = 'serpstat.com',
#'   page             = 1,
#'   size             = 100,
#'   sort             = 'domain_rank',
#'   order            = 'desc',
#'   filter           = NULL,
#'   return_method    = 'list'
#' )$data
#' }
#' @export
sst_bl_referring_domains <- function(
    domain,
    search_type      = 'domain',
    page             = 1,
    size             = 100,
    sort             = 'domain_rank',
    order            = 'desc',
    filter           = NULL,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
)
{
  api_params      <- list(
    query         = domain,
    searchType    = search_type,
    page          = page,
    size          = size,
    sort          = sort,
    order         = order,
    complexFilter = filter
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getRefDomains',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Referring anchors
#'
#' Returns anchors of backlinks for the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/3m88s123b99ic-get-anchors}{here}.
#'
#' @section API credits consumption: 1 per returned anchor.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param anchor (optional) Anchor text to filter by.
#' @param count (optional) Number of words in anchor to filter by.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param filter (optional) The nested list of filtering options.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns anchors data.
#' @export
sst_bl_anchors <- function(
    domain,
    search_type   = 'domain',
    anchor        = NULL,
    count         = NULL,
    sort          = NULL,
    order         = NULL,
    page          = 1,
    size          = 100,
    filter        = NULL,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    anchor        = anchor,
    count         = count,
    sort          = sort,
    order         = order,
    page          = page,
    size          = size,
    complexFilter = filter
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getAnchors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Top anchors
#'
#' Returns top anchors for the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/r2y4zmc95iwyo-get-top-anchors}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns top anchors data.
#' @export
sst_bl_top_anchors <- function(
    domain,
    search_type   = 'domain',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query      = domain,
    searchType = search_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getTopAnchors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Intersecting referring domains
#'
#' Returns referring domains that link to comparison domains but not to the target domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/3smzy5nr2892y-get-intersect}{here}.
#'
#' @section API credits consumption: 1 per each referring domain in response.
#'
#' @param domain (required) Target domain name.
#' @param compare_domains (required) A character vector of domains for comparison.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param filter (optional) The nested list of filtering options.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns common referring domains data.
#' @export
sst_bl_domains_intersection <- function(
    domain,
    compare_domains,
    sort          = NULL,
    order         = NULL,
    page          = 1,
    size          = 100,
    filter        = NULL,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    intersect     = compare_domains,
    sort          = sort,
    order         = order,
    page          = page,
    size          = size,
    complexFilter = filter
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getIntersect',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Intersecting referring domains summary
#'
#' Returns summary of intersecting referring domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/3jfen5fhig0hr-get-intersect-summary}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param domain (required) Target domain name.
#' @param compare_domains (required) A character vector of domains to find common donors with.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns summary of common referring domains.
#' @export
sst_bl_domains_intersection_summary <- function(
    domain,
    compare_domains,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query     = domain,
    intersect = compare_domains
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getIntersectSummary',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' SDR distribution
#'
#' Returns distribution of SDR (Serpstat Domain Rank) for the referring domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/1qytvszw913u7-get-distributionsdr}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns SDR distribution data.
#' @export
sst_bl_sdr_distribution <- function(
    domain,
    search_type   = 'domain',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query      = domain,
    searchType = search_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getDistributionSDR',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' TLD distribution
#'
#' Returns distribution of top-level domains (TLDs) for the referring domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/texxxf7p0bq4a-get-distributiontld}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param language (optional) Language in which the country_name field is returned.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns TLD distribution data.
#' @export
sst_bl_tld_distribution <- function(
    domain,
    search_type   = 'domain',
    language      = NULL,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query      = domain,
    searchType = search_type,
    lang       = language
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getDistributionTLD',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Backlinks changes history
#'
#' Returns history of backlinks changes (new and lost backlinks) over time.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/sfh2g1k2udjve-get-backlinks-changes-history}{here}.
#'
#' @section API credits consumption: 1 per request.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns changes history data.
#' @export
sst_bl_changes_history <- function(
    domain,
    search_type   = 'domain',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query      = domain,
    searchType = search_type
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getBacklinksChangesHistory',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Lost backlinks
#'
#' Returns lost backlinks for the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/mpngbrbejui0x-get-lost-backlinks}{here}.
#'
#' @section API credits consumption: 1 per returned lost backlink.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit backlinks returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns lost backlinks data.
#' @export
sst_bl_lost_backlinks <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getLostBacklinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' New backlinks
#'
#' Returns new backlinks for the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/wb2l8trirj9yi-get-new-backlinks}{here}.
#'
#' @section API credits consumption: 1 per returned new backlink.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit backlinks returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns new backlinks data.
#' @export
sst_bl_new_backlinks <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getNewBacklinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Outgoing links
#'
#' Returns outgoing links from the analyzed domain/page.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ozmxiy1wkmdtd-get-outlinks}{here}.
#'
#' @section API credits consumption: 1 per returned outgoing link.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit outgoing links returned to a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns outgoing links data.
#' @export
sst_bl_outlinks <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getOutlinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Lost outgoing links
#'
#' Returns lost outgoing links from the analyzed domain/page.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/lbg7cxvhcq4vp-get-lost-outlinks}{here}.
#'
#' @section API credits consumption: 1 per returned lost outgoing link.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit outgoing links returned to a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns lost outgoing links data.
#' @export
sst_bl_lost_outlinks <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getLostOutlinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Outgoing domains
#'
#' Returns domains linked from the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/xh16az2s7dl9u-get-out-domains}{here}.
#'
#' @section API credits consumption: 1 per returned outgoing domain.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns outgoing domains data.
#' @export
sst_bl_out_domains <- function(
    domain,
    search_type   = 'domain',
    sort          = NULL,
    order         = NULL,
    filter        = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getOutDomains',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Redirected domains
#'
#' Returns domains from which redirects were performed to the analyzed domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/9bxeyqwdvm3y7-get-redirected-domains}{here}.
#'
#' @section API credits consumption: 1 per returned redirected domain.
#'
#' @param domain (required) A domain name to analyze.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns redirected domains data.
#' @export
sst_bl_redirected_domains <- function(
    domain,
    sort          = NULL,
    order         = NULL,
    filter        = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    sort          = sort,
    order         = order,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getRedirectedDomains',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Backlinks threats
#'
#' Returns domain-level malicious or vulnerability threats found in the backlinks profile.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/newx5e1tjjt0y-get-threats}{here}.
#'
#' @section API credits consumption: 1 per returned threat.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit threats returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns threats data.
#' @export
sst_bl_threats <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getThreats',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Backlinks threats links
#'
#' Returns link-level malicious or vulnerability threats found in the backlinks profile.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/9wgez05fo4mte-get-threats-links}{here}.
#'
#' @section API credits consumption: 1 per returned malicious link.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit threats returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns malicious links data.
#' @export
sst_bl_threats_links <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getThreatsLinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Outgoing backlinks threats
#'
#' Returns domain-level malicious or vulnerability threats in outgoing links.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/97ebmuifdi5pj-get-out-threats}{here}.
#'
#' @section API credits consumption: 1 per returned threat.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit threats returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns outgoing threats data.
#' @export
sst_bl_out_threats <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getOutThreats',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Outgoing backlinks threats links
#'
#' Returns link-level malicious or vulnerability threats in outgoing links.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/llxxgeuabxt2l-get-out-threats-links}{here}.
#'
#' @section API credits consumption: 1 per returned malicious link.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param links_per_domain (optional) Limit threats returned from a single domain.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns outgoing malicious links data.
#' @export
sst_bl_out_threats_links <- function(
    domain,
    search_type      = 'domain',
    sort             = NULL,
    order            = NULL,
    links_per_domain = NULL,
    filter           = NULL,
    page             = 1,
    size             = 100,
    return_method    = 'list',
    api_token        = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    linkPerDomain = links_per_domain,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getOutThreatsLinks',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Top pages by backlinks
#'
#' Returns top pages of the analyzed domain by backlinks count.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/e94wsj67zlgp0-get-top-pages}{here}.
#'
#' @section API credits consumption: 1 per returned page.
#'
#' @param domain (required) A domain name to analyze.
#' @param search_type (optional) Default value is 'domain' for domain data only.
#' @param sort (optional) A field to sort the response.
#' @param order (optional) The order of sorting.
#' @param filter (optional) The nested list of filtering options.
#' @param page (optional) Response page number. Default is 1.
#' @param size (optional) Response page size. Default is 100.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns top pages data.
#' @export
sst_bl_top_pages <- function(
    domain,
    search_type   = 'domain',
    sort          = NULL,
    order         = NULL,
    filter        = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
    query         = domain,
    searchType    = search_type,
    sort          = sort,
    order         = order,
    complexFilter = filter,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatBacklinksProcedure.getTopPages',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

