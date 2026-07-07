context("New specs uncovered functions")
library(serpstatr)

# Helper function to set up mock for sst_call_api_method
setup_mock <- function() {
  orig_call_api_method <- serpstatr:::sst_call_api_method
  mock_called <- FALSE
  mock_args <- list()

  assignInNamespace("sst_call_api_method", function(api_token,
                                                    api_method,
                                                    api_params = NULL) {
    mock_called <<- TRUE
    mock_args <<- list(api_token = api_token,
                       api_method = api_method,
                       api_params = api_params)
    list(
      id = 1,
      result = list(data = list(list(test = "ok")))
    )
  }, ns = "serpstatr")

  list(
    restore = function() {
      assignInNamespace("sst_call_api_method", orig_call_api_method, ns = "serpstatr")
    },
    was_called = function() mock_called,
    get_args = function() mock_args
  )
}


test_that("sst_au_get_report_without_details calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_report_without_details(
    report_id = 123,
    compare_report_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getReportWithoutDetails")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$compareReportId, 5)
})


test_that("sst_au_get_error_elements calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_error_elements(
    report_id = 123,
    compare_report_id = 5,
    project_id = 123,
    error_name = "test_val",
    mode = "test_val",
    limit = 5,
    offset = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getErrorElements")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$compareReportId, 5)
  expect_equal(args$api_params$projectId, 123)
  expect_equal(args$api_params$errorName, "test_val")
  expect_equal(args$api_params$mode, "test_val")
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
})


test_that("sst_au_get_sub_elements_by_crc calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_sub_elements_by_crc(
    report_id = 123,
    project_id = 123,
    error_name = "test_val",
    crc = 5,
    compare_report_id = 123,
    mode = "test_val",
    limit = 5,
    offset = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getSubElementsByCrc")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$projectId, 123)
  expect_equal(args$api_params$errorName, "test_val")
  expect_equal(args$api_params$crc, 5)
  expect_equal(args$api_params$compareReportId, 123)
  expect_equal(args$api_params$mode, "test_val")
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
})


test_that("sst_au_get_categories_statistic calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_categories_statistic(
    report_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getCategoriesStatistic")
  expect_equal(args$api_params$reportId, 123)
})


test_that("sst_au_get_history_by_count_error calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_history_by_count_error(
    project_id = 123,
    error_name = "test_val",
    limit = 5,
    offset = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getHistoryByCountError")
  expect_equal(args$api_params$projectId, 123)
  expect_equal(args$api_params$errorName, "test_val")
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
})


test_that("sst_au_get_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_list(
    project_id = 123,
    limit = 5,
    offset = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getList")
  expect_equal(args$api_params$projectId, 123)
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
})


test_that("sst_au_get_scan_user_url_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_scan_user_url_list(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getScanUserUrlList")
  expect_equal(args$api_params$projectId, 123)
})


test_that("sst_au_get_default_settings calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_default_settings(
    ,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getDefaultSettings")

})


test_that("sst_au_get_settings calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_settings(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.getSettings")
  expect_equal(args$api_params$projectId, 123)
})


test_that("sst_au_set_settings calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_set_settings(
    project_id = 123,
    main_settings = "test_val",
    mail_trigger_settings = "test_val",
    schedule_settings = "test_val",
    scan_setting = "test_val",
    dont_scan_keywords_block = "test_val",
    only_scan_keywords_block = "test_val",
    base_auth_block = "test_val",
    errors_settings = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.setSettings")
  expect_equal(args$api_params$projectId, 123)
  expect_equal(args$api_params$mainSettings, "test_val")
  expect_equal(args$api_params$mailTriggerSettings, "test_val")
  expect_equal(args$api_params$scheduleSettings, "test_val")
  expect_equal(args$api_params$scanSetting, "test_val")
  expect_equal(args$api_params$dontScanKeywordsBlock, "test_val")
  expect_equal(args$api_params$onlyScanKeywordsBlock, "test_val")
  expect_equal(args$api_params$baseAuthBlock, "test_val")
  expect_equal(args$api_params$errorsSettings, "test_val")
})


test_that("sst_au_stop_site calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_stop_site(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.stop")
  expect_equal(args$api_params$projectId, 123)
})


