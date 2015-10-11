require(lubridate)
require(dplyr)


##myData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)  ##Used to know where to start reading and how many lines
##which(myData$Date == ymd(20070201) | myData$Date == ymd(20070202))
##length(which(myData$Date == ymd(20070201) | myData$Date == ymd(20070202)))  ##From here we know that we only need 2880 lines

##We first need to put the file to read in the working directory. 

df <- read.table("./household_power_consumption.txt", sep = ";", skip = 66637,nrows = 2880)
colnames(df) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2", "Sub_metering_3")
df <- tbl_df(df)
df$Date <- dmy(df$Date)  ##converting Dates to lubridate format
df$Time <- hms(df$Time)  ##Converting Times to lubridate format

df$Global_active_power <- as.numeric(df$Global_active_power)

dev.copy(png, file = "plot1.png")
hist(df$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
      col = "red")
dev.off()