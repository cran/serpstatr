context("Serp crawling functions")
library(serpstatr)

test_that("sst_sc_add_task calls sst_call_api_method with correct arguments", {
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
      id = 123456789,
      result = list(taskId = 5484945)
    )
  }, ns = "serpstatr")

  on.exit(assignInNamespace("sst_call_api_method",
                            orig_call_api_method,
                            ns = "serpstatr"))

  res <- sst_sc_add_task(
    keywords = c("a", "b"),
    country_id = 23,
    api_token = "mock_token"
  )

  expect_true(mock_called)
  expect_equal(mock_args$api_token, "mock_token")
  expect_equal(mock_args$api_method, "tasks.addTask")
  expect_equal(mock_args$api_params$keywords, "a,b")
  expect_equal(mock_args$api_params$seId, 1)
  expect_equal(mock_args$api_params$countryId, 23)
  expect_equal(mock_args$api_params$type, "regular_aio")
  expect_equal(mock_args$api_params$pages, 1)

  expect_equal(res$data$taskId, 5484945)
})

test_that("sst_sc_get_task_result calls sst_call_api_method with correct args", {
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
      id = 123456789,
      result = list(
        data = list(
          list(keyword = "a", position = 1)
        )
      )
    )
  }, ns = "serpstatr")

  on.exit(assignInNamespace("sst_call_api_method",
                            orig_call_api_method,
                            ns = "serpstatr"))

  res <- sst_sc_get_task_result(
    task_id = 5484945,
    page = 2,
    api_token = "mock_token"
  )

  expect_true(mock_called)
  expect_equal(mock_args$api_token, "mock_token")
  expect_equal(mock_args$api_method, "tasks.getTaskResult")
  expect_equal(mock_args$api_params$taskId, 5484945)
  expect_equal(mock_args$api_params$page, 2)

  expect_equal(res$data[[1]]$keyword, "a")
})
