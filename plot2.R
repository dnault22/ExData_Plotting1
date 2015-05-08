plot2.R

#set working directory, pull file into a table with headers separated by a ";"
setwd("~/Desktop/CourseraR")
file <- "household_power_consumption.txt"
hpcDat <- read.table(file, header = TRUE, sep=";")

hpcDat$Date <- as.Date(hpcDat$Date, format = "%d/%m/%Y") #change Date column into date format
hpcDates <- hpcDat[(hpcDat$Date=="2007-02-01") | (hpcDat$Date=="2007-02-02"),] #select only the respective dates from the data
hpcDates$Global_active_power <- as.numeric(as.character(hpcDates$Global_active_power)) #set the global active power to a numeric
hpcDates <- transform(hpcDates, time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") #transform the date and time using POSIXct to the correct format

plot(hpcDates$time,hpcDates$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        #line plot of the days and global active power

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
#save file as plot2.png