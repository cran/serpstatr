serpstatr
=========

The aim of serpstatr is to provide a wrapper for the latest version of
[Serpstat API](https://serpstat.com/api/). The main purpose of this API
is automation of common SEO and PPC tasks like keywords research and
competitors analysis in Google.

All package functions names have the same structure:

-   sst\_ prefix to distinguish from other packages
-   Serpstat modules prefix (for example, sa\_ for search analytics)
-   API function name

How to use
----------

1. Get your [API key](https://serpstat.com/users/profile/). It is required
in all package functions.

2. Search analytics

Check if you have enough limits to make API calls

    api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
    sst_sa_stats(api_token)$summary_info$left_lines

Get database ID to make requests:

    sst_sa_database_info(api_token)$data

Call functions to get keywords data:

-   sst\_sa\_domains\_info() - domain summary stats
-   sst\_sa\_domain\_keywords() - domain keywords with stats
-   sst\_sa\_keywords\_info() - keywords summary stats
-   sst\_sa\_keywords() - search Serpstat database for keywords with
    stats
-   sst\_sa\_keyword\_top() - get list of URLs from SERP for a keyword

<!-- -->

    sst_sa_keywords_info(
      api_token     = api_token,
      keywords      = c('seo', 'ppc', 'serpstat'),
      se            = 'g_us',
      sort          = list(cost = 'asc'),
      return_method = 'df'
    )$data
    
3. Rank tracker

Call functions to get the data on your rankings:

-   sst_rt_project_regions() - all regions for a project
-   sst_rt_serp_history() - search results history in search region by keyword
-   sst_rt_positions_history() - ranking history for the domain or URL in 
    selected search region
-   sst_rt_competitors() - data on competitors in search results

<!-- -->

    sst_rt_positions_history(
      api_token     = api_token,
      project_id    = project_id,
      region_id     = region_id,
      date_from     = '2020-12-01',
      date_to       = '2020-12-30',
      keywords      = c('seo', 'ppc', 'serpstat'),
      url           = 'serpstat.com',
      sort          = 'keyword',
      order         = 'desc',
      page          = 1,
      size          = 100,
      return_method = 'list'
      )$data$keywords
      
3. Backlinks

Call functions to get the data on the backlinks:

-   sst_bl_domain_summary() - backlinks summary stats for the domain
-   sst_bl_referring_domains() - referring domains stats for the domain

<!-- -->

    sst_bl_domain_summary(
      api_token     = api_token,
      domain        = 'serpstat.com',
      search_type   = 'domain',
      return_method = 'list'
      )$data

Installation
------------

To get the current development version from GitLab:

    devtools::install_gitlab('alexdanilin/serpstatr')

Issues
------

Send all issues on [GitLab
page](https://gitlab.com/alexdanilin/serpstatr/-/issues).
