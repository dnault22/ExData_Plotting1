plot3.R

#set working directory, pull file into a table with headers separated by a ";"
setwd("~/Desktop/CourseraR")
file <- "household_power_consumption.txt"
hpcDat <- read.table(file, header = TRUE, sep=";")

hpcDat$Date <- as.Date(hpcDat$Date, format = "%d/%m/%Y") #change Date column into date format
hpcDates <- hpcDat[(hpcDat$Date=="2007-02-01") | (hpcDat$Date=="2007-02-02"),] #select only the respective dates from the data
hpcDates$Global_active_power <- as.numeric(as.character(hpcDates$Global_active_power)) #set the global active power to a numeric
hpcDates <- transform(hpcDates, time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") #transform the date and time using POSIXct to the correct format

hpcDates$Sub_metering_1 <- as.numeric(as.character(hpcDates$Sub_metering_1)) #set all of the sub_metering variables to numerics
hpcDates$Sub_metering_2 <- as.numeric(as.character(hpcDates$Sub_metering_2))
hpcDates$Sub_metering_3 <- as.numeric(as.character(hpcDates$Sub_metering_3))

plot(hpcDates$time, hpcDates$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering") #create first plot of sm_1 in black 
lines(hpcDates$time, hpcDates$Sub_metering_2, col = "red") #add additional lines for sm_2 in red
lines(hpcDates$time, hpcDates$Sub_metering_3, col = "blue") #third line of sm_3 in blue 
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))
        #identifying the legend to the top right corner, the colors of the respective variables (sub meters) and the line type (solid)/width

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()