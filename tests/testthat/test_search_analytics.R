context("Search analytics new functions")
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

test_that("sst_sa_domain_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_competitors(
    domain = "nike.com",
    se = "g_us",
    sort = list(relevance = "desc"),
    page = 2,
    size = 10,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatDomainProcedure.getOrganicCompetitorsPage")
  expect_equal(args$api_params$domain, "nike.com")
  expect_equal(args$api_params$se, "g_us")
  expect_equal(args$api_params$sort, list(relevance = "desc"))
  expect_equal(args$api_params$page, 2)
  expect_equal(args$api_params$size, 10)
})

test_that("sst_sa_domain_ad_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_ad_keywords(
    domain = "nike.com",
    se = "g_us",
    url = "https://nike.com",
    keywords = c("shoes"),
    minus_keywords = c("cheap"),
    sort = list(cost = "asc"),
    filters = list(queries_from = 1),
    page = 1,
    size = 50,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getAdKeywords")
  expect_equal(args$api_params$domain, "nike.com")
  expect_equal(args$api_params$se, "g_us")
  expect_equal(args$api_params$url, "https://nike.com")
  expect_equal(args$api_params$keywords, list("shoes"))
  expect_equal(args$api_params$minusKeywords, list("cheap"))
  expect_equal(args$api_params$sort, list(cost = "asc"))
  expect_equal(args$api_params$filters, list(queries_from = 1))
})

test_that("sst_sa_domain_export_positions calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_export_positions(
    domain = "nike.com",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.exportPositions")
  expect_equal(args$api_params$domain, "nike.com")
  expect_equal(args$api_params$se, "g_us")
})

test_that("sst_sa_domain_ad_competitors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_ad_competitors(
    domain = "nike.com",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getAdsCompetitors")
  expect_equal(args$api_params$domain, "nike.com")
  expect_equal(args$api_params$se, "g_us")
})

test_that("sst_sa_domain_all_regions_traffic calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_all_regions_traffic(
    domain = "nike.com",
    sort = "traff",
    order = "desc",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getAllRegionsTraffic")
  expect_equal(args$api_params$domain, "nike.com")
  expect_equal(args$api_params$sort, list("traff"))
  expect_equal(args$api_params$order, "desc")
})

test_that("sst_sa_domain_urls calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_urls(
    domain = "nike.com",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getDomainUrls")
})

test_that("sst_sa_domains_intersection calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domains_intersection(
    domains = c("nike.com", "adidas.com"),
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getDomainsIntersection")
  expect_equal(args$api_params$domains, list("nike.com", "adidas.com"))
  expect_equal(args$api_params$se, "g_us")
})

test_that("sst_sa_domains_unique_keywords calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domains_unique_keywords(
    domains = c("nike.com"),
    minus_domain = "adidas.com",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getDomainsUniqKeywords")
  expect_equal(args$api_params$domains, list("nike.com"))
  expect_equal(args$api_params$minusDomain, "adidas.com")
})

test_that("sst_sa_domain_top_pages calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_top_pages(
    domain = "nike.com",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getTopUrlsV2")
})

test_that("sst_sa_market_categories calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_market_categories(
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getMarketCategories")
})

test_that("sst_sa_category_top_domains calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_category_top_domains(
    category_id = ".1.",
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getCategoryTopDomains")
  expect_equal(args$api_params$category_id, ".1.")
  expect_equal(args$api_params$se, "g_us")
})

test_that("sst_sa_domains_rating_data calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domains_rating_data(
    domains = c("nike.com"),
    se = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getDomainsRatingData")
  expect_equal(args$api_params$domains, list("nike.com"))
})

test_that("sst_sa_domain_keywords_by_language calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_keywords_by_language(
    domain = "nike.com",
    se = "g_us",
    with_subdomains = FALSE,
    minus_keywords = c("cheap"),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getDomainKeywordsByLanguage")
  expect_equal(args$api_params$withSubdomains, FALSE)
  expect_equal(args$api_params$minusKeywords, list("cheap"))
})

test_that("sst_sa_domain_aio_summary calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_aio_summary(
    domains = c("nike.com"),
    brand = "nike",
    search_engine = "g_us",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getAIOSummary")
  expect_equal(args$api_params$search_engine, "g_us")
  expect_equal(args$api_params$brand, "nike")
  expect_equal(args$api_params$domains, list("nike.com"))
})

test_that("sst_sa_domain_aio_brand_opportunities calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_sa_domain_aio_brand_opportunities(
    domains = c("nike.com"),
    brand = "nike",
    search_engine = "g_us",
    page = 1,
    page_size = 50,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatDomainProcedure.getAIOBrandOpportunities")
  expect_equal(args$api_params$page_size, 50)
  expect_equal(args$api_params$brand, "nike")
  expect_equal(args$api_params$domains, list("nike.com"))
})
