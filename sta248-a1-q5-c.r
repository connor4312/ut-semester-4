set.seed(8208)
data <- replicate(10000, rpois(16, 4))


png(filename="sta248-a1-q5-c.png",
    units="px",
    width=800,
    height=600)

hist(data, breaks=20)
print(paste("Mean:", mean(data)))
print(paste("Stddev:", sd(data)))
