#' List all Serpstat databases
#'
#' In every request to get data from search analytics API you must set se
#' parameter to specify from what country do you want to get the data. This
#' method returns all acceptable values for se parameter with corresponding
#' country names.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ba97ni814ao9p-search-engine-short-names}{here}.
#'
#' @section API credits consumption: 0
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}. Default is Sys.getenv('SERPSTAT_API_TOKEN').
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns country name, se parameter value and local search engine
#'   domain name for each country.
#' @examples
#' \dontrun{
#' sst_sa_database_info()$data
#' }
#' @export
sst_sa_database_info <- function(api_token = Sys.getenv('SERPSTAT_API_TOKEN'), return_method = 'list'){
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDatabaseProcedure.getDatabaseInfo'
    )
  sst_return_check(response_content, return_method)
}

#' Get the number of API rows left
#'
#' With most API request you spend some amount of API rows. The total amount of
#' API rows available for you is based on your
#' \href{https://serpstat.com/page/pricing-plans/}{plan}. Use this method to control the amount
#' of API rows left.
#'
#' @section API credits consumption: 0
#'
#' @inheritParams sst_sa_database_info
#' @return Returns a number of API rows left. Also returns some additional
#'   information about user and
#'   \href{https://serpstat.com/extension/}{Serpstat plugin} limits.
#' @examples
#' \dontrun{
#' sst_sa_stats()$summary_info$left_lines
#' }
#' @export
sst_sa_stats <- function(api_token = Sys.getenv('SERPSTAT_API_TOKEN')){
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatLimitsProcedure.getStats'
    )
  sst_return_check(response_content, return_method = 'list')
}

#' Domains summary
#'
#' Returns the number of keywords for each domain in SEO and
#' PPC, online visibility and other metrics.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/0c6vx6hzygijk-get-domains-info}{here}.
#'
#' @section API credits consumption: 1 per domain in request.
#'
#' @param domains (required) A vector of domain names to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns aggregated stats for each domain.
#' @examples
#' \dontrun{
#' sst_sa_domains_info(
#'   domains       = c('amazon.com', 'ebay.com'),
#'   se            = 'g_us',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domains_info <- function(
    domains,
    se,
    sort          = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domains = as.list(domains),
    se      = se,
    sort    = sort
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainsInfo',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain organic keywords
#'
#' Returns up to 60 000 organic keywords from selected region for the domain
#' with a number of metrics for each keyword.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/j5jbjt0rk7oei-get-domain-keywords}{here}.
#'
#' @section API credits consumption: 1 per keyword in response.
#'
#' @section Sorting:
#'   You can sort the response using \code{sort} argument. It must be a list
#'   with a single named element. The name of the element must match one of
#'   parameters in response. The value of the element must be \code{asc} for
#'   ascending order and \code{desc} for descending order. For example,
#'   \code{sort = list(ads = 'desc')} would sort the response by \code{ads}
#'   parameter in descending order.
#'
#' @section Filtering:
#'   To filter the results you can use \code{filters} argument. It must be a
#'   list of named elements. The name of the element must match one of the
#'   filtering parameters. See API docs for more details. For example,
#'   \code{filters = list(queries_from = 0, queries_to = 10)} would narrow
#'   the results to include only the keywords that have a search volume
#'   between 0 and 10.
#'
#' @param domain (required) Domain to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param url (optional) Get the results for this URL only.
#' @param keywords (optional) A vector of words. Keywords in response will
#'   contain these words
#' @param minusKeywords (optional) A vector of words. Keywords in response will
#'   not contain these words.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @return Returns a number of metrics for each keyword.
#' @examples
#' \dontrun{
#' sst_sa_domain_keywords(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   sort          = list(keyword_length = 'desc'),
#'   url           = 'https://serpstat.com/',
#'   keywords      = list('google'),
#'   minusKeywords = list('download'),
#'   filters       = list(queries_from = 0,
#'                        queries_to   = 10),
#'   page          = 2,
#'   size          = 10,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_keywords <- function(
    domain,
    se,
    url           = NULL,
    keywords      = NULL,
    minusKeywords = NULL,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain        = domain,
    se            = se,
    url           = url,
    keywords      = as.list(keywords),
    minusKeywords = as.list(minusKeywords),
    sort          = sort,
    filters       = filters,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainKeywords',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain history
