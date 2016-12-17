context("Just a test of test")

test_that("test", {
  x = 1L
  y = 2L
  expect_identical(x, y-x)
})
