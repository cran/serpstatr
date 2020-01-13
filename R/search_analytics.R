#' List all Serpstat databases
#'
#' In every request to get data from search analytics API you must set se
#' parameter to specify from what country do you want to get the data. This
#' method returns all acceptable values for se parameter with corresponding
#' country names.
#'
#' @section API rows consumption: 0
#'
#' @param api_token (required) Serpstat API token from
#'   \href{https://serpstat.com/users/profile/}{your profile}.
#' @param return_method (optional) Accepted values are 'list' (default) to
#'   return data object as list or 'df' to return data object as data.frame.
#' @return Returns country name, se parameter value and local search engine
#'   domain name for each country.
#' @examples
#' api_token <- 'api_token'
#' sst_sa_database_info(api_token)$data
#' @export
sst_sa_database_info <- function(api_token, return_method = 'list') {
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
#' @section API rows consumption: 0
#'
#' @inheritParams sst_sa_database_info
#' @return Returns a number of API rows left. Also returns some additional
#'   information about user and
#'   \href{https://serpstat.com/page/extension-en/}{Serpstat plugin} limits.
#' @examples
#' api_token <- 'api_token'
#' sst_sa_stats(api_token)$summary_info$left_lines
#' @export
sst_sa_stats <- function(api_token) {
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
#' @section API rows consumption: 1 per domain in request.
#'
#' @param domains (required) A vector of domain names to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'   \code{\link{sst_sa_database_info}}
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns
#'   \href{https://serpstat.com/api/14-domain-summary-report-domaininfo/}{aggregated
#'   stats} for each domain.
#' @examples
#' api_token <- 'api_token'
#' sst_sa_domains_info(
#'   api_token     = api_token,
#'   domains       = c('amazon.com', 'ebay.com'),
#'   se            = 'g_us',
#'   return_method = 'df'
#' )$data
#' @export
sst_sa_domains_info <- function(api_token,
                                domains,
                                se,
                                sort          = NULL,
                                return_method = 'list') {
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
#' @section API rows consumption: 1 per keyword in response.
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
#'   filtering parameters described
#'   \href{https://serpstat.com/api/61-filtering-and-sorting-results/}{here}.
#'   You can find all the acceptable values for each parameter there too. For
#'   example, \code{filters = list(queries_from = 0, queries_to = 10)} would
#'   narrow the results to include only the keywords that have a search volume
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
#' @param page (optional) Page number if there are many pages in response.
#' @param size (optional) Page size.
#'   Optional parameters for filtering, sorting
#'   and walking through the pages of the response are described
#'   \href{https://serpstat.com/api/61-filtering-and-sorting-results/}{here}.
#' @inheritParams sst_sa_database_info
#' @return Returns
#'   \href{https://serpstat.com/api/18-domain-organic-keywords-domainkeywords/}{a
#'   number metrics} for each keyword.
#' @examples
#' api_token <- 'api_token'
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
#' @export
sst_sa_domain_keywords <- function(api_token,
                                   domain,
                                   se,
                                   url           = NULL,
                                   keywords      = NULL,
                                   minusKeywords = NULL,
                                   sort          = NULL,
                                   filters       = NULL,
                                   page          = 1,
                                   size          = 100,
                                   return_method = 'list') {
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

#' Keywords summary
#'
#' Returns a number of metrics for each keyword like search volume, CPC and
#' competition level.
#'
#' @section API rows consumption: 1 per keyword in request.
#'
#' @param keywords (required) A vector of keywords to analyze.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param sort (optional) A field to sort the response. See Sorting for more
#'   details.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @return Returns
#'   \href{https://serpstat.com/api/31-keyword-overview-keywordinfo/}{a number
#'   of metrics} for each keyword.
#' @examples
#' api_token <- 'api_token'
#' sst_sa_keywords_info(
#'   api_token     = api_token,
#'   keywords      = c('seo', 'ppc', 'serpstat'),
#'   se            = 'g_us',
#'   sort          = list(cost = 'asc'),
#'   return_method = 'df'
#' )$data
#' @export
sst_sa_keywords_info <- function(api_token,
                                 keywords,
                                 se,
                                 sort          = NULL,
                                 return_method = 'list') {
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
#' @section API rows consumption: 1 per keyword in response.
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
#' @param page (optional) Page number if there are many pages in response.
#' @param size (optional) Page size.
#'  Optional parameters for filtering, sorting and walking through the pages of
#'  the response are described
#'  \href{https://serpstat.com/api/61-filtering-and-sorting-results/}{here}.
#' @inheritParams sst_sa_database_info
#' @inheritSection sst_sa_domain_keywords Sorting
#' @inheritSection sst_sa_domain_keywords Filtering
#' @return Returns
#'   \href{https://serpstat.com/api/29-phrase-match-keywords-keywords/}{a number
#'   of metrics} for each keyword.
#' @examples
#' api_token <- 'api_token'
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
#' @export
sst_sa_keywords <- function(api_token,
                            keyword,
                            se,
                            minusKeywords = NULL,
                            sort          = NULL,
                            filters       = NULL,
                            page          = 1,
                            size          = 100,
                            return_method = 'list') {
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
#' @section API rows consumption: 1 per URL in response.
#'
#' @param keyword (required) A keyword to search for.
#' @param se (required) Search engine alias (db_name) returned by
#'     \code{\link{sst_sa_database_info}}.
#' @param  top_size (optional) Set the number of URLs to get in response.
#' @inheritParams sst_sa_database_info
#' @return Returns a list with
#'   \href{https://serpstat.com/api/37-top-for-a-keyword-keywordtop/}{the
#'   data about search engine results page} for the keyword.
#' @examples
#' api_token <- 'api_token'
#' sst_sa_keyword_top(
#'   api_token = api_token,
#'   keyword   = 'serpstat',
#'   se        = 'g_us',
#'   top_size  = 10
#' )
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
