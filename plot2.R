# Download data
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 

if (file.exists("household_power_consumption.zip") || 
    file.exists("household_power_consumption.txt")) { 
    message("Data file exists")
} else {message("Downloading data file") 
    download.file(url=link, destfile="household_power_consumption.zip") 
}

# Unzip data
if (file.exists("household_power_consumption.txt")) { 
    message("Data already unzipped") 
} else { 
    message("Extracting data") 
    unzip(zipfile="household_power_consumption.zip")   
} 

# Read data
data <- read.table(file="household_power_consumption.txt", sep=";", 
                   header=TRUE, na.strings="?")

# Clean data
data$datetime <- strptime(paste(data$Date,data$Time, sep = " "), 
                          format = "%d/%m/%Y %H:%M:%S") 

# Subset the data
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02")) 
data_subset<-data[as.Date(data$datetime) %in% dates,] 

# Create the plot
png(filename = "plot2.png", width = 480, height = 480) 
with(data_subset, plot(y = Global_active_power, x = datetime, type = "n", 
                       xlab = "", ylab ="Global Active Power (kilowatts)")) 
with(data_subset, lines(y = Global_active_power, x = datetime)) 
dev.off() 


