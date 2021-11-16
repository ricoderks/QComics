test_that("Results can be read", {
  # check result file
  expect_message(check_result_file(),
                 "No file specified!")
  
  expect_message(check_result_file(file = test_path("example_files", "tralala.txt")),
                 "'file' does not exist!")
  
  expect_type(check_result_file(file = test_path("example_files", "tralala.txt")),
              type = "logical")
  
  expect_type(check_result_file(file = test_path("example_files", "mq_data.txt")),
              type = "logical")
  
  expect_false(check_result_file())
  
  expect_false(check_result_file(file = test_path("example_files", "tralala.txt")))
  
  expect_true(check_result_file(file = test_path("example_files", "mq_data.txt")))
  
  # read result file
  expect_message(read_mq_file(),
                 "No file specified!")
  
  expect_message(read_mq_file(file = test_path("example_files", "tralala.txt")),
                 "'file' does not exist!")
  
  expect_type(read_mq_file(file = test_path("example_files", "tralala.txt")),
              type = "NULL")
  
  expect_type(read_mq_file(file = test_path("example_files", "mq_data.txt")),
              type = "list")
})