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