test_that("sst_au_export calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_export(
    report_id = 123,
    export_type = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditSite.export")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$exportType, "test_val")
})


test_that("sst_au_scan calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_scan(
    name = "test_val",
    url = "test_val",
    user_agent = 123,
    http_auth_login = "test_val",
    http_auth_pass = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.scan")
  expect_equal(args$api_params$name, "test_val")
  expect_equal(args$api_params$url, "test_val")
  expect_equal(args$api_params$userAgent, 123)
  expect_equal(args$api_params$httpAuthLogin, "test_val")
  expect_equal(args$api_params$httpAuthPass, "test_val")
})


test_that("sst_au_rescan calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_rescan(
    page_id = 123,
    name = "test_val",
    user_agent = 123,
    http_auth_login = "test_val",
    http_auth_pass = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.rescan")
  expect_equal(args$api_params$pageId, 123)
  expect_equal(args$api_params$name, "test_val")
  expect_equal(args$api_params$userAgent, 123)
  expect_equal(args$api_params$httpAuthLogin, "test_val")
  expect_equal(args$api_params$httpAuthPass, "test_val")
})


test_that("sst_au_stop_page calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_stop_page(
    page_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.stop")
  expect_equal(args$api_params$pageId, 123)
})


test_that("sst_au_remove calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_remove(
    page_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.remove")
  expect_equal(args$api_params$pageId, 123)
})


test_that("sst_au_get_page_audit calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_page_audit(
    page_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.getPageAudit")
  expect_equal(args$api_params$pageId, 123)
})


test_that("sst_au_get_audit calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_audit(
    report_id = 123,
    compare_report_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.getAudit")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$compareReportId, 5)
})


test_that("sst_au_get_error_rows calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_error_rows(
    report_id = 123,
    error = "test_val",
    compare_report_id = 5,
    mode = "test_val",
    page = "test_val",
    size = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.getErrorRows")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$error, "test_val")
  expect_equal(args$api_params$compareReportId, 5)
  expect_equal(args$api_params$mode, "test_val")
  expect_equal(args$api_params$page, "test_val")
  expect_equal(args$api_params$size, "test_val")
})


test_that("sst_au_get_pages_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_pages_list(
    limit = 5,
    offset = 5,
    team_member_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.getPagesList")
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
  expect_equal(args$api_params$teamMemberId, 5)
})


test_that("sst_au_get_reports_list_by_page calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_get_reports_list_by_page(
    page_id = 123,
    limit = 5,
    offset = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.getReportsListByPage")
  expect_equal(args$api_params$pageId, 123)
  expect_equal(args$api_params$limit, 5)
  expect_equal(args$api_params$offset, 5)
})


test_that("sst_au_page_names calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_page_names(
    team_member_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.pageNames")
  expect_equal(args$api_params$teamMemberId, 5)
})


test_that("sst_au_user_log calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_au_user_log(
    report_id = 123,
    page_size = 5,
    page = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "AuditOnePage.userLog")
  expect_equal(args$api_params$reportId, 123)
  expect_equal(args$api_params$pageSize, 5)
  expect_equal(args$api_params$page, 5)
})


test_that("sst_cr_get_audit_stats calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_cr_get_audit_stats(
    ,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatLimitsProcedure.getAuditStats")

})


test_that("sst_dc_add_task calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_dc_add_task(
    domains = list("item1"),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "DomainClassification.addTask")
  expect_equal(args$api_params$domains, list("item1"))
})


test_that("sst_dc_get_task calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_dc_get_task(
    task_id = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "DomainClassification.getTask")
  expect_equal(args$api_params$task_id, "test_val")
})


