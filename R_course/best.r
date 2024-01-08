# Finding the best hospital in a state
# enter state name and the outcome you want
# state name is the two letter abbreviation
# outcome can be heart attack, heart failure or pneumonia
#the hospital with the least 30-day death rate for that outcome
# in that state will be printed out.

#set working directory
setwd("/Users/dehshini/code/R/intro_R")

best <- function(state, outcome) {
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
    # return hospital name in that state with lowest 30-day death
    # rate
    print(outcomedata[1, 2])
}

#example use
#best("TX", "heart attack")
#best("TX", "heart failure")
#best("MD", "heart attack")
#best("MD", "pneumonia")
#best("BB", "heart attack")
#best("NY", "hert attack")