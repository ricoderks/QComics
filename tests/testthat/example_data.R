### Create example data for the test and store it as a .Rdata file
# saving is done at the bottom

# seed random generator
set.seed(42)

# some random numbers 
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

# make QC data
qc_data <- structure(list(Index = c(1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 4L, 4L, 4L, 5L, 5L, 5L, 6L, 6L, 6L, 7L, 7L, 7L, 8L, 8L, 8L, 9L,  9L, 9L), 
                          filename = c("D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_001.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_002.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)", 
                                       "D:\\Analyst Data\\Projects\\Rico\\my_project\\Data\\QCpool_003.wiff (sample 1)"
                          ), 
                          compound = c("Peak01", "Peak01", "Peak01", "Peak02", "Peak02", 
                                       "Peak02", "Peak03", "Peak03", "Peak03", "Peak01", "Peak01", "Peak01", 
                                       "Peak02", "Peak02", "Peak02", "Peak03", "Peak03", "Peak03", "Peak01", 
                                       "Peak01", "Peak01", "Peak02", "Peak02", "Peak02", "Peak03", "Peak03", 
                                       "Peak03"), 
                          short_filename = c("QCpool_001", "QCpool_001", "QCpool_001", 
                                             "QCpool_001", "QCpool_001", "QCpool_001", "QCpool_001", "QCpool_001", 
                                             "QCpool_001", "QCpool_002", "QCpool_002", "QCpool_002", "QCpool_002", 
                                             "QCpool_002", "QCpool_002", "QCpool_002", "QCpool_002", "QCpool_002", 
                                             "QCpool_003", "QCpool_003", "QCpool_003", "QCpool_003", "QCpool_003", 
                                             "QCpool_003", "QCpool_003", "QCpool_003", "QCpool_003"),
                          sequence = c(1, 
                                       1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
                                       1, 1, 1, 1, 1), 
                          acq_order = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
                                        1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 
                                        3L, 3L, 3L), 
                          parameter = c("area", "ret_time", "width50", "area", 
                                        "ret_time", "width50", "area", "ret_time", "width50", "area", 
                                        "ret_time", "width50", "area", "ret_time", "width50", "area", 
                                        "ret_time", "width50", "area", "ret_time", "width50", "area", 
                                        "ret_time", "width50", "area", "ret_time", "width50"), 
                          value = c(101370, 
                                    1.2, 0.09, 99435, 5.6, 0.1, 100363, 9.6, 0.1, 100632, 1.2, 0.11, 
                                    100404, 5.6, 0.1, 99893, 9.6, 0.07, 101511, 1.2, 0.08, 99905, 
                                    5.6, 0.11, 102018, 9.6, 0.1), 
                          avg_all = c(101171, 1.2, 0.0933333333333333, 
                                      99914.6666666667, 5.6, 0.103333333333333, 100758, 9.6, 0.09, 
                                      101171, 1.2, 0.0933333333333333, 99914.6666666667, 5.6, 0.103333333333333, 
                                      100758, 9.6, 0.09, 101171, 1.2, 0.0933333333333333, 99914.6666666667, 
                                      5.6, 0.103333333333333, 100758, 9.6, 0.09), 
                          rsd_all = c(0.466617470174096, 
                                      0, 16.3663417676994, 0.48498617489313, 0, 5.58726066957702, 1.10781288400928, 
                                      0, 19.2450089729875, 0.466617470174096, 0, 16.3663417676994, 
                                      0.48498617489313, 0, 5.58726066957702, 1.10781288400928, 0, 19.2450089729875, 
                                      0.466617470174096, 0, 16.3663417676994, 0.48498617489313, 0, 
                                      5.58726066957702, 1.10781288400928, 0, 19.2450089729875), 
                          rsd_all_show = c("Peak01 - 0.47%", 
                                           "Peak01 - 0.0%", "Peak01 - 16.4%", "Peak02 - 0.48%", "Peak02 - 0.0%", 
                                           "Peak02 - 5.6%", "Peak03 - 1.1%", "Peak03 - 0.0%", "Peak03 - 19.2%", 
                                           "Peak01 - 0.47%", "Peak01 - 0.0%", "Peak01 - 16.4%", "Peak02 - 0.48%", 
                                           "Peak02 - 0.0%", "Peak02 - 5.6%", "Peak03 - 1.1%", "Peak03 - 0.0%", 
                                           "Peak03 - 19.2%", "Peak01 - 0.47%", "Peak01 - 0.0%", "Peak01 - 16.4%", 
                                           "Peak02 - 0.48%", "Peak02 - 0.0%", "Peak02 - 5.6%", "Peak03 - 1.1%", 
                                           "Peak03 - 0.0%", "Peak03 - 19.2%"), 
                          minmax_all = c(0.991340839908975, 
                                         1, 0.727272727272727, 0.990348990080076, 1, 0.909090909090909, 
                                         0.97917034248858, 1, 0.7, 0.991340839908975, 1, 0.727272727272727, 
                                         0.990348990080076, 1, 0.909090909090909, 0.97917034248858, 1, 
                                         0.7, 0.991340839908975, 1, 0.727272727272727, 0.990348990080076, 
                                         1, 0.909090909090909, 0.97917034248858, 1, 0.7), 
                          max_y = c(NA, 
                                    1.2, NA, NA, 5.6, NA, NA, 9.6, 0.1, NA, 1.2, 0.11, 100404, 5.6, 
                                    NA, NA, 9.6, NA, 101511, 1.2, NA, NA, 5.6, 0.11, 102018, 9.6, 
                                    0.1), 
                          avg_per = c(101171, 1.2, 0.0933333333333333, 99914.6666666667, 
                                      5.6, 0.103333333333333, 100758, 9.6, 0.09, 101171, 1.2, 0.0933333333333333, 
                                      99914.6666666667, 5.6, 0.103333333333333, 100758, 9.6, 0.09, 
                                      101171, 1.2, 0.0933333333333333, 99914.6666666667, 5.6, 0.103333333333333, 
                                      100758, 9.6, 0.09), 
                          rsd_per = c(0.466617470174096, 0, 16.3663417676994, 
                                      0.48498617489313, 0, 5.58726066957702, 1.10781288400928, 0, 19.2450089729875, 
                                      0.466617470174096, 0, 16.3663417676994, 0.48498617489313, 0, 
                                      5.58726066957702, 1.10781288400928, 0, 19.2450089729875, 0.466617470174096, 
                                      0, 16.3663417676994, 0.48498617489313, 0, 5.58726066957702, 1.10781288400928, 
                                      0, 19.2450089729875), rsd_per_show = c("0.47%", "0.0%", "16.4%", 
                                                                             "0.48%", "0.0%", "5.6%", "1.1%", "0.0%", "19.2%", "0.47%", "0.0%", 
                                                                             "16.4%", "0.48%", "0.0%", "5.6%", "1.1%", "0.0%", "19.2%", "0.47%", 
                                                                             "0.0%", "16.4%", "0.48%", "0.0%", "5.6%", "1.1%", "0.0%", "19.2%"
                                      ), 
                          minmax_per = c(0.991340839908975, 1, 0.727272727272727, 0.990348990080076, 
                                         1, 0.909090909090909, 0.97917034248858, 1, 0.7, 0.991340839908975, 
                                         1, 0.727272727272727, 0.990348990080076, 1, 0.909090909090909, 
                                         0.97917034248858, 1, 0.7, 0.991340839908975, 1, 0.727272727272727, 
                                         0.990348990080076, 1, 0.909090909090909, 0.97917034248858, 1, 
                                         0.7), max_x = c(NA, 3L, NA, NA, 3L, NA, NA, 3L, 3L, NA, 3L, 3L, 
                                                         3L, 3L, NA, NA, 3L, NA, 3L, 3L, NA, NA, 3L, 3L, 3L, 3L, 3L)), 
                     class = c("tbl_df", 
                               "tbl", "data.frame"), 
                     row.names = c(NA, -27L))