#'
#' Returns historical metrics for the domain with about two weeks between measurements.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/jtjb01xqgwv8p-get-domains-history}{here}.
#'
#' @section API credits consumption: 1 per date in the response.
#'
#' @param domain (required) Domain to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @param during_all_time (optional) TRUE (default) for all the history,
#'   FALSE for year-to-date data.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a number of metrics for each date for the domain.
#' @examples
#' \dontrun{
#' sst_sa_domain_history(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   sort          = list(date = 'desc'),
#'   filters       = list(traff_from = 20000),
#'   page          = 2,
#'   size          = 10,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_history <- function(
    domain,
    se,
    sort            = NULL,
    filters         = NULL,
    page            = 1,
    size            = 100,
    during_all_time = TRUE,
    return_method   = 'list',
    api_token       = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain          = domain,
    se              = se,
    sort            = sort,
    filters         = filters,
    page            = page,
    size            = size,
    during_all_time = during_all_time
    )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainsHistory',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain top pages
#'
#' Returns the number of domain pages with the biggest potential traffic,
#'   number of keywords, and Facebook shares.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/94ol4y7b9zje4-get-top-urls}{here}.
#'
#' @section API credits consumption: 1 per returned page.
#'
#' @param domain (required) Domain to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns domain top pages with their metrics.
#' @examples
#' \dontrun{
#' sst_sa_domain_top_pages(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   sort          = list(organic_keywords = 'desc'),
#'   filters       = list(url_contain = 'blog'),
#'   page          = 2,
#'   size          = 50,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_top_pages <- function(
    domain,
    se,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain  = domain,
    se      = se,
    sort    = sort,
    filters = filters,
    page    = page,
    size    = size
    )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getTopUrlsV2',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain competitors in organic search
#'
#' Returns organic competitors for the domain with their key metrics.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/qzd94b49vdkyb-get-organic-competitors-page}{here}.
#'
#' @section API credits consumption: 1 per returned page.
#'
#' @param domain (required) Domain to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a number of metrics for each organic competitor.
#' @examples
#' \dontrun{
#' sst_sa_domain_organic_competitors(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   sort          = list(relevance = 'desc'),
#'   page          = 2,
#'   size          = 20,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_organic_competitors <- function(
    domain,
    se,
    sort          = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain = domain,
    se     = se,
    sort   = sort,
    page   = page,
    size   = size
    )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getOrganicCompetitorsPage',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Number of keywords for each region for a domain
#'
#' Returns the number of keywords for each region for a domain. Regions with no keywords
#' are not returned.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/t84jvml38pg1q-get-regions-count}{here}.
#'
#' @section API credits consumption: 1 per returned region.
#'
#' @param domain (required) A domain name to analyze.
#' @param sort (optional) A field to sort the response. Allowed values: keywords_count, db_name, country_name_en, google_domain. Default: keywords_count.
#' @param order (optional) The order of sorting. Allowed values: asc, desc. Default: desc.
#' @inheritParams sst_sa_database_info
#' @return Returns a data frame with number of keywords for each region for a domain.
#' @examples
#' \dontrun{
#' sst_sa_domain_keywords_per_region(
#'   domain        = 'serpstat.com',
#'   sort          = 'keywords_count',
#'   order         = 'desc',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_keywords_per_region <- function(
    domain,
    sort          = 'keywords_count',
    order         = 'desc',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
){
  api_params <- list(
    domain = domain,
    sort   = sort,
    order  = order
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getRegionsCount',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Keywords summary
#'
#' Returns a number of metrics for each keyword like search volume, CPC and
#' competition level.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/2brcbdgmr6rcx-get-keywords-info}{here}.
#'
#' @section API credits consumption: 1 per keyword in request.
#'
#' @param keywords (required) A vector of keywords to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns a number of metrics for each keyword.
#' @examples
#' \dontrun{
#' sst_sa_keywords_info(
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   se            = 'g_us',
#'   sort          = list(cost = 'asc'),
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_keywords_info <- function(
    keywords,
    se,
    sort          = NULL,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    keywords = as.list(keywords),
    se       = se,
    sort     = sort
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywordsInfo',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Phrase match keywords
#'
#' A full-text search to find all the keywords that match the queried term with
#' a number of metrics for each keyword like search volume, CPC and competition
#' level.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/w7jh5sk9kc0cm-get-keywords}{here}.
#'
#' @section API credits consumption: 1 per keyword in response.
#'
#' @param keyword (required) A keyword to search for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param minusKeywords (optional) A vector of words. Keywords in response
#'   will not contain these words.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @param with_intents (optional) TRUE if keyword intent should be retrieved. This parameter works for g_ua and g_us database only.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a number of metrics for each keyword.
#' @examples
#' \dontrun{
#' sst_sa_keywords(
#'   keyword       = 'serpstat',
#'   se            = 'g_us',
#'   minusKeywords = c('free'),
#'   sort          = list(keyword_length = 'asc'),
#'   page          = 2,
#'   size          = 10,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_keywords <- function(
    keyword,
    se,
    minusKeywords = NULL,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    with_intents  = TRUE,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    keyword       = keyword,
    se            = se,
    minusKeywords = as.list(minusKeywords),
    filters       = filters,
    sort          = sort,
    page          = page,
    size          = size,
    withIntents   = with_intents
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Top for a keyword
#'
#' Returns a list of results (URLs) from search engine results page (SERP) including
#' organic results, paid results and different types of SERP features.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/env4osjb1ev9c-get-keyword-top}{here}.
#'
#' @section API credits consumption: 1 per URL in response.
#'
#' @param keyword (required) A keyword to search for.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See API docs for more details.
#' @param size (optional) Response page size. Should be => 10 and <=100. Default is 100.
#' @inheritParams sst_sa_database_info
#' @return Returns a list with the data about search engine results page for the keyword.
#' @examples
#' \dontrun{
#' sst_sa_keyword_top(
#'   keyword   = 'serpstat',
#'   se        = 'g_us',
#'   size  = 10
#' )
#' }
#' @export
sst_sa_keyword_top <- function(
    keyword,
    se,
    sort      = NULL,
    size      = 100,
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywordFullTop',
    api_params = list(
      keyword = keyword,
      se      = se,
      sort    = sort,
      size    = size
    )
  )
  sst_return_check(response_content, return_method = 'list')
}

#' Related keywords for a keyword
#'
#' Returns a list of semantically related keywords for a given keyword.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/7yidbv07n5q9u-get-related-keywords}{here}.
#'
#' @section API credits consumption: 1 per keyword in response.
#'
#' @param keyword (required) A keyword to search for.
#' @param se (required) Search engine alias (db_name) returned by \code{\link{sst_sa_database_info}}.
#' @param with_intents (optional) TRUE if keyword intent should be retrieved. This parameter works for g_ua and g_us database only.
#' @param filters (optional) A list of filtering options. See API docs for more details.
#' @param sort (optional) A field to sort the response. See API docs for more details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @return Returns related keywords for a keyword and their metrics.
#' @examples
#' \dontrun{
#' sst_sa_related_keywords(
#'   keyword       = 'serpstat',
#'   se            = 'g_us',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_related_keywords <- function(
    keyword,
    se,
    with_intents  = FALSE,
    filters       = NULL,
    sort          = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    keyword       = keyword,
    se            = se,
    withIntents   = with_intents,
    filters       = filters,
    sort          = sort,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getRelatedKeywords',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Keyword trends
#'
#' Returns monthly search volume trends for a list of keywords over a specified period (up to 48 months).
#' You can send up to 100 keywords per request.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/kw3t8rn5vx1qm-get-keyword-trends}{here}.
#'
#' @section API credits consumption: 10 credits per keyword that returned data. If no keywords returned data — 1 credit is charged for the whole request.
#'
#' @param keywords (required) A vector of keywords to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param months (optional) Number of months to get data for (up to 48). Default is 48.
#' @inheritParams sst_sa_database_info
#' @return Returns monthly search volume trends for each keyword.
#' @examples
#' \dontrun{
#' sst_sa_keyword_trends(
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   se            = 'g_us',
#'   months        = 12,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_keyword_trends <- function(
    keywords,
    se,
    months        = 48,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    keywords = as.list(keywords),
    se       = se,
    months   = months
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywordTrends',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' Domain competitors in organic search
#'
#' Returns organic competitors for the domain with their key metrics.
#' This is implemented using the newer SerpstatDomainProcedure.getOrganicCompetitorsPage API.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/qzd94b49vdkyb-get-organic-competitors-page}{here}.
#'
#' @section API credits consumption: 1 per returned page.
#'
#' @param domain (required) Domain to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns a list of organic competitors with their SEO metrics.
#' @examples
#' \dontrun{
#' sst_sa_domain_competitors(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   sort          = list(relevance = 'desc'),
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_competitors <- function(
    domain,
    se,
    sort          = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain = domain,
    se     = se,
    sort   = sort,
    page   = page,
    size   = size
    )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getOrganicCompetitorsPage',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain advertising keywords
#'
#' Returns keywords in paid search results and advertising listings for a specific domain.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/bdz42ib7iyu59-get-ad-keywords}{here}.
#'
#' @section API credits consumption: 1 per keyword in response.
#'
#' @param domain (required) Domain name to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param url (optional) Get the results for this URL only.
#' @param keywords (optional) A vector of words. Keywords in response will
#'   contain these words.
#' @param minus_keywords (optional) A vector of words. Keywords in response will
#'   not contain these words.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a list of PPC keywords with their metrics.
#' @examples
#' \dontrun{
#' sst_sa_domain_ad_keywords(
#'   domain         = 'serpstat.com',
#'   se             = 'g_us',
#'   url            = 'https://serpstat.com/',
#'   keywords       = list('google'),
#'   minus_keywords = list('download'),
#'   page           = 1,
#'   size           = 100,
#'   return_method  = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_ad_keywords <- function(
    domain,
    se,
    url            = NULL,
    keywords       = NULL,
    minus_keywords = NULL,
    sort           = NULL,
    filters        = NULL,
    page           = 1,
    size           = 100,
    return_method  = 'list',
    api_token      = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain        = domain,
    se            = se,
    url           = url,
    keywords      = if (!is.null(keywords)) as.list(keywords) else NULL,
    minusKeywords = if (!is.null(minus_keywords)) as.list(minus_keywords) else NULL,
    sort          = sort,
    filters       = filters,
    page          = page,
    size          = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getAdKeywords',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Export domain positions
#'
#' Export a complete report of a domain's keyword positions in search results.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/etkohqrqmqojw-export-positions}{here}.
#'
#' @section API credits consumption: 1 per row in response.
#'
#' @param domain (required) Domain name to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a complete report of domain positions (often in CSV format).
#' @examples
#' \dontrun{
#' sst_sa_domain_export_positions(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_export_positions <- function(
    domain,
    se,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain  = domain,
    se      = se,
    sort    = sort,
    filters = filters,
    page    = page,
    size    = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.exportPositions',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain advertising competitors
#'
#' Returns competing domains in paid search (PPC) results.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/g2arx1ss4o34o-get-ads-competitors}{here}.
#'
#' @section API credits consumption: 1 per returned competitor.
#'
#' @param domain (required) Domain name to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns a list of PPC competitors with their metrics.
#' @examples
#' \dontrun{
#' sst_sa_domain_ad_competitors(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_ad_competitors <- function(
    domain,
    se,
    sort          = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain  = domain,
    se      = se,
    sort    = sort,
    page    = page,
    size    = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getAdsCompetitors',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Traffic in all regions for a domain
#'
#' Returns search traffic info for a domain across all databases. Databases with no keywords are not shown.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/qa2ih3uak03yo-get-all-regions-traffic}{here}.
#'
#' @section API credits consumption: 1 per region in response.
#'
#' @param domain (required) Domain name to analyze.
#' @param sort (optional) Vector of sorting fields. Default is "traff".
#' @param order (optional) Order of sorting. Allowed values: asc, desc. Default: desc.
#' @inheritParams sst_sa_database_info
#' @return Returns traffic data for all regions.
#' @examples
#' \dontrun{
#' sst_sa_domain_all_regions_traffic(
#'   domain        = 'serpstat.com',
#'   sort          = c('traff'),
#'   order         = 'desc',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_all_regions_traffic <- function(
    domain,
    sort          = c("traff"),
    order         = 'desc',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain  = domain,
    sort    = as.list(sort),
    order   = order
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getAllRegionsTraffic',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' URLs in domain
#'
#' Returns a list of URLs within the analyzed domain and the number of keywords for each URL.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/y543bon3kx7t8-get-domain-urls}{here}.
#'
#' @section API credits consumption: 1 per returned URL.
#'
#' @param domain (required) Domain name to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a list of URLs with metrics.
#' @examples
#' \dontrun{
#' sst_sa_domain_urls(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_urls <- function(
    domain,
    se,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain  = domain,
    se      = se,
    sort    = sort,
    filters = filters,
    page    = page,
    size    = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainUrls',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Intersection of domains
#'
#' Returns common keywords for up to 3 domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/pej5pa405vedc-get-domains-intersection}{here}.
#'
#' @section API credits consumption: 1 per returned keyword.
#'
#' @param domains (required) Vector of domain names (min 2, max 3) to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns common keywords for the domains.
#' @examples
#' \dontrun{
#' sst_sa_domains_intersection(
#'   domains       = c('amazon.com', 'ebay.com'),
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domains_intersection <- function(
    domains,
    se,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domains = as.list(domains),
    se      = se,
    filters = filters,
    page    = page,
    size    = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainsIntersection',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Unique keywords of domains
#'
#' Returns unique keywords of one or two domains that a third domain does not rank for.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/zerum86tpb5xe-get-domains-uniq-keywords}{here}.
#'
#' @section API credits consumption: 1 per returned keyword.
#'
#' @param domains (required) Vector of domain names (min 1, max 2) to analyze.
#' @param minus_domain (required) Domain name with keywords to exclude.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns unique keywords for the domains.
#' @examples
#' \dontrun{
#' sst_sa_domains_unique_keywords(
#'   domains       = c('amazon.com'),
#'   minus_domain  = 'ebay.com',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domains_unique_keywords <- function(
    domains,
    minus_domain,
    se,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domains     = as.list(domains),
    minusDomain = minus_domain,
    se          = se,
    filters     = filters,
    page        = page,
    size        = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainsUniqKeywords',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Market Research Categories
#'
#' Returns a complete list of available market research categories used for domain classification.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/market_categories_method-get-market-categories}{here}.
#'
#' @section API credits consumption: 0 credits.
#'
#' @inheritParams sst_sa_database_info
#' @return Returns a list of category identifiers and names.
#' @examples
#' \dontrun{
#' sst_sa_market_categories(return_method = 'df')$data
#' }
#' @export
sst_sa_market_categories <- function(
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getMarketCategories'
  )
  sst_return_check(response_content, return_method)
}

#' Top Domains in Market Category
#'
#' Returns top-performing domains in a specific market category with their SEO metrics.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/category_top_domains_method-get-category-top-domains}{here}.
#'
#' @section API credits consumption: 1 credit per row in response.
#'
#' @param category_id (required) Category identifier in format .X.Y.Z. (must match regex pattern ^\\.([0-9]+\\.)*$).
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) Sort field name.
#' @param order (optional) Sort order.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns top-performing domains for the category.
#' @examples
#' \dontrun{
#' sst_sa_category_top_domains(
#'   category_id   = '.1.',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_category_top_domains <- function(
    category_id,
    se,
    sort          = NULL,
    order         = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    category_id = category_id,
    se          = se,
    sort        = sort,
    order       = order,
    filters     = filters,
    page        = page,
    size        = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getCategoryTopDomains',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Rating Data for Domains
#'
#' Returns market research data for a list of specified domains, including their category classification and SEO metrics.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/domains_rating_data_method-get-domains-rating-data}{here}.
#'
#' @section API credits consumption: 1 credit per row in response.
#'
#' @param domains (required) Vector of domain names (up to 200) to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param sort (optional) Sort field name.
#' @param order (optional) Sort order.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns market research ratings for the domains.
#' @examples
#' \dontrun{
#' sst_sa_domains_rating_data(
#'   domains       = c('amazon.com', 'ebay.com'),
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domains_rating_data <- function(
    domains,
    se,
    sort          = NULL,
    order         = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domains = as.list(domains),
    se      = se,
    sort    = sort,
    order   = order,
    filters = filters,
    page    = page,
    size    = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainsRatingData',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' Domain keywords by language
#'
#' Returns keywords which the analyzed domain ranks for, enriched with the detected language of each keyword.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ke5u46gfs2a0d-get-domain-keywords-by-language}{here}.
#'
#' @section API credits consumption: 1 credit per member of data object array in response.
#'
#' @param domain (required) Domain name to get data for.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}.
#' @param with_subdomains (optional) Retrieve data for subdomains too. Default is TRUE.
#' @param url (optional) Get the results for this URL only.
#' @param keywords (optional) A vector of words. Keywords in response will
#'   contain these words.
#' @param minus_keywords (optional) A vector of words. Keywords in response will
#'   not contain these words.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @param page (optional) Response page number if there are many pages in response.
#' @param size (optional) Response page size.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns keywords with language detection info.
#' @examples
#' \dontrun{
#' sst_sa_domain_keywords_by_language(
#'   domain        = 'serpstat.com',
#'   se            = 'g_us',
#'   page          = 1,
#'   size          = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_keywords_by_language <- function(
    domain,
    se,
    with_subdomains = TRUE,
    url             = NULL,
    keywords        = NULL,
    minus_keywords  = NULL,
    sort            = NULL,
    filters         = NULL,
    page            = 1,
    size            = 100,
    return_method   = 'list',
    api_token       = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    domain         = domain,
    se             = se,
    withSubdomains = with_subdomains,
    url            = url,
    keywords       = if (!is.null(keywords)) as.list(keywords) else NULL,
    minusKeywords  = if (!is.null(minus_keywords)) as.list(minus_keywords) else NULL,
    sort           = sort,
    filters        = filters,
    page           = page,
    size           = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getDomainKeywordsByLanguage',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' AI Overview Brand Summary
#'
#' Returns a summary of AI Overview (AIO) presence for a given brand and list of domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/aio_summary_method-get-aio-summary}{here}.
#'
#' @section API credits consumption: 5 credits per request.
#'
#' @param domains (required) Vector of domain names (up to 100) to analyze.
#' @param brand (required) Brand name to search for in AIO texts.
#' @param search_engine (optional) Search engine database. Allowed values: g_us, g_ua. Default: g_us.
#' @inheritParams sst_sa_database_info
#' @return Returns a summary of AIO brand presence.
#' @examples
#' \dontrun{
#' sst_sa_domain_aio_summary(
#'   domains       = c('amazon.com'),
#'   brand         = 'Amazon',
#'   search_engine = 'g_us',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_aio_summary <- function(
    domains,
    brand,
    search_engine = 'g_us',
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    search_engine = search_engine,
    brand         = brand,
    domains       = as.list(domains)
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getAIOSummary',
    api_params = api_params
    )
  sst_return_check(response_content, return_method)
}

