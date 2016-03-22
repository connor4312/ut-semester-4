p1 <- c(.26, .24, .26, .22, .25, .23, .18, .25, .19, .25, .29, .25, .23, .20, .25)
p2 <- c(.29, .32, .24, .33, .28, .27, .25, .26, .33, .33, .33, .28, .30, .24, .32)
diff <- p1 - p2

print("(a) Differences:")
print(diff)

print("(b) Average Difference:")
print(mean(diff))
print("(b) Diff Deviation:")
print(sd(diff))
