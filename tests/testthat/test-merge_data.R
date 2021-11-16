test_that("Merge data", {
  # load example data
  load(file = test_path("example_data.Rdata"))
  
  # start testing
  expect_message(merge_data(),
                 "'mq_data' or 'meta_data' is NULL!")
  
  expect_message(merge_data(meta_data = meta_data),
                 "'mq_data' or 'meta_data' is NULL!")
  
  expect_message(merge_data(mq_data = mq_data),
                 "'mq_data' or 'meta_data' is NULL!")
  
  expect_type(merge_data(mq_data = mq_data, meta_data = meta_data),
              type = "list")
  
  expect_equal(merge_data(mq_data = mq_data, meta_data = meta_data),
               merged_data)
})
