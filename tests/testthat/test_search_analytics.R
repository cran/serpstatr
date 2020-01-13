context('Search analytics')
library(serpstatr)

test_that('Enpoint for sst_sa_database_info is responding', {
  expect_equal(
    sst_sa_database_info(
      api_token     = 'api_token',
      return_method = 'list')$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_stats is responding', {
  expect_equal(
    sst_sa_stats(api_token = 'api_token')$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_domains_info is responding', {
  expect_equal(
    sst_sa_domains_info(
      api_token  = 'api_token',
      domains    = c('serpstat.com', 'netpeak.net'),
      se         = 'g_us'
      )$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_domain_keywords is responding', {
  expect_equal(
    sst_sa_domain_keywords(
      api_token     = 'api_token',
      domain        = 'serpstat.com',
      se            = 'g_us',
      sort          = list(keyword_length = 'desc'),
      url           = 'https://serpstat.com/',
      keywords      = list('google'),
      minusKeywords = list('download'),
      filters       = list(queries_from = 0,
                           queries_to   = 10),
      page          = 2,
      size          = 10
      )$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_keywords_info is responding', {
  expect_equal(
    sst_sa_keywords_info(
      api_token  = 'api_token',
      keywords   = c('seo', 'ppc', 'serpstat'),
      se         = 'g_us'
    )$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_keywords is responding', {
  expect_equal(
    sst_sa_keywords(
      api_token  = 'api_token',
      keyword       = 'serpstat',
      se            = 'g_us',
      minusKeywords = c('free'),
      sort          = list(keyword_length = 'asc'),
      page          = 2,
      size          = 10
    )$error$message,
    'Invalid token!'
  )
})

test_that('Enpoint for sst_sa_keyword_top is responding', {
  expect_equal(
    sst_sa_keyword_top(
      api_token  = 'api_token',
      keyword    = 'serpstat',
      se         = 'g_us',
      top_size   = 10
    )$error$message,
    'Invalid token!'
  )
})