test_that("sst_dc_get_task_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_dc_get_task_list(
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "DomainClassification.getTaskList")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_suggestions calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_suggestions(
    keyword = "test_val",
    search_engine = "test_val",
    filters = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getSuggestions")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_competitors(
    keyword = "test_val",
    search_engine = "test_val",
    filters = "test_val",
    sort = "test_val",
    order = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getCompetitorsV2")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$search_engine, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$order, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_ad_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_ad_keywords(
    keyword = "test_val",
    search_engine = "test_val",
    domains = list("item1"),
    minus_keywords = list("item1"),
    filter = "test_val",
    sort = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getAdKeywords")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$domains, list("item1"))
  expect_equal(args$api_params$minusKeywords, list("item1"))
  expect_equal(args$api_params$filter, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_ads_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_ads_competitors(
    keyword = "test_val",
    search_engine = "test_val",
    sort = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getAdsCompetitors")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_top_urls calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_top_urls(
    keyword = "test_val",
    search_engine = "test_val",
    sort = "test_val",
    order = "test_val",
    page = 5,
    page_size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getTopUrls")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$order, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$page_size, 5)
})


test_that("sst_sa_keyword_export_suggestions calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_export_suggestions(
    search_engine = "test_val",
    keyword = "test_val",
    filters = "test_val",
    with_questions = TRUE,
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.exportSuggestions")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$withQuestions, TRUE)
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_get_keyword_top calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_get_keyword_top(
    keyword = "test_val",
    search_engine = "test_val",
    filters = "test_val",
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.getKeywordTop")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_keyword_export_keywords_phrase calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_keyword_export_keywords_phrase(
    keyword = "test_val",
    search_engine = "test_val",
    filters = "test_val",
    sort = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatKeywordProcedure.exportKeywordsPhrase")
  expect_equal(args$api_params$keyword, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_rt_get_rt_project calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_rt_project(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getRtProject")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_add_rt_project calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_add_rt_project(
    name = "test_val",
    domain = "test_val",
    group = "test_val",
    parsing_type = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.addRtProject")
  expect_equal(args$api_params$name, "test_val")
  expect_equal(args$api_params$domain, "test_val")
  expect_equal(args$api_params$group, "test_val")
  expect_equal(args$api_params$parsing_type, "test_val")
})


test_that("sst_rt_get_projects calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_projects(
    page = 5,
    page_size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProjectProcedure.getProjects")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$pageSize, 5)
})


test_that("sst_rt_get_project_status calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_status(
    project_id = 5,
    region_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProjectProcedure.getProjectStatus")
  expect_equal(args$api_params$projectId, 5)
  expect_equal(args$api_params$regionId, 5)
})


test_that("sst_rt_add_project_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_add_project_keywords(
    project_id = 123,
    keywords = list("item1"),
    tags = "test_val",
    url = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.addProjectKeywords")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$keywords, list("item1"))
  expect_equal(args$api_params$tags, "test_val")
  expect_equal(args$api_params$url, "test_val")
})


test_that("sst_rt_get_project_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_keywords(
    project_id = 123,
    keyword_ids = "test_val",
    search_string = "test_val",
    tags = "test_val",
    page = "test_val",
    size = "test_val",
    sort = "test_val",
    order = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectKeywords")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$keyword_ids, "test_val")
  expect_equal(args$api_params$search_string, "test_val")
  expect_equal(args$api_params$tags, "test_val")
  expect_equal(args$api_params$page, "test_val")
  expect_equal(args$api_params$size, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$order, "test_val")
})


test_that("sst_rt_update_project_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_update_project_keywords(
    project_id = 123,
    keywords = list("item1"),
    regions = list("item1"),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.updateProjectKeywords")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$keywords, list("item1"))
  expect_equal(args$api_params$regions, list("item1"))
})


test_that("sst_rt_delete_project_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_delete_project_keywords(
    project_id = 123,
    keyword_ids = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.deleteProjectKeywords")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$keyword_ids, 123)
})


test_that("sst_rt_create_project_tags calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_create_project_tags(
    project_id = 123,
    tags = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.createProjectTags")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$tags, "test_val")
})


test_that("sst_rt_delete_project_tags calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_delete_project_tags(
    project_id = 123,
    tag_uuids = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.deleteProjectTags")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$tag_uuids, "test_val")
})


