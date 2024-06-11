#!/usr/bin/env Rscript
library(data.table)
args = commandArgs(trailingOnly=TRUE)

# load csv files
dat <- read.csv("AllCandidates.complete.annotated.flat.csv")
questions <- read.csv("questions.csv", header=FALSE, sep=";")

if (length(args) == 0) {
  topic <- ''
} else {
  topic <- args[1]
}

# subset of questions based on topic
topicIds <- questions[questions[, 2] %like% topic,c(1)]
topics <- questions[questions[, 2] %like% topic,c(2)]

topicsList <- as.vector(as.matrix(topics))
uniqueTopics <- toString(unique(topicsList))

print(paste("Query: ", topic))
print(paste("Questions found: ", length(topicsList)))
print("Topics found: ")
print(paste("  ", uniqueTopics))

allTopics <- as.vector(as.matrix(questions[,c(2)]))
print(paste("All questions: ", length(allTopics)))
print("All topics: ")
print(paste("  ", toString(unique(allTopics))))

if (length(topicsList) == 0) {
	quit()
}

# reduce dataset based on selected topics
dat <- dat[,c(1,2, 2+ topicIds)]

# raw data without metadata
x <- as.matrix(dat[, c(-1,-2)])

rownames(x) <- dat[,c(2)]
manhattan_distance <- function (v1, v2) sum(abs(v1 - v2))
res <- usedist::dist_make(x, manhattan_distance)
m <- as.matrix(res)

# add parti column to result
joined <- cbind(Parti = dat$Parti, m)

finalResult <- joined[order(as.numeric(joined[, 2])), c(1,2)]
finalResult