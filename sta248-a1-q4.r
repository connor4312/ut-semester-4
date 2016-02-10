data <- c(6.4,8.3,7.9,7.5,6.9,8.5,7.0,7.4,7.2,6.8,7.1,8.1,7.5,7.7,8.5,7.8,7.3,8.4,8.0,7.8,7.5,7.8,7.6,8.4,9.9)

stem(data, scale=2)


png(filename="sta248-a1-q4.png",
    units="px",
    width=800,
    height=200)
boxplot(data,horizontal=TRUE,outline=TRUE,plot=TRUE,axes=TRUE)
