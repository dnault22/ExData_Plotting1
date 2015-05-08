plot1.R
#set working directory, pull file into a table with headers separated by a ";"
setwd("~/Desktop/CourseraR")
file <- "household_power_consumption.txt"
hpcDat <- read.table(file, header = TRUE, sep=";")

hpcDat$Date <- as.Date(hpcDat$Date, format = "%d/%m/%Y") #change Date column into date format
hpcDates <- hpcDat[(hpcDat$Date=="2007-02-01") | (hpcDat$Date=="2007-02-02"),] #select only the respective dates from the data
hpcDates$Global_active_power <- as.numeric(as.character(hpcDates$Global_active_power)) #set the global active power to a numeric
gap <- as.numeric(as.character(hpcDates$Global_active_power)) #create a new object (gap) to use in the histogram 

hist(gap, freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
        #histogram of the global access power for the specified dates in red

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
#save file as plot1.png