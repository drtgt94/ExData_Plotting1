#load sqldf package
library(sqldf)
#Read in data - only reads in data where date is Feb 1st or 2nd 2007
powerData <- read.csv.sql("./data/household_power_consumption.txt"
                     , header = TRUE
                     , sep=";"
                     , sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

#Create a vector that combines Date and Time from the downloaded file
dateTime <- strptime(paste(powerData$Date, powerData$Time),"%d/%m/%Y %H:%M:%S")

#Add the combined dateTime field to the dataset
powerData <- cbind(dateTime, powerData)

#Set margins, number of graphs and font size
par(mar = c(4,4,2,2), mfcol = c(1,1), cex = 0.7)
#Plot the graph
with(powerData, {
        hist(Global_active_power
             , col = "red"
             , main = "Global Active Power"
             , xlab = "Global Active Power (kilowatts)"
             , ylab = "Frequency")
        })

#Send the graph to a .png file
dev.copy(png, file = "./Course4Project1/plot1.png", width=480, height=480)
dev.off()

