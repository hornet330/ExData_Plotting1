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

dev.copy(png, file = "plot3.png")

plot(df$DateTime,df$Sub_metering_1, ylab = "Energy sub metering", xlab="", type = "l")
lines(df$DateTime,df$Sub_metering_2, col="red")
lines(df$DateTime,df$Sub_metering_3, col="blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          pch = c(NA, NA, NA),
          col = c("black","red","blue"),
          lwd = 1, cex = 0.9)
          
dev.off()