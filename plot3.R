#read file from CSV
dati<- read.csv("household_power_consumption.txt",na.strings = "?", stringsAsFactors = F, sep = ";")
# convert data drom character to date
dati$Date=paste(dati$Date,dati$Time)
dati[,1]=as.POSIXct(dati[,1], format = "%d/%m/%Y %H:%M:%S")
# filter only dates of 01-02/02/2007
datifiltrati<- dati[dati$Date>=as.POSIXct("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & dati$Date<as.POSIXct("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S"),c(1,7,8,9)]
#draw plot
with(datifiltrati,plot(x = datifiltrati$Date,y=datifiltrati$Sub_metering_1,type = "l", col="black", ylab="Energy sub metering", xlab=""))
lines(x = datifiltrati$Date,y=datifiltrati$Sub_metering_2,col="red")
lines(x = datifiltrati$Date,y=datifiltrati$Sub_metering_3,col="blue")
temp<-legend("topright", legend=c(" "," "," "),lwd = 1, col=c("black","red","blue"),cex=1,xjust = 1,yjust = 1,text.width = strwidth(names(datifiltrati)[2]))
text(temp$rect$left + temp$rect$w, temp$text$y,c(names(datifiltrati)[2],names(datifiltrati)[3],names(datifiltrati)[4]), pos = 2)
#write png file
dev.copy(png,filename = "plot3.png", width = 480, height = 480, units = "px")
dev.off()