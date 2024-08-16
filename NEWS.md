# serpstatr 0.3.0

Add search analytics API functions:

* sst_sa_domain_history() - domain historical metrics
* sst_sa_domain_top_pages() - domain top pages
* sst_sa_domain_organic_competitors() - domain organic competitors

Add audit API functions:

* sst_au_start() - start website audit
* sst_au_get_summary() - get website audit summary

Add project management API functions:

* sst_pm_create_project() - create a new project
* sst_pm_delete_project() - delete an existing project
* sst_pm_list_projects() - list all projects available for the user

Made minor documentation changes.

# serpstatr 0.2.1

Change dependencies versions and fixed package documentation for complience
with roxygen2 breaking changes.

# serpstatr 0.2.0

Add backlinks API functions:

* sst_bl_domain_summary() - backlinks summary stats for the domain
* sst_bl_referring_domains() - referring domains stats for the domain

Set default values for dates, keywords, and URLs in rank tracker functions.

# serpstatr 0.1.0

Add rank tracker API functions:

* sst_rt_project_regions() - all regions for a project
* sst_rt_serp_history() - search results history in search region by keyword
* sst_rt_positions_history() - ranking history for the domain or URL in 
    selected search region
* sst_rt_competitors() - data on competitors in search results

# serpstatr 0.0.2

* Remove all tests dependent on external API.
* Move API error handling from tests to main utility function sst_call_api_method.

# serpstatr 0.0.1

Add new functions. 

Search analytics:

* sst_sa_domains_info() - domain summary stats
* sst_sa_domain_keywords() - domain keywords with stats
* sst_sa_keywords_info() - keywords summary stats
* sst_sa_keywords() - search Serpstat database for keywords with
    stats
* sst_sa_keyword_top() - get list of URLs from SERP for a keyword

Utility functions:

* sst_lists_to_df() - convert list of lists to data.frame
