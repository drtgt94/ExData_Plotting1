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
par(mar = c(4,4,2,2), mfcol = c(1,1), cex = .8)
#Plot the graph
with(powerData, {
        plot(Sub_metering_1 ~ dateTime
             , col = "black"
             , ylab = "Energy sub metering"
             , xlab = ""
             , type = "l")
        points(Sub_metering_2 ~ dateTime
             , col = "red"
             , type = "l")
        points(Sub_metering_3 ~ dateTime
             , col = "blue",
             , type = "l")
        legend("topright"
             , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
             , lty = 1
             , col = c("black", "red", "blue")
             , cex = 0.75)
})

#Send the graph to a .png file
dev.copy(png, file = "./Course4Project1/plot3.png", width=480, height=480)
dev.off()
