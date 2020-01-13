serpstatr
=========

The aim of serpstatr is to provide a wrapper for the latest version of
[Serpstat API](https://serpstat.com/api/). The main purpose of this API
is automation of common SEO and PPC tasks like keywords research and
competitors analysis in Google and Yandex.

All package functions names have the same structure:

-   sst\_ prefix to distinguish from other packages
-   Serpstat modules prefix (for example, sa\_ for search analytics)
-   API function name

How to use
----------

Get your [API key](https://serpstat.com/users/profile/). It is required
in all package functions.

Check if you have enough limits to make API calls

    api_token <- 'your_api_token'
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

Installation
------------

To get the current development version from GitLab:

    devtools::install_gitlab('alexdanilin/serpstatr')

Issues
------

Send all issues on [GitLab
page](https://gitlab.com/alexdanilin/serpstatr/issues).
