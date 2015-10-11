require(lubridate)
require(dplyr)

##myData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)  ##Used to know where to start reading and how many lines
##which(myData$Date == ymd(20070201) | myData$Date == ymd(20070202))
##length(which(myData$Date == ymd(20070201) | myData$Date == ymd(20070202)))

##We first need to put the file to read in the working directory. 

df <- read.table("./household_power_consumption.txt", sep = ";", skip = 66637,nrows = 2880)
colnames(df) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2", "Sub_metering_3")

df <- tbl_df(df)
df$Date <- dmy(df$Date)

##Here we create a new column with complete date and time data in the correct format
df <- mutate(df, DateTime = as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S", tz="UTC")) 

df$Global_active_power <- as.numeric(df$Global_active_power)
par(mar = c(5,4.5,1.8,1.8), mfcol = c(2,2))  ## Setting margins and 2x2 grid for 4 plots.

dev.copy(png, file = "plot4.png")

plot(df$DateTime,df$Global_active_power, ylab = "Global Active Power", xlab="", type = "l")

plot(df$DateTime,df$Sub_metering_1, ylab = "Energy sub metering", xlab="", type = "l")
lines(df$DateTime,df$Sub_metering_2, col="red")
lines(df$DateTime,df$Sub_metering_3, col="blue")
legend("topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       pch = c(NA, NA, NA),           # Making symbol simply a line
       col = c("black","red","blue"),
       bty = "n",                     #Getting rid of the legend box line
       lwd = 1, cex = 0.9)  

plot(df$DateTime,df$Voltage, ylab = "Voltage", xlab="Datetime", type = "l")

plot(df$DateTime,df$Global_reactive_power, 
         ylab = "Global_reactive_power", 
         xlab = "Datetime",
         type = "l",
     cex.axis = 0.9) # This makes axis marks a little bit smaller to fit marks from 0 to 0.5.

dev.off()