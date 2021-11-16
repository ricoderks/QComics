test_that("QC tables", {
  # load example data
  load(file = test_path("example_data.Rdata"))
  
  # do the tests
  expect_error(make_nice_table(data_df = qc_data,
                                 sequence = "nope"),
                 "'arg' should be one of \"all\", \"per\"")
  
  expect_message(make_nice_table(sequence = "all"),
                 "'data_df' is NULL. There is no data!")
  
  expect_type(make_nice_table(sequence = "all"),
              type = "NULL")
  
  expect_type(make_nice_table(data_df = qc_data,
                              sequence = "all"),
              type = "list")
  
  expect_equal(make_nice_table(data_df = qc_data,
                               sequence = "all"),
               nice_df_all)
  
  expect_equal(make_nice_table(data_df = qc_data,
                               sequence = "per"),
               nice_df_per)
})
