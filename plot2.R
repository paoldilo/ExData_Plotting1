#read file from CSV
dati<- read.csv("household_power_consumption.txt",na.strings = "?", stringsAsFactors = F, sep = ";")
# convert data drom character to date
dati$Date=paste(dati$Date,dati$Time)
dati[,1]=as.POSIXct(dati[,1], format = "%d/%m/%Y %H:%M:%S")
# filter only dates of 01-02/02/2007
datifiltrati<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,3)]
#draw plot
with(datifiltrati,plot(x = datifiltrati,type = "l", ylab="Global Active Power (kilowatts)", xlab=""))
#write png file
dev.copy(png,filename = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
