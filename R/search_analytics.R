#' List all Serpstat databases
#'
#' In every request to get data from search analytics API you must set se
#' parameter to specify from what country do you want to get the data. This
#' method returns all acceptable values for se parameter with corresponding
#' country names.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/406-list-of-available-v4-databases-serpstatdatabaseproceduregetdatabaseinfo/}{here}.
#'
#' @section API credits consumption: 0
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns country name, se parameter value and local search engine
#'   domain name for each country.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_database_info(api_token)$data
#' }
#' @export
sst_sa_database_info <- function(api_token, return_method = 'list'){
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
#' \href{https://serpstat.com/pay/}{plan}. Use this method to control the amount
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_stats(api_token)$summary_info$left_lines
#' }
#' @export
sst_sa_stats <- function(api_token){
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/412-summarnij-otchet-po-domenu-v4-serpstatdomainproceduregetdomainsinfo/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_domains_info(
#'   api_token     = api_token,
#'   domains       = c('amazon.com', 'ebay.com'),
#'   se            = 'g_us',
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_domains_info <- function(
    api_token,
    domains,
    se,
    sort          = NULL,
    return_method = 'list'
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/584-top-search-engine-keywords-by-v4-domain-serpstatdomainproceduregetdomainkeywords/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_domain_keywords(
#'   api_token     = api_token,
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
    api_token,
    domain,
    se,
    url           = NULL,
    keywords      = NULL,
    minusKeywords = NULL,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list'
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/420-istoriya-po-domenu-v4-serpstatdomainproceduregetdomainshistory/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_domain_history(
#'   api_token     = api_token,
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
    api_token,
    domain,
    se,
    sort            = NULL,
    filters         = NULL,
    page            = 1,
    size            = 100,
    during_all_time = TRUE,
    return_method   = 'list'
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/588-domain-top-urls-v4-serpstatdomainproceduregettopurls/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_domain_top_pages(
#'   api_token     = api_token,
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
    api_token,
    domain,
    se,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list'
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/588-domain-top-urls-v4-serpstatdomainproceduregettopurls/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_domain_organic_competitors(
#'   api_token     = api_token,
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
    api_token,
    domain,
    se,
    sort          = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list'
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

#' Keywords summary
#'
#' Returns a number of metrics for each keyword like search volume, CPC and
#' competition level.
#'
#' @section API docs:
#'  Check all the values for request and response fields \href{https://serpstat.com/api/600-keyword-info-v4-serpstatkeywordproceduregetkeywordsinfo/}{here}.
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
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_keywords_info(
#'   api_token     = api_token,
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   se            = 'g_us',
#'   sort          = list(cost = 'asc'),
#'   return_method = 'df'
#' )$data
#' }
#' @export
sst_sa_keywords_info <- function(
    api_token,
    keywords,
    se,
    sort          = NULL,
    return_method = 'list'
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/592-keywords-for-v4-words-serpstatkeywordproceduregetkeywords/}{here}.
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
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns a number of metrics for each keyword.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_keywords(
#'   api_token     = api_token,
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
    api_token,
    keyword,
    se,
    minusKeywords = NULL,
    sort          = NULL,
    filters       = NULL,
    page          = 1,
    size          = 100,
    return_method = 'list'
    ){
  api_params <- list(
    keyword       = keyword,
    se            = se,
    minusKeywords = as.list(minusKeywords),
    sort          = sort,
    page          = page,
    size          = size
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
#'  Check all the values for request and response fields \href{https://serpstat.com/api/598-keyword-top-v4-serpstatkeywordproceduregetkeywordtop/}{here}.
#'
#'
#' @section API credits consumption: 1 per URL in response.
#'
#' @param keyword (required) A keyword to search for.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param  top_size (optional) Set the number of URLs to get in response.
#' @inheritParams sst_sa_database_info
#' @return Returns a list with the data about search engine results page for the keyword.
#' @examples
#' \dontrun{
#' api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
#' sst_sa_keyword_top(
#'   api_token = api_token,
#'   keyword   = 'serpstat',
#'   se        = 'g_us',
#'   top_size  = 10
#' )
#' }
#' @export
sst_sa_keyword_top <- function(api_token, keyword, se, top_size = 100) {
  response_content <- sst_call_api_method(
    api_token  = api_token,
    api_method = 'SerpstatKeywordProcedure.getKeywordTop',
    api_params = list(
      keyword = keyword,
      se      = se,
      filters = list(top_size = top_size)
    )
  )
  sst_return_check(response_content, return_method = 'list')
}
