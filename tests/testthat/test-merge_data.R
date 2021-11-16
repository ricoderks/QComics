test_that("Merge data", {
  # seed random generator
  set.seed(42)
  areas <- floor(rnorm(n = 9, mean = 100000, sd = 1000))
  ret_times <- round(rep(c(1 + rnorm(n = 1, mean = 0.3),
                           4 + rnorm(n = 1, mean = 0.3),
                           7 + rnorm(n = 1, mean = 0.3))),
                     digits = 1)
  widths <- round(rnorm(n = 9, mean = 0.1, sd = 0.01),
                  digits = 2)
  # make meta data
  meta_data <- data.frame(filename = paste0("QCpool_00", 1:3),
                          sequence = rep(1, 3),
                          acq_order = 1:3)
  # make mq data
  mq_data <- data.frame(Index = 1:9,
                        filename = sprintf("D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_00%d.wiff (sample 1)", rep(1:3, each = 3)),
                        compound = rep(paste0("Peak0", 1:3), 3),
                        short_filename = paste0("QCpool_00", rep(1:3, each = 3)),
                        area = areas,
                        ret_time = ret_times,
                        width50 = widths)
  # make merged data
  merged_data <- data.frame(Index = 1:9,
                            filename = sprintf("D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_00%d.wiff (sample 1)", rep(1:3, each = 3)),
                            compound = rep(paste0("Peak0", 1:3), 3),
                            short_filename = paste0("QCpool_00", rep(1:3, each = 3)),
                            area = areas,
                            ret_time = ret_times,
                            width50 = widths,
                            sequence = rep(1, 9),
                            acq_order = rep(1:3, each = 3))
  # set the correct class
  class(merged_data) <- c("tbl_df", "tbl", "data.frame")
  
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
