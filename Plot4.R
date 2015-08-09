fileURL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
                ##set location for file download

temp<-tempfile() ##creates temp file for zipped file to go

download.file(fileURL,temp) ##downloaded zipped file in to temp

rawdata<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE) 
                        ##extracts file and forms data table of it

unlink(temp) ##gets rid of the temp file

TimeDate<-paste(rawdata$Date,rawdata$Time) ##Combines Date and Time into vector

TimeDate2<-as.POSIXct(strptime(TimeDate,format="%d/%m/%Y %H:%M:%S")) 
                                ## Converts Date Time into POSIXct

Data2<-mutate(rawdata,Date_Time=TimeDate2) ##adds new column to data of merged Date TimeData2

DateSubset <- subset(Data2,Date_Time >= "2007-02-01" & Date_Time < "2007-02-03") 
                                ##Subsets for specific dates

par(mfrow=c(2,2)) ##Sets up for a 2x2 grid of graphs

plot(DateSubset$Date_Time,DateSubset$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 
                                ##plots first graph with the proper labels

plot(DateSubset$Date_Time,DateSubset$Voltage,type="l",xlab="datetime",ylab="Voltage")
##plots second graph with proper labels

with(DateSubset,plot(Date_Time,Sub_metering_1,type="l",xlab = "", ylab = "Power sub metering")) 
                                ##builds plot with 1st series of data & axis labels for 3rd graph

with(DateSubset,lines(Date_Time,Sub_metering_2,type="l",col="red")) ##adds second series of data- 3rd graph

with(DateSubset,lines(Date_Time,Sub_metering_3,type="l",col="blue")) ## adds last series of data-3rd graph

legend("topright",pch="-",col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
                                ##adds legend to 3rd graph

plot(DateSubset$Date_Time,DateSubset$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
                                ## plots final graph with proper labels

dev.copy(png,"plot4.png") ##Creates png file of plot

dev.off() ##closes png device to finish creating file
