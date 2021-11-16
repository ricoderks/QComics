test_that("QC calculations", {
  # load example data
  load(file = test_path("example_data.Rdata"))
  
  # do the tests
  expect_message(calc_qc(),
                 "'data_df' doesn't contain any data!")
  
  expect_type(calc_qc(),
              type = "NULL")
  
  expect_type(calc_qc(data_df = merged_data),
              type = "list")
  
  expect_equal(calc_qc(data_df = merged_data),
               qc_data)
})
