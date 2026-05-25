context('Utility functions')
library(serpstatr)

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

test_that('sst_lists_to_df handles empty lists and nested empty lists safely', {
  expect_equal(class(sst_lists_to_df(list())), 'data.frame')
  expect_equal(nrow(sst_lists_to_df(list())), 0)
  expect_equal(ncol(sst_lists_to_df(list())), 0)

  expect_equal(class(sst_lists_to_df(list(list(), list()))), 'data.frame')
  expect_equal(nrow(sst_lists_to_df(list(list(), list()))), 2)
  expect_equal(ncol(sst_lists_to_df(list(list(), list()))), 0)
})