test_that("sst_rt_get_project_tags calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_tags(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectTags")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_add_project_competitor calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_add_project_competitor(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.addProjectCompetitor")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_get_project_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_competitors(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectCompetitors")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_delete_project_competitor calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_delete_project_competitor(
    competitor_uuid = "test_val",
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.deleteProjectCompetitor")
  expect_equal(args$api_params$competitor_uuid, "test_val")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_get_project_positions calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_positions(
    project_id = 123,
    project_region_ids = "test_val",
    domains = list("item1"),
    filter = "test_val",
    page = "test_val",
    page_size = "test_val",
    date_from = "test_val",
    date_to = "test_val",
    sort = "test_val",
    order = "test_val",
    sort_region = 5,
    tag_ids = 123,
    keyword_ids = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectPositions")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$project_region_ids, "test_val")
  expect_equal(args$api_params$domains, list("item1"))
  expect_equal(args$api_params$filter, "test_val")
  expect_equal(args$api_params$page, "test_val")
  expect_equal(args$api_params$page_size, "test_val")
  expect_equal(args$api_params$date_from, "test_val")
  expect_equal(args$api_params$date_to, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$order, "test_val")
  expect_equal(args$api_params$sort_region, 5)
  expect_equal(args$api_params$tag_ids, 123)
  expect_equal(args$api_params$keyword_ids, 123)
})


test_that("sst_rt_get_rt_schedule calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_rt_schedule(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getRtSchedule")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_set_rt_schedule calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_set_rt_schedule(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.setRtSchedule")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_delete_project_mirror calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_delete_project_mirror(
    project_id = 123,
    mirror_uuid = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.deleteProjectMirror")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$mirror_uuid, "test_val")
})


test_that("sst_rt_add_project_mirror calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_add_project_mirror(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.addProjectMirror")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_get_project_mirrors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_mirrors(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectMirrors")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_get_project_regions calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_project_regions(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getProjectRegions")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_delete_project_region calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_delete_project_region(
    project_id = 123,
    region_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.deleteProjectRegion")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$region_id, 5)
})


test_that("sst_rt_add_project_region calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_add_project_region(
    project_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.addProjectRegion")
  expect_equal(args$api_params$project_id, 123)
})


test_that("sst_rt_get_cities calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_cities(
    district_id = 5,
    search_engine = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getCities")
  expect_equal(args$api_params$district_id, 5)
  expect_equal(args$api_params$search_engine, "test_val")
})


test_that("sst_rt_get_districts calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_districts(
    country_id = 5,
    search_engine = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getDistricts")
  expect_equal(args$api_params$country_id, 5)
  expect_equal(args$api_params$search_engine, "test_val")
})


test_that("sst_rt_get_countries calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_get_countries(
    search_engine = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.getCountries")
  expect_equal(args$api_params$search_engine, "test_val")
})


test_that("sst_rt_create_and_run_project_tracking calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_create_and_run_project_tracking(
    domain = "test_val",
    keywords = "test_val",
    name = "test_val",
    group = "test_val",
    regions = list("item1"),
    parsing_type = "test_val",
    mirrors = list("item1"),
    schedule = "test_val",
    competitors = list("item1"),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.createAndRunProjectTracking")
  expect_equal(args$api_params$domain, "test_val")
  expect_equal(args$api_params$keywords, "test_val")
  expect_equal(args$api_params$name, "test_val")
  expect_equal(args$api_params$group, "test_val")
  expect_equal(args$api_params$regions, list("item1"))
  expect_equal(args$api_params$parsing_type, "test_val")
  expect_equal(args$api_params$mirrors, list("item1"))
  expect_equal(args$api_params$schedule, "test_val")
  expect_equal(args$api_params$competitors, list("item1"))
})


test_that("sst_rt_run_project_tracking calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_rt_run_project_tracking(
    project_id = 123,
    keyword_ids = "test_val",
    region_ids = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "RtApiProcedure.runProjectTracking")
  expect_equal(args$api_params$project_id, 123)
  expect_equal(args$api_params$keyword_ids, "test_val")
  expect_equal(args$api_params$region_ids, "test_val")
})


test_that("sst_sc_add_keyword_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sc_add_keyword_list(
    keywords = list("item1"),
    search_engine_id = "test_val",
    country_id = 123,
    region_id = 123,
    language_id = 123,
    type_id = 123,
    type = "test_val",
    pages = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "tasks.addKeywordList")
  expect_equal(args$api_params$keywords, list("item1"))
  expect_equal(args$api_params$seId, "test_val")
  expect_equal(args$api_params$countryId, 123)
  expect_equal(args$api_params$regionId, 123)
  expect_equal(args$api_params$langId, 123)
  expect_equal(args$api_params$typeId, 123)
  expect_equal(args$api_params$type, "test_val")
  expect_equal(args$api_params$pages, "test_val")
})


test_that("sst_sc_get_keyword_serp calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sc_get_keyword_serp(
    task_id = "test_val",
    keyword_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "tasks.getKeywordSerp")
  expect_equal(args$api_params$taskId, "test_val")
  expect_equal(args$api_params$keywordId, 5)
})


test_that("sst_sc_get_parsing_balance calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sc_get_parsing_balance(
    ,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "tasks.getParsingBalance")

})


test_that("sst_sc_get_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sc_get_list(
    page = 5,
    page_size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "tasks.getList")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$pageSize, 5)
})


test_that("sst_tm_activate_user calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_tm_activate_user(
    user_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "TeamManagement.activateUser")
  expect_equal(args$api_params$user_id, 5)
})


test_that("sst_tm_add_user calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_tm_add_user(
    email = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "TeamManagement.addUser")
  expect_equal(args$api_params$email, "test_val")
})


test_that("sst_tm_get_list calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_tm_get_list(
    search = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "TeamManagement.getList")
  expect_equal(args$api_params$search, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_tm_deactivate_user calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_tm_deactivate_user(
    user_id = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "TeamManagement.deactivateUser")
  expect_equal(args$api_params$user_id, 5)
})


test_that("sst_tm_remove_user calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_tm_remove_user(
    user_id = 5,
    merge_projects = TRUE,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "TeamManagement.removeUser")
  expect_equal(args$api_params$user_id, 5)
  expect_equal(args$api_params$merge_projects, TRUE)
})


test_that("sst_sa_url_get_summary_traffic calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_url_get_summary_traffic(
    search_engine = "test_val",
    domain = "test_val",
    url_contains = "test_val",
    output_data = "test_val",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatUrlProcedure.getSummaryTraffic")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$domain, "test_val")
  expect_equal(args$api_params$urlContains, "test_val")
  expect_equal(args$api_params$output_data, "test_val")
})


test_that("sst_sa_url_get_url_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_url_get_url_competitors(
    search_engine = "test_val",
    url = "test_val",
    sort = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatUrlProcedure.getUrlCompetitors")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$url, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_url_get_url_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_url_get_url_keywords(
    search_engine = "test_val",
    url = "test_val",
    with_intents = TRUE,
    sort = "test_val",
    filters = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatUrlProcedure.getUrlKeywords")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$url, "test_val")
  expect_equal(args$api_params$withIntents, TRUE)
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_sa_url_get_url_missing_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_url_get_url_missing_keywords(
    url = "test_val",
    search_engine = "test_val",
    sort = "test_val",
    filters = "test_val",
    page = 5,
    size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatUrlProcedure.getUrlMissingKeywords")
  expect_equal(args$api_params$url, "test_val")
  expect_equal(args$api_params$se, "test_val")
  expect_equal(args$api_params$sort, "test_val")
  expect_equal(args$api_params$filters, "test_val")
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$size, 5)
})


test_that("sst_vc_add_keyword_list_freq calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_vc_add_keyword_list_freq(
    keywords = list("item1"),
    region_id = 123,
    type_id = 123,
    search_engine_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatTaskProcedure.addKeywordListFreq")
  expect_equal(args$api_params$keywords, list("item1"))
  expect_equal(args$api_params$regionId, 123)
  expect_equal(args$api_params$typeId, 123)
  expect_equal(args$api_params$seId, 123)
})


test_that("sst_vc_get_task_result calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_vc_get_task_result(
    task_id = 123,
    page = 5,
    page_size = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatTaskProcedure.getTaskResult")
  expect_equal(args$api_params$taskId, 123)
  expect_equal(args$api_params$page, 5)
  expect_equal(args$api_params$pageSize, 5)
})


test_that("sst_vc_get_task_status calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_vc_get_task_status(
    task_id = 123,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatTaskProcedure.getTaskStatus")
  expect_equal(args$api_params$taskId, 123)
})