# nice df for all sequences
nice_df_all <- structure(list(compound = c("Peak01", "Peak02", "Peak03"), 
                              avg_all_area = c(101171, 99915, 100758),
                              rsd_all_area = c("0.47", "0.48", "1.11"), 
                              minmax_all_area = c("0.99", "0.99", "0.98"), 
                              avg_all_ret_time = c("1.20", "5.60", "9.60"), 
                              rsd_all_ret_time = c("0.0", "0.0", "0.0"), 
                              avg_all_width50 = c("0.093", "0.103", "0.090"), 
                              rsd_all_width50 = c("16.4", " 5.6", "19.2"
                              )), 
                         row.names = c(NA, -3L), 
                         class = c("tbl_df", "tbl", "data.frame"
                         ))
# nice df per sequence
nice_df_per <- structure(list(compound = c("Peak01", "Peak02", "Peak03"), 
                              sequence = c(1, 1, 1), 
                              avg_per_area = c(101171, 99915, 100758), 
                              rsd_per_area = c("0.47", "0.48", "1.11"), 
                              minmax_per_area = c("0.99", "0.99", "0.98"), 
                              avg_per_ret_time = c("1.20", "5.60", "9.60"), 
                              rsd_per_ret_time = c("0.0", "0.0", "0.0"), 
                              avg_per_width50 = c("0.093", "0.103", "0.090"), 
                              rsd_per_width50 = c("16.4", " 5.6", "19.2")), 
                         row.names = c(NA, -3L), 
                         class = c("tbl_df", "tbl", "data.frame"))


# save everything as a .Rdata file
save(areas, ret_times, widths, meta_data, mq_data, merged_data, qc_data, nice_df_all, nice_df_per,
     file = "tests/testthat/example_data.Rdata")
