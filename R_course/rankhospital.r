setwd("/Users/Dehshini/code/R/intro_R")

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    rawoutcome <- read.csv("data/ass3/outcome-of-care-measures.csv", colClasses = "character")
    outcomedata <- rawoutcome[, c(1, 2, 7, 11, 17, 23)]
    ## Check that state and outcome are valid
    if (state %in% rawoutcome$State == FALSE) {
        stop("invalid state")
    }
    if (outcome %in% c("heart attack", "heart failure", "pneumonia") == FALSE) {
        stop("invalid outcome")
    }

    ## Return hospital name in that state with lowest 30-day death
    ## rate

    if (outcome == "heart attack") {
        # convert the mortality column to numeric
        outcomedata[, 4] <- as.numeric(outcomedata[, 4])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange by mortality and hospital.name
        # assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                State == state &
                    !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.Name)
    } else if (outcome == "heart failure") {
        # convert the mortality column to numeric
        outcomedata[, 5] <- as.numeric(outcomedata[, 5])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange by mortality and hospital.name
        # assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                State == state &
                    !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.Name)
    } else {
        # convert the mortality column to numeric
        outcomedata[, 6] <- as.numeric(outcomedata[, 6])
        # remove rows with NA in the mortality column and
        # drop rows with state != state, arrange and assign to outcomedata
        outcomedata <- outcomedata %>%
            filter(
                State == state &
                    !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
            ) %>%
            arrange(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, Hospital.Name)
    }
    # return hospital name in that state with the specified rank
    # 30-day death rate
    if (num == "best") {
        return(outcomedata[1, 2])
    } else if (num == "worst") {
        return(outcomedata[nrow(outcomedata), 2])
    } else {
        return(outcomedata[num, 2])
    }
}

#example usage
# rankhospital("TX", "heart failure", "worst")
# rankhospital("MD", "heart attack", "best")
# rankhospital("MN", "heart attack", 5000)