# 7. DATES AND TIME

# In R, dates are represented by Date objects, while times are represented by POSIXct objects. Under the hood, however, these dates and times are simple numerical values.

# 7.1 Dates ####

# Simply ask R what the current date is:
today <- Sys.Date()
today
# See what type of data "today" available:
class(today) # Date: a special R object that represents dates.
# See what today looks like under the hood:
unclass(today)

# Create Date objects:
my_date <- as.Date("1971-05-14") # ISO date format by default.
# Another date format has to be defined.
my_date <- as.Date("1971-14-05", format = "%Y-%d-%m")
my_date
# In addition to creating dates, you can also convert dates to character strings that use a different date notation. For this, you use the format() function. 
# %Y: 4-digit year (1971)
# %y: 2-digit year (71)
# %m: 2-digit month (05)
# %d: 2-digit day of the month (14)
# %A: weekday (Wednesday)
# %a: abbreviated weekday (Wed)
# %B: month (January)
# %b: abbreviated month (Jan)
format(Sys.Date(), format = "%d %B, %Y")
format(Sys.Date(), format = "Today is a %A!")

# Definition of character strings representing dates:
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"
# Convert the strings to dates: 
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2)
date3 <- as.Date(str3, format = "%d/%B/%Y")
# Convert dates to formatted strings:
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

# Date arithmetic: R performs the calculations using the underlying numerical values, and then converts the result back to human-readable time information again.
my_date + 1 # 1 day increment. 
# If we want to know the difference between 2 dates:
my_date2 <- as.Date("1998-09-29")
my_date2 - my_date

# To control your eating habits, you decided to write down the dates of the last five days that you ate pizza.
day1 <- as.Date("2020-07-29")
day2 <- as.Date("2020-07-31")
day3 <- as.Date("2020-08-05")
day4 <- as.Date("2020-08-11")
day5 <- as.Date("2020-08-16")
pizza <- c(day1, day2, day3, day4, day5)
# Difference between last and first pizza day:
day5 - day1
# Use the function diff() on pizza to calculate the differences between consecutive pizza days.
day_diff <- diff(pizza)
# Average period between two consecutive pizza days:
mean(day_diff)

# Create a vector which contains character strings representing the dates on which the 4 astronomical seasons start:
astro <- c(spring = "20-Mar-2015", summer = "25-Jun-2015", fall = "23-Sep-2015", winter = "22-Dec-2015" )
# Create another vector with the meteorological beginnings of a season:
meteo <- c(spring = "March 1, 15", summer = "June 1, 15", fall = "September 1, 15", winter = "December 1, 15")
# Convert to Date object:
astro_dates <- as.Date(astro, format = "%d-%b-%Y")
meteo_dates <- as.Date(meteo, format = "%B %d, %y")
# Calculate the maximum absolute difference between astro_dates and meteo_dates:
max(abs(astro_dates - meteo_dates))

# 7.2 Time ####

# Get current time in R:
now <- Sys.time()
now
class(now) # POSIXct: apart form providing rich functionality for calculus and formatting, this class makes sure that the dates and time in R are compatible across different operating systems, according to the POSIX standard.
# See what now looks like under the hood:
unclass(now)

# Create a POSIXct object:
my_time <- as.POSIXct("1971-05-24 11:25:15")
# Similar to working with dates, as.POSIXct() is used to convert from a character string to a POSIXct object, and format() to convert from a POSIXct object to a character string.
# %H: hours as a decimal number (00-23)
# %I: hours as a decimal number (01-12)
# %M: minutes as a decimal number
# %S: seconds as a decimal number
# %T: shorthand notation for the typical format %H:%M:%S
# %p: AM/PM indicator
# For a full list of conversion symbols, ask ?strptime in Help:
?strptime
# Definition of character strings representing times:
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"
# Convert the strings to POSIXct objects:
time1 <- as.POSIXct(str1, format = "%B %d, %y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2)  
# Convert times to formatted strings:
format(time1, "%M")
format(time2, "%I:%M %p")

# POSIXct arithmetic:computaions with POSIXct happens in exact the same fashion.
my_time + 1 # 1 second increment.
# Calculate the difference between times:
my_time2 <- as.POSIXct("1974-07-14 21:11:55 CET")
my_time2 - my_time # because the time difference is so large, R simply displays the time difference in days.

# Calculations using POSIXct objects are completely analogous to those using Date objects.
now + 3600          # add an hour
now - 3600 * 24     # subtract a day
# Adding or substracting time objects is also straightforward.
birth <- as.POSIXct("1879-03-14 14:37:23")
death <- as.POSIXct("1955-04-18 03:47:12")
einstein <- death - birth
einstein

# You're developing a website that requires users to log in and out. You want to know what is the total and average amount of time a particular user spends on your website. This user has logged in 5 times and logged out 5 times as well. 
login <- as.POSIXct(c("2020-08-02 10:18:04 UTC", "2020-08-07 09:14:18 UTC", "2020-08-07 12:21:51 UTC", "2020-08-07 12:37:24 UTC", "2020-08-09 21:37:55 UTC"))
logout <- as.POSIXct(c("2020-08-02 10:56:29 UTC", "2020-08-07 09:14:52 UTC", "2020-08-07 12:35:48 UTC", "2020-08-07 13:17:22 UTC", "2020-08-09 22:08:47 UTC"))
# Calculate the difference between login and logout:
time_online <- logout - login
# Calculate the total time online:
sum(time_online)
# Calculate the average time online:
mean(time_online)