context('Utility functions')
library(serpstatr)

test_that('Serpstat API enpoint is responding', {
  expect_equal(
    sst_call_api_method(
      api_token  = 'api_token',
      api_method = 'SerpstatLimitsProcedure.getStats',
      api_params = NULL
    )$error$message,
    'Invalid token!'
  )
})

test_that('data.frame transformation is working', {
  expect_equal(
    class(sst_return_check(
      response_content = sst_call_api_method(
        api_token  = 'api_token',
        api_method = 'SerpstatLimitsProcedure.getStats',
        api_params = NULL
        ),
      return_method    = 'df')$error),
    'list'
  )
})

test_that('sst_lists_to_df returns a data.frame', {
  expect_equal(
    class(sst_lists_to_df(
      lists = list(
        first_list  = list(a = 1, b = 2),
        second_list = list(a = 2, c = 3)
        ),
      fill  = 'empty'
      )),
    'data.frame'
  )
})
