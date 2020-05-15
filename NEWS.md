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
