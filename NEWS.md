# serpstatr 0.5.0

* Added 15 new Search Analytics / Domain Analysis API functions:
  * `sst_sa_domain_competitors()` to get domain competitors.
  * `sst_sa_domain_ad_keywords()` to search for keywords in advertising listings.
  * `sst_sa_domain_export_positions()` to export a complete report of domain keyword positions.
  * `sst_sa_domain_ad_competitors()` to retrieve competing domains in PPC results.
  * `sst_sa_domain_all_regions_traffic()` to get search traffic data across all databases.
  * `sst_sa_domain_urls()` to list URLs within a domain and keyword counts.
  * `sst_sa_domains_intersection()` to get common keywords of up to 3 domains.
  * `sst_sa_domains_unique_keywords()` to get unique keywords of domains.
  * Updated `sst_sa_domain_top_pages()` to internally use the V2 API method.
  * `sst_sa_market_categories()` to get market research category classification.
  * `sst_sa_category_top_domains()` to get top performing domains in a category.
  * `sst_sa_domains_rating_data()` to get market research rating data for domains.
  * `sst_sa_domain_keywords_by_language()` to get keywords ranking top-100 with language info.
  * `sst_sa_domain_aio_summary()` to get AI Overview summary for a brand.
  * `sst_sa_domain_aio_brand_opportunities()` to get paginated keywords with AIO data.
* Added 18 new Backlinks API functions:
  * `sst_bl_anchors()` to retrieve referring anchors of backlinks.
  * `sst_bl_top_anchors()` to retrieve top anchors of backlinks.
  * `sst_bl_domains_intersection()` to retrieve intersecting referring domains.
  * `sst_bl_domains_intersection_summary()` to retrieve summary of intersecting referring domains.
  * `sst_bl_sdr_distribution()` to retrieve SDR distribution of referring domains.
  * `sst_bl_tld_distribution()` to retrieve TLD distribution of referring domains.
  * `sst_bl_changes_history()` to retrieve backlinks changes history.
  * `sst_bl_lost_backlinks()` to retrieve lost backlinks.
  * `sst_bl_new_backlinks()` to retrieve new backlinks.
  * `sst_bl_outlinks()` to retrieve outgoing links.
  * `sst_bl_lost_outlinks()` to retrieve lost outgoing links.
  * `sst_bl_out_domains()` to retrieve outgoing domains.
  * `sst_bl_redirected_domains()` to retrieve redirected domains.
  * `sst_bl_threats()` to retrieve domain-level backlinks threats.
  * `sst_bl_threats_links()` to retrieve link-level backlinks threats.
  * `sst_bl_out_threats()` to retrieve domain-level outgoing backlinks threats.
  * `sst_bl_out_threats_links()` to retrieve link-level outgoing backlinks threats.
  * `sst_bl_top_pages()` to retrieve top pages by backlinks count.
* Added 78 new API wrappers covering other spec-based procedures:
  * **Audit (22 functions)**: e.g. `sst_au_get_report_without_details()`, `sst_au_get_error_elements()`, `sst_au_set_settings()`, `sst_au_stop_site()`, `sst_au_stop_page()`, etc.
  * **Credits (1 function)**: `sst_cr_get_audit_stats()`.
  * **Domain Classification (3 functions)**: `sst_dc_add_task()`, `sst_dc_get_task()`, `sst_dc_get_task_list()`.
  * **Search Analytics - Keyword (9 functions)**: e.g. `sst_sa_keyword_get_suggestions()`, `sst_sa_keyword_get_competitors()`, `sst_sa_keyword_get_top_urls()`, etc.
  * **Search Analytics - URL (4 functions)**: e.g. `sst_sa_url_get_summary_traffic()`, `sst_sa_url_get_url_competitors()`, etc.
  * **Rank Tracker (27 functions)**: e.g. `sst_rt_get_rt_project()`, `sst_rt_add_project_keywords()`, `sst_rt_get_project_positions()`, etc.
  * **SERP Crawling (4 functions)**: `sst_sc_add_keyword_list()`, `sst_sc_get_keyword_serp()`, `sst_sc_get_parsing_balance()`, `sst_sc_get_list()`.
  * **Team Management (5 functions)**: `sst_tm_activate_user()`, `sst_tm_add_user()`, `sst_tm_get_list()`, `sst_tm_deactivate_user()`, `sst_tm_remove_user()`.
  * **Volume Checker (3 functions)**: `sst_vc_add_keyword_list_freq()`, `sst_vc_get_task_result()`, `sst_vc_get_task_status()`.


# serpstatr 0.4.3

* Added SERP Scraper/Crawling API functions:
  * `sst_sc_add_task()` to submit keywords for crawling.
  * `sst_sc_get_task_result()` to retrieve crawling results.

# serpstatr 0.4.2

* Added `sst_sa_keyword_trends()` function to retrieve monthly keyword search volume trends.

# serpstatr 0.4.1

* Added `with_intents` parameter to `sst_sa_keywords()` and fixed passing of `filters` parameter in API request.

# serpstatr 0.4.0

* Added `sst_sa_domain_regions_count()` to get the number of keywords per regions for a domain.
* Added `sst_sa_related_keywords()` to get a list of semantically related keywords for a given keyword.
* Added a check in `sst_call_api_method()` to ensure the API token is set.
* Set default value of API token to Sys.getenv('SERPSTAT_API_TOKEN').
* Added the option to retrieve keyword tags to `sst_rt_serp_history()` and `sst_rt_positions_history()`.
* Updated `sst_sa_keyword_top()` from deprecated API method.

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

Change dependencies versions and fixed package documentation for compliance
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
