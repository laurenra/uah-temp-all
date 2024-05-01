## Function to move columns
# see:
# https://stackoverflow.com/questions/22286419/move-a-column-to-first-position-in-a-data-frame
# https://stackoverflow.com/questions/3369959/moving-columns-within-a-data-frame-without-retyping
#
# options: first, last, before, after
#
# examples:
# mydf <- data.frame(matrix(1:12, ncol = 4))
# mydf.cols <- moveme(names(mydf), "X4 first")
# mydf2 <- mydf[, mydf.cols]
#
# mydf.cols <- moveme(names(mydf), "X1 last")
# mydf.cols <- moveme(names(mydf), "X2 before X1; X4 before X3")
#
moveme <- function (invec, movecommand) {
    movecommand <- lapply(strsplit(strsplit(movecommand, ";")[[1]],
                                   ",|\\s+"), function(x) x[x != ""])
    movelist <- lapply(movecommand, function(x) {
        Where <- x[which(x %in% c("before", "after", "first",
                                  "last")):length(x)]
        ToMove <- setdiff(x, Where)
        list(ToMove, Where)
    })
    myVec <- invec
    for (i in seq_along(movelist)) {
        temp <- setdiff(myVec, movelist[[i]][[1]])
        A <- movelist[[i]][[2]][1]
        if (A %in% c("before", "after")) {
            ba <- movelist[[i]][[2]][2]
            if (A == "before") {
                after <- match(ba, temp) - 1
            }
            else if (A == "after") {
                after <- match(ba, temp)
            }
        }
        else if (A == "first") {
            after <- 0
        }
        else if (A == "last") {
            after <- length(myVec)
        }
        myVec <- append(temp, values = movelist[[i]][[1]], after = after)
    }
    myVec
}


#### Get UAH data
# 1. get from URL
# 2. remove footer, keep data only
# 3. create dataframe
# 4. change column names
# 5. create date column ("Date") from Year and Month, format as YYYY-MM-DD
# 6. move Date to first column, requires moveme() function to be loaded, see below
# 7. save as CSV
# TODO: drop Year and Mo columns, move Date to 1st column, rename headers
install.packages("RCurl")
library("RCurl")
uah.raw <- getURL("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")
uah.data <- substr(uah.raw, 1, regexpr("\n Year", uah.raw))
rm(uah.raw)
uah.monthly <- read.table(textConnection(uah.data), header = TRUE)
rm(uah.data)
names(uah.monthly) <- c("Year", "Month",
"Global", "GLand", "GOcean",
"NH", "NLand", "NOcean",
"SH", "SLand", "SOcean",
"Tropics", "TLand", "TOcean",
"NExtTrpc", "NxLand", "NxOcean",
"SExtTrpc", "SxLand", "SxOcean",
"NoPolar", "NpLand", "NpOcean",
"SoPolar", "SpLand", "SpOcean",
"USA48", "USA49", "AUS")
# Concatenate the Year and Month columns into a Date column (Y-m-d), with the day being the 1st of the month.
uah.monthly$Date <- as.Date(paste(uah.monthly$Year, uah.monthly$Month, 1, sep = "-"), "%Y-%m-%d")
# Delete the Year and Month columns
uah.monthly = subset(uah.monthly, select = -c(Year,Month))
uah.rearranged.columns <- moveme(names(uah.monthly), "Date first")
uah.monthly <- uah.monthly[, uah.rearranged.columns]
rm(uah.rearranged.columns)
# write.csv(uah.monthly, file = "~/Development/R/uah-monthly-all.csv", row.names = FALSE)
write.csv(uah.monthly, file = "~/Dev/Node/plotly-practice-1/uah-monthly-all.csv", row.names = FALSE)

