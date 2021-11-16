test_that("Meta data can be read", {
  # check meta data file
  expect_message(check_meta_file(),
                 "No file specified!")
  
  expect_message(check_meta_file(file = test_path("example_files", "tralala.csv")),
                 "'file' does not exist!")
  
  expect_type(check_meta_file(file = test_path("example_files", "tralala.csv")),
              type = "logical")
  
  expect_type(check_meta_file(file = test_path("example_files", "meta_data.csv")),
              type = "logical")
  
  expect_false(check_meta_file())
  
  expect_false(check_meta_file(file = test_path("example_files", "tralala.csv")))
  
  expect_true(check_meta_file(file = test_path("example_files", "meta_data.csv")))
  
  # read meta data file
  expect_message(read_meta_file(),
                 "No file specified!")
  
  expect_message(read_meta_file(file = test_path("example_files", "tralala.csv")),
                 "'file' does not exist!")
  
  expect_type(read_meta_file(file = test_path("example_files", "tralala.csv")),
              type = "NULL")
  
  expect_type(read_meta_file(file = test_path("example_files", "meta_data.csv")),
              type = "list")
})