#' AI Overview Brand Opportunities
#'
#' Returns a paginated list of keywords with AI Overview (AIO) data for a given brand and list of domains.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/aio_brand_opportunities_method-get-aio-brand-opportunities}{here}.
#'
#' @section API credits consumption: 2 credits per row in response.
#'
#' @param domains (required) Vector of domain names (up to 100) to analyze.
#' @param brand (required) Brand name to search for in AIO texts.
#' @param search_engine (optional) Search engine database. Allowed values: g_us, g_ua. Default: g_us.
#' @param page (optional) Response page number.
#' @param page_size (optional) Response page size. Default: 100.
#' @param sort (optional) Sort field. Allowed values: keyword. Default is NULL.
#' @param order (optional) Sort direction. Allowed values: asc, desc. Default is NULL.
#' @param filters (optional) A list of filtering options. See Filtering for more
#'   details.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a paginated list of keywords with AIO data.
#' @examples
#' \dontrun{
#' sst_sa_domain_aio_brand_opportunities(
#'   domains       = c('amazon.com'),
#'   brand         = 'Amazon',
#'   search_engine = 'g_us',
#'   page          = 1,
#'   page_size     = 100,
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domain_aio_brand_opportunities <- function(
    domains,
    brand,
    search_engine = 'g_us',
    page          = 1,
    page_size     = 100,
    sort          = NULL,
    order         = NULL,
    filters       = NULL,
    return_method = 'list',
    api_token     = Sys.getenv('SERPSTAT_API_TOKEN')
    ){
  api_params <- list(
    search_engine = search_engine,
    brand         = brand,
    domains       = as.list(domains),
    page          = page,
    page_size     = page_size,
    sort          = sort,
    order         = order,
    filters       = filters
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatDomainProcedure.getAIOBrandOpportunities',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getSuggestions
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/mmd9zlcqjaoe4-get-suggestions}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param filters (optional) Filter conditions
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_suggestions <- function(
    keyword,
    search_engine,
    filters = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        filters = filters,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getSuggestions',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getCompetitors
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/kw9p2xm4cv3nf-get-competitorsv2}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) Search engine short name. Example: `"search_engine": "g_us"`. Refer to full list of [search engines](../serpstat-public-api/ba97ni814ao9p-search-engine-short-names)
#' @param filters (optional) Filters for search. Fields are combined using the **AND** logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values.
#' @param sort (optional) Field to sort by
#' @param order (optional) Sort direction
#' @param page (optional) Page number
#' @param size (optional) Number of results per page
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_competitors <- function(
    keyword,
    search_engine,
    filters = NULL,
    sort = NULL,
    order = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        search_engine = search_engine,
        filters = filters,
        sort = sort,
        order = order,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getCompetitorsV2',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}


#' getAdKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/iwm7yvtdj0d1u-get-ad-keywords}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param domains (required) Domain names list
#'   
#'   Example: `["apple.com","verizon.com"]`
#' @param minus_keywords (optional) List of keywords to exclude from the search
#' @param filter (optional) Filters for search. Fields are combined using the **AND** logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#' @param sort (optional) Order of sorting the results in the format: `field: order`
#'   
#'   - **field** — field to sort by (any field in *data* section of response)
#'   - **order** — sort direction (`asc` — ascending, `desc` — descending)
#'   
#'   Example `\{"region_queries_count": "desc"\}`
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_ad_keywords <- function(
    keyword,
    search_engine,
    domains,
    minus_keywords = NULL,
    filter = NULL,
    sort = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        domains = domains,
        minusKeywords = minus_keywords,
        filter = filter,
        sort = sort,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getAdKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getAdsCompetitors
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/thvz04d3alhkz-get-ads-competitors}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param sort (optional) Order of sorting the results in the format: `field: order`
#'   
#'   - **field** — field to sort by (any field in *domain detailed information* section of response)
#'   - **order** — sort direction (`asc` — ascending, `desc` — descending)
#'   
#'   Example `\{"region_queries_count": "desc"\}`
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_ads_competitors <- function(
    keyword,
    search_engine,
    sort = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        sort = sort,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getAdsCompetitors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getTopUrls
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/hwiqar7egodd6-get-top-urls}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param sort (optional) Sorting by parameters(Any field in *urls* section of response)
#' @param order (optional) Sorting order
#' @param page (optional) Page number
#' @param page_size (optional) Number of results per page
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_top_urls <- function(
    keyword,
    search_engine,
    sort = NULL,
    order = NULL,
    page = 1,
    page_size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        sort = sort,
        order = order,
        page = page,
        page_size = page_size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getTopUrls',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' exportSuggestions
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/isr645c0eah6v-export-suggestions}{here}.
#'
#' @param search_engine (required) 
#' @param keyword (required) Keyword to search for
#' @param filters (optional) Filters for search. Fields are combined using the **AND** logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#' @param with_questions (optional) With/without question keywords in report
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_export_suggestions <- function(
    search_engine,
    keyword,
    filters = NULL,
    with_questions = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        se = search_engine,
        keyword = keyword,
        filters = filters,
        withQuestions = with_questions,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.exportSuggestions',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getKeywordTop
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/env4osjb1ev9c-get-keyword-top}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param filters (optional) Filters for search. Fields are combined using the **AND** logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#'   
#'   Default: `\{"top_size": 100\}`
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_get_keyword_top <- function(
    keyword,
    search_engine,
    filters = NULL,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        filters = filters,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywordTop',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' exportKeywordsPhrase
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/bo7054tzxr861-export-keywords-phrase}{here}.
#'
#' @param keyword (required) Keyword to search for
#' @param search_engine (required) 
#' @param filters (optional) Filters for search. Fields are combined using the **AND** logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#' @param sort (optional) Order of sorting the results in the format: `field: order`
#'   
#'   - **field** — field to sort by (any field in response)
#'   - **order** — sort direction (`asc` — ascending, `desc` — descending)
#'   
#'   Example `\{"region_queries_count": "desc"\}`
#' @param page (optional) Page number in response
#' @param size (optional) Page number in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_keyword_export_keywords_phrase <- function(
    keyword,
    search_engine,
    filters = NULL,
    sort = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        keyword = keyword,
        se = search_engine,
        filters = filters,
        sort = sort,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.exportKeywordsPhrase',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getSummaryTraffic
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/ukf1sgnx5mop4-get-summary-traffic}{here}.
#'
#' @param search_engine (required) 
#' @param domain (required) The domain for which to retrieve traffic and keyword data
#' @param url_contains (required) Searched part of URL
#' @param output_data (optional) Output data value.  Both options enable by default, choose one to spend less credits.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_url_get_summary_traffic <- function(
    search_engine,
    domain,
    url_contains,
    output_data = NULL,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        se = search_engine,
        domain = domain,
        urlContains = url_contains,
        output_data = output_data
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatUrlProcedure.getSummaryTraffic',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getUrlCompetitors
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/0euusensv6kpf-get-url-competitors}{here}.
#'
#' @param search_engine (required) 
#' @param url (required) URL for finding competing URLs
#' @param sort (optional) Order of sorting the results 
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response	
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_url_get_url_competitors <- function(
    search_engine,
    url,
    sort = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        se = search_engine,
        url = url,
        sort = sort,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatUrlProcedure.getUrlCompetitors',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getUrlKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/58bzxr2rb7qwc-get-url-keywords}{here}.
#'
#' @param search_engine (required) 
#' @param url (required) Analyzed page URL
#' @param with_intents (optional) Keyword intent
#'   
#'   *This parameter works for `g_ua` and `g_us` database only*
#' @param sort (optional) Order of sorting the results 
#' @param filters (optional) Filters for search. Fields are combined using the "AND" logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_url_get_url_keywords <- function(
    search_engine,
    url,
    with_intents = NULL,
    sort = NULL,
    filters = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        se = search_engine,
        url = url,
        withIntents = with_intents,
        sort = sort,
        filters = filters,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatUrlProcedure.getUrlKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}

#' getUrlMissingKeywords
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://api-docs.serpstat.com/docs/serpstat-public-api/6d8wt6v89v2ap-get-url-missing-keywords}{here}.
#'
#' @param url (required) Analyzed URL
#' @param search_engine (required) 
#' @param sort (optional) Order of sorting the results 
#' @param filters (optional) Filters for search. Fields are combined using the "AND" logic. Numeric range fields (`_from` and `_to`) allow specifying minimum and maximum values. List fields (`_contain` and `_not_contain`) specify inclusion or exclusion criteria
#' @param page (optional) Page number in response
#' @param size (optional) Number of results per page in response
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @param api_token (required) Serpstat API token.
#' @return Returns the API response.
#' @export
sst_sa_url_get_url_missing_keywords <- function(
    url,
    search_engine,
    sort = NULL,
    filters = NULL,
    page = 1,
    size = 100,
    return_method = 'list',
    api_token = Sys.getenv('SERPSTAT_API_TOKEN')
) {
  api_params <- list(
        url = url,
        se = search_engine,
        sort = sort,
        filters = filters,
        page = page,
        size = size
  )
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatUrlProcedure.getUrlMissingKeywords',
    api_params = api_params
  )
  sst_return_check(response_content, return_method)
}
