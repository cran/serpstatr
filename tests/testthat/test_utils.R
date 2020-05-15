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
