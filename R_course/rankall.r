#set working directory
setwd("/Users/dehshini/code/R/intro_R")

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    rawoutcome <- read.csv("data/ass3/outcome-of-care-measures.csv", colClasses = "character")
    outcomedata <- rawoutcome[, c(1, 2, 7, 11, 17, 23)]
    ## Check that state and outcome are valid
    if (outcome %in% c("heart attack", "heart failure", "pneumonia") == FALSE) {
        stop("invalid outcome")
    }
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    if (outcome == "heart attack") {
        # convert the mortality column to numeric
        outcomedata[, 4] <- as.numeric(outcomedata[, 4])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange by mortality and hospital.name
        # assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.Name) %>%
            split(~State)
    } else if (outcome == "heart failure") {
        # convert the mortality column to numeric
        outcomedata[, 5] <- as.numeric(outcomedata[, 5])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange by mortality and hospital.name
        # assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.Name) %>%
            split(~State)
    } else {
        # convert the mortality column to numeric
        outcomedata[, 6] <- as.numeric(outcomedata[, 6])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange and assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, Hospital.Name) %>%
            split(~State)
    }
    # return dataframe with hospital name and state with the specified rank
    # 30-day death rate 
    outcome_at_num <- lapply(outcomedata, function(x) {
        if (num == "best") {
            return(x[1, 2])
        } else if (num == "worst") {
            return(x[nrow(x), 2])
        } else {
            return(x[num, 2])
        }
    })
    # convert list to data frame
    data.frame(hospital = unlist(outcome_at_num), state = names(outcome_at_num))
}

#example usage
# rankall("heart attack", 4)
# rankall("pneumonia", "worst")
# rankall("heart failure", 10)