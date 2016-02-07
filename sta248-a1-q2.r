data <- c(
    9.1, 10.1, 9.0, 11.4,
    10.5, 9.5, 12.0, 9.1,
    12.2, 13.1, 10.0, 9.3,
    9.0, 9.6, 11.1, 9.1,
    13.3, 10.7, 9.1, 9.0,
    9.0, 11.0, 9.2, 11.6
)

stem(data)
print(paste("Mean:", mean(data)))
print(paste("Median:", median(data)))
print(paste("Variance:", var(data)))
print(paste("Stddev:", sd(data)))
