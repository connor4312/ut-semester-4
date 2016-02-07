set.seed(8208)
data <- rpois(10000, 4)

png(filename="sta248-a1-q5-a.png",
    units="px",
    width=800,
    height=600)
hist(data)
