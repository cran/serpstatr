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
    api_method = 'SerpstatDomainProcedure.getTopUrls',
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
