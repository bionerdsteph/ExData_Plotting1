fileURL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##set location for file download

temp<-tempfile() ##creates temp file for zipped file to go

download.file(fileURL,temp) ##downloaded zipped file in to temp

rawdata<-read.table(unz(temp,"household_power_consumption.txt"),sep=";") ##extracts file and forms data table of it

unlink(temp) ##gets rid of the temp file

DateData<-mutate(rawdata,Date=dmy(rawdata$Date)) ##Formats character dates to readable dates

DateSubset <- DateData[DateData$Date >= "2007-01-02" & DateData$Date <= "2007-02-02",] ## Subsets data to specific dates

