#read file from CSV
dati<- read.csv("household_power_consumption.txt",na.strings = "?", stringsAsFactors = F, sep = ";")
# convert data drom character to date
dati$Date=paste(dati$Date,dati$Time)
dati[,1]=as.POSIXct(dati[,1], format = "%d/%m/%Y %H:%M:%S")
# filter only dates of 01-02/02/2007
datifiltrati<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<=as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,3)]
datifiltrati2<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<=as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,7,8,9)]
datifiltrati3<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<=as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,5)]
datifiltrati4<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<=as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,4)]
#draw plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(datifiltrati,plot(x = datifiltrati,type = "l", ylab="Global Active Power", xlab=""))
with(datifiltrati3,plot(x = datifiltrati3,type = "l", ylab="Voltage", xlab="datetime"))
with(datifiltrati2,plot(x = datifiltrati2$Date,y=datifiltrati2$Sub_metering_1,type = "l", col="black", ylab="Energy sub metering", xlab=""))
lines(x = datifiltrati2$Date,y=datifiltrati2$Sub_metering_2,col="red")
lines(x = datifiltrati2$Date,y=datifiltrati2$Sub_metering_3,col="blue")
temp<-legend("topright", legend=c(" "," "," "),lwd = 1,bty = "n", col=c("black","red","blue"),cex=1,xjust = 1,yjust = 1,text.width = strwidth(names(datifiltrati2)[2]))
text(temp$rect$left + temp$rect$w, temp$text$y,c(names(datifiltrati2)[2],names(datifiltrati2)[3],names(datifiltrati2)[4]), pos = 2,cex=1)
with(datifiltrati4,plot(x = datifiltrati4,type = "l", xlab="datetime"))
dev.off()
