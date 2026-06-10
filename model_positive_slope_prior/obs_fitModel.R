setwd("C:/TTO_/model_positive_slope_prior")

library(tidyverse)
library(glue)
# YRS = 2018
args <- commandArgs(trailingOnly = TRUE)
# YRS <- 2000+as.numeric(args[1])
# USE_ROW_WEIGHTS <- as.logical(args[2])

source("A_importRstan.R") ### import the RStan model

# Added years from 2012 - 2019
# YRS <- 2012:2019

# Experimenation lines
YRS <- 2017:2019
USE_ROW_WEIGHTS <- FALSE

# Total time taken across all model years (Added line)
total_time = c()

# Experimentation lines 
for (yr in YRS)
{

    source("A_getData.R")

    
    # Added code to calculate start time
    start_time <- Sys.time()

    model = "line"
    # Added new output_file line to save different models for each year
    # OUTPUT_FILE = paste0("obs","_model_", model, 
    #                     "yrs_", str_remove_all(paste0(yr, collapse=''), "20"),
    #                     "_",
    #                     if (USE_ROW_WEIGHTS) "InvPropWeights_" else "") 

    # Added a line to differentiate models based on their # of iterations and their # of years
    OUTPUT_FILE = paste0("obs","_model_", model, 
                        "yrs_", str_remove_all(paste0(yr, collapse=''), "20"),
                        "_iter", NUM_ITS)
                        
    # OUTPUT_FILE = paste0("obs","_model_", model, 
    #                     "yrs_", str_remove_all(paste0(YRS, collapse=''), "20"),
    #                     "_",
    #                     if (USE_ROW_WEIGHTS) "InvPropWeights_" else "") 

    # source("A_getData.R") ### get observed data 
    # source("A_importRstan.R") ### import the RStan model

    fit = fit_MODEL() ### fit the model

    # Added line to calculate end time and total time taken
    end_time <- Sys.time()
    time_taken = end_time - start_time
    total_time <- c(total_time, time_taken)
    print(glue("Year {yr} completed in {time_taken}"))


    # Added line
    dir.create(output_folder, showWarnings = FALSE, recursive = TRUE)

    dir.create(output_folder_2, showWarnings = FALSE, recursive = TRUE)

    # saveRDS(fit, file = paste0(output_folder, "fit_", OUTPUT_FILE, ".rds"))

    # Added a line to save models based on their different years
    saveRDS(fit, file = paste0(output_folder_2, "fit_", OUTPUT_FILE, ".rds" ))

}
#fit <- readRDS("./job_output/fit_sim_model_bsnBL_1.rds") 


