serpstatr
=========

The aim of serpstatr is to provide a wrapper for the latest version of
[Serpstat API](https://api-docs.serpstat.com/docs/serpstat-public-api/jenasqbwtxdlr-introduction-to-serpstat-api). The main purpose of this API
is automation of common SEO and PPC tasks like keywords research and
competitors analysis in Google.

All package functions names have the same structure:

-   sst\_ prefix to distinguish from other packages
-   Serpstat modules prefix (for example, sa\_ for search analytics)
-   API function name

How to use
----------

1. Get your [API key](https://serpstat.com/users/profile/). It is required
in all package functions. Set it as a SERPSTAT_API_TOKEN system variable.
All functions are using it by default.

2. Search analytics

Check if you have enough limits to make API calls

    sst_sa_stats()$summary_info$left_lines

Get database ID to make requests:

    sst_sa_database_info()$data

Call functions to get keywords data:

-   sst\_sa\_domains\_info() - domain summary stats
-   sst\_sa\_domain\_keywords() - domain keywords with stats
-   sst\_sa\_domain\_history() - domain historical metrics
-   sst\_sa\_domain\_top\_pages() - domain top pages (V2)
-   sst\_sa\_domain\_organic\_competitors() - domain organic competitors
-   sst\_sa\_domain\_regions\_count() - number of keywords per region for a domain
-   sst\_sa\_keywords\_info() - keywords summary stats
-   sst\_sa\_keywords() - search Serpstat database for keywords with stats
-   sst\_sa\_related\_keywords() - semantically related keywords for a given keyword
-   sst\_sa\_keyword\_top() - get list of URLs from SERP for a keyword
-   sst\_sa\_keyword\_trends() - monthly search volume trends for a list of keywords
-   sst\_sa\_domain\_competitors() - domain competitors in organic search (V2)
-   sst\_sa\_domain\_ad_keywords() - domain advertising keywords
-   sst\_sa_domain\_export\_positions() - export domain positions report
-   sst\_sa\_domain\_ad\_competitors() - domain advertising competitors
-   sst\_sa\_domain\_all\_regions\_traffic() - traffic in all regions for a domain
-   sst\_sa\_domain\_urls() - list of URLs within domain
-   sst\_sa\_domains\_intersection() - intersection of domains
-   sst\_sa\_domains\_unique_keywords() - unique keywords of domains
-   sst\_sa\_market\_categories() - market research categories
-   sst\_sa\_category\_top\_domains() - top domains in market category
-   sst\_sa\_domains\_rating\_data() - rating data for domains
-   sst\_sa\_domain\_keywords\_by\_language() - domain keywords by language
-   sst\_sa\_domain\_aio\_summary() - AI Overview brand summary
-   sst\_sa\_domain\_aio\_brand\_opportunities() - AI Overview brand opportunities
-   sst\_sa\_keyword\_get_suggestions() - suggestions for keyword
-   sst\_sa\_keyword\_get\_competitors() - competitors for keyword (V2)
-   sst\_sa\_keyword\_get\_ad\_keywords() - advertising keywords for keyword/domains
-   sst\_sa\_keyword\_get\_ads\_competitors() - advertising competitors for keyword
-   sst\_sa\_keyword\_get\_top\_urls() - top URLs for keyword
-   sst\_sa\_keyword\_export\_suggestions() - export keyword suggestions
-   sst\_sa\_keyword\_get\_keyword\_top() - list of URLs from SERP for keyword
-   sst\_sa\_keyword\_export\_keywords\_phrase() - export keywords report
-   sst\_sa\_url\_get\_summary\_traffic() - summary traffic data for URL
-   sst\_sa\_url\_get\_url\_competitors() - competing URLs
-   sst\_sa\_url\_get\_url\_keywords() - keywords for URL
-   sst\_sa\_url\_get\_url\_missing\_keywords() - missing keywords for URL

<!-- -->

    sst_sa_keywords_info(
      keywords      = c('seo', 'ppc', 'serpstat'),
      se            = 'g_us',
      sort          = list(cost = 'asc'),
      return_method = 'df'
    )$data
    
3. Backlinks

Call functions to get the data on the backlinks:

-   sst_bl_domain_summary() - backlinks summary stats for the domain
-   sst_bl_referring_domains() - referring domains stats for the domain
-   sst_bl_anchors() - referring anchors of backlinks
-   sst_bl_top_anchors() - top anchors
-   sst_bl_domains_intersection() - intersecting referring domains
-   sst_bl_domains_intersection_summary() - intersecting referring domains summary
-   sst_bl_sdr_distribution() - SDR distribution of referring domains
-   sst_bl_tld_distribution() - TLD distribution of referring domains
-   sst_bl_changes_history() - backlinks changes history
-   sst_bl_lost_backlinks() - lost backlinks
-   sst_bl_new_backlinks() - new backlinks
-   sst_bl_outlinks() - outgoing links from domain/page
-   sst_bl_lost_outlinks() - lost outgoing links
-   sst_bl_out_domains() - outgoing domains
-   sst_bl_redirected_domains() - redirected domains
-   sst_bl_threats() - domain-level malicious/vulnerability threats
-   sst_bl_threats_links() - link-level malicious/vulnerability threats
-   sst_bl_out_threats() - outgoing malicious/vulnerability threats at domain level
-   sst_bl_out_threats_links() - outgoing malicious/vulnerability threats at link level
-   sst_bl_top_pages() - top pages of domain by backlinks count


<!-- -->

    sst_bl_domain_summary(
      domain        = 'serpstat.com',
      search_type   = 'domain',
      return_method = 'list'
      )$data
      
4. Rank tracker

Call functions to get the data on your rankings:

-   sst_rt_project_regions() - all regions for a project
-   sst_rt_serp_history() - search results history in search region by keyword
-   sst_rt_positions_history() - ranking history for the domain or URL in 
    selected search region
-   sst_rt_competitors() - data on competitors in search results
-   sst_rt_get_rt_project() - get Rank Tracker project details
-   sst_rt_add_rt_project() - add a new Rank Tracker project
-   sst_rt_get_projects() - list all Rank Tracker projects
-   sst_rt_get_project_status() - get project crawling status
-   sst_rt_add_project_keywords() - add keywords to project
-   sst_rt_get_project_keywords() - list keywords in project
-   sst_rt_update_project_keywords() - update project keywords configuration
-   sst_rt_delete_project_keywords() - delete project keywords
-   sst_rt_create_project_tags() - create tags for project
-   sst_rt_delete_project_tags() - delete project tags
-   sst_rt_get_project_tags() - list project tags
-   sst_rt_add_project_competitor() - add competitor to project
-   sst_rt_get_project_competitors() - list project competitors
-   sst_rt_delete_project_competitor() - delete project competitor
-   sst_rt_get_project_positions() - get positions data for project keywords
-   sst_rt_get_rt_schedule() - get Rank Tracker schedule settings
-   sst_rt_set_rt_schedule() - configure Rank Tracker schedule
-   sst_rt_delete_project_mirror() - delete mirror domain
-   sst_rt_add_project_mirror() - add mirror domain
-   sst_rt_get_project_mirrors() - list project mirror domains
-   sst_rt_delete_project_region() - delete crawling region from project
-   sst_rt_add_project_region() - add crawling region to project
-   sst_rt_get_cities() - list cities for location targeting
-   sst_rt_get_districts() - list districts for location targeting
-   sst_rt_get_countries() - list countries for location targeting
-   sst_rt_create_and_run_project_tracking() - create project and run tracking immediately
-   sst_rt_run_project_tracking() - trigger project rank tracking crawl


<!-- -->

    sst_rt_positions_history(
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

4. Audit

Call functions to audit your website for technical issues:

-   sst_au_start() - start website audit
-   sst_au_get_summary() - get website audit summary
-   sst_au_get_report_without_details() - get audit report overview
-   sst_au_get_error_elements() - get error elements list
-   sst_au_get_sub_elements_by_crc() - get sub-elements details by crc
-   sst_au_get_categories_statistic() - get audit category statistics
-   sst_au_get_history_by_count_error() - get error count history
-   sst_au_get_list() - list audit reports for project
-   sst_au_get_scan_user_url_list() - list user urls to scan
-   sst_au_get_default_settings() - get default audit settings
-   sst_au_get_settings() - get audit settings for project
-   sst_au_set_settings() - configure audit settings for project
-   sst_au_stop_site() - stop running site audit
-   sst_au_export() - export audit report
-   sst_au_scan() - scan single page
-   sst_au_rescan() - rescan single page
-   sst_au_stop_page() - stop page audit
-   sst_au_remove() - remove page audit project
-   sst_au_get_page_audit() - get page audit report details
-   sst_au_get_audit() - get full page audit data
-   sst_au_get_error_rows() - get specific error rows from page audit
-   sst_au_get_pages_list() - list single page audit projects
-   sst_au_get_reports_list_by_page() - list reports for page audit project
-   sst_au_page_names() - list page names in team
-   sst_au_user_log() - view user action log


<!-- -->

    sst_au_start(
      project_id    = project_id
      )$data$reportId
      
5. Project management

Call functions to manage your projects:

-   sst_pm_create_project() - create a new project
-   sst_pm_delete_project() - delete an existing project
-   sst_pm_list_projects() - list all projects available for the user

<!-- -->

    sst_pm_create_project(
      domain    = 'serpstat.com',
      name      = 'Serpstat'
      )$data$project_id

6. SERP Crawling (Scraper)

Call functions to parse and crawl search engine results:

-   sst_sc_add_task() - add a crawling task
-   sst_sc_get_task_result() - get crawling task result
-   sst_sc_add_keyword_list() - submit batch of keywords for crawling
-   sst_sc_get_keyword_serp() - retrieve raw SERP HTML/data for keyword
-   sst_sc_get_parsing_balance() - check SERP crawling balance
-   sst_sc_get_list() - list past crawling tasks

<!-- -->

    sst_sc_add_task(
      keywords   = c("explain the gauss rifle principle", "why iphone better than samsung"),
      country_id = 23
    )$data$taskId

7. Credits

Call functions to get your API limits and usage:

-   sst_cr_get_audit_stats() - get site audit API limits and usage stats

8. Domain classification

Call functions to classify domains by categories:

-   sst_dc_add_task() - add domain classification task
-   sst_dc_get_task() - get domain classification task result
-   sst_dc_get_task_list() - list domain classification tasks

9. Team management

Call functions to manage team members:

-   sst_tm_activate_user() - activate team member
-   sst_tm_add_user() - add new team member
-   sst_tm_get_list() - list team members
-   sst_tm_deactivate_user() - deactivate team member
-   sst_tm_remove_user() - remove team member from team

10. Volume checker

Call functions to check search volumes of keywords:

-   sst_vc_add_keyword_list_freq() - submit batch of keywords to check search volume
-   sst_vc_get_task_result() - get volume check task results
-   sst_vc_get_task_status() - get volume check task status


Installation
------------

To get the current development version from GitLab:

    devtools::install_gitlab('alexdanilin/serpstatr')

Issues
------

Send all issues on [GitLab
page](https://gitlab.com/alexdanilin/serpstatr/-/work_items).
