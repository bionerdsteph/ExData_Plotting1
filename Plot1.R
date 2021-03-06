fileURL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##set location for file download

temp<-tempfile() ##creates temp file for zipped file to go

download.file(fileURL,temp) ##downloaded zipped file in to temp

rawdata<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header = TRUE) ##extracts file and forms 
                                                                        ##data table of it

unlink(temp) ##gets rid of the temp file

DateData<-mutate(rawdata,Date=dmy(rawdata$Date)) ##Formats character string dates to readable dates

DateSubset <- DateData[DateData$Date >= 
                               "2007-01-31" & DateData$Date <= 
                               "2007-02-02",] ## Subsets data to specific dates

hist(as.numeric(as.character(DateSubset$Global_active_power)),col="red",
                                main="Global Active Power",
                                xlab="Global Active Power (kilowatts)",
                                ylab="Freqency") ## Creates Histogram of Global Active Power with 
                                                ##red bars and labels graph per example. Also 
                                                ##converts factor class to numeric class for kilowatts

dev.copy(png,"plot1.png") ##Creates png file of plot

dev.off() ##closes png device to finish creating file