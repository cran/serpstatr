context("Backlinks new functions")
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

test_that("sst_bl_anchors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_anchors(
    domain = "nike.com",
    search_type = "domain",
    anchor = "shoes",
    count = 2,
    sort = "refDomains",
    order = "desc",
    page = 2,
    size = 20,
    filter = list(c("nofollow", "equals", "true")),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_token, "mock_token")
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getAnchors")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$searchType, "domain")
  expect_equal(args$api_params$anchor, "shoes")
  expect_equal(args$api_params$count, 2)
  expect_equal(args$api_params$sort, "refDomains")
  expect_equal(args$api_params$order, "desc")
  expect_equal(args$api_params$page, 2)
  expect_equal(args$api_params$size, 20)
  expect_equal(args$api_params$complexFilter, list(c("nofollow", "equals", "true")))
})

test_that("sst_bl_top_anchors calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_top_anchors(
    domain = "nike.com",
    search_type = "domain",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getTopAnchors")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$searchType, "domain")
})

test_that("sst_bl_domains_intersection calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_domains_intersection(
    domain = "nike.com",
    compare_domains = c("adidas.com", "puma.com"),
    sort = "domain_rank",
    order = "desc",
    page = 1,
    size = 50,
    filter = NULL,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getIntersect")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$intersect, c("adidas.com", "puma.com"))
  expect_equal(args$api_params$sort, "domain_rank")
  expect_equal(args$api_params$order, "desc")
})

test_that("sst_bl_domains_intersection_summary calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_domains_intersection_summary(
    domain = "nike.com",
    compare_domains = c("adidas.com"),
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getIntersectSummary")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$intersect, c("adidas.com"))
})

test_that("sst_bl_sdr_distribution calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_sdr_distribution(
    domain = "nike.com",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getDistributionSDR")
  expect_equal(args$api_params$query, "nike.com")
})

test_that("sst_bl_tld_distribution calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_tld_distribution(
    domain = "nike.com",
    language = "en",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getDistributionTLD")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$lang, "en")
})

test_that("sst_bl_changes_history calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_changes_history(
    domain = "nike.com",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getBacklinksChangesHistory")
  expect_equal(args$api_params$query, "nike.com")
})

test_that("sst_bl_lost_backlinks calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_lost_backlinks(
    domain = "nike.com",
    links_per_domain = 3,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getLostBacklinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 3)
})

test_that("sst_bl_new_backlinks calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_new_backlinks(
    domain = "nike.com",
    links_per_domain = 5,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getNewBacklinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 5)
})

test_that("sst_bl_outlinks calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_outlinks(
    domain = "nike.com",
    links_per_domain = 2,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getOutlinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 2)
})

test_that("sst_bl_lost_outlinks calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_lost_outlinks(
    domain = "nike.com",
    links_per_domain = 1,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getLostOutlinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 1)
})

test_that("sst_bl_out_domains calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_out_domains(
    domain = "nike.com",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getOutDomains")
  expect_equal(args$api_params$query, "nike.com")
})

test_that("sst_bl_redirected_domains calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_redirected_domains(
    domain = "nike.com",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getRedirectedDomains")
  expect_equal(args$api_params$query, "nike.com")
})

test_that("sst_bl_threats calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_threats(
    domain = "nike.com",
    links_per_domain = 4,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getThreats")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 4)
})

test_that("sst_bl_threats_links calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_threats_links(
    domain = "nike.com",
    links_per_domain = 2,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getThreatsLinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 2)
})

test_that("sst_bl_out_threats calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_out_threats(
    domain = "nike.com",
    links_per_domain = 3,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getOutThreats")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 3)
})

test_that("sst_bl_out_threats_links calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_out_threats_links(
    domain = "nike.com",
    links_per_domain = 1,
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getOutThreatsLinks")
  expect_equal(args$api_params$query, "nike.com")
  expect_equal(args$api_params$linkPerDomain, 1)
})

test_that("sst_bl_top_pages calls sst_call_api_method with correct args", {
  mock <- setup_mock()
  on.exit(mock$restore())

  res <- sst_bl_top_pages(
    domain = "nike.com",
    api_token = "mock_token"
  )

  expect_true(mock$was_called())
  args <- mock$get_args()
  expect_equal(args$api_method, "SerpstatBacklinksProcedure.getTopPages")
  expect_equal(args$api_params$query, "nike.com")
})
