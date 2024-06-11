#!/usr/bin/env Rscript
library(data.table)
args = commandArgs(trailingOnly=TRUE)

# load csv files
dat <- read.csv("AllCandidates.complete.annotated.flat.csv")
questions <- read.csv("questions.csv", header=FALSE, sep=";")

if (length(args) > 0)
{
  # subset of questions based on topic
  topic <- args[1]
  topicIds <- questions[questions[, 2] %like% topic,c(1)]
  topics <- questions[questions[, 2] %like% topic,c(2)]
  df2 <- as.vector(as.matrix(topics))
  uniqueTopics <- toString(unique(df2))
  print(paste("Search: ", topic))
  print(paste("Topics found: ", uniqueTopics))
  print(paste("Questions found: ", length(df2)))
  if (length(df2) == 0)
  {
	allTopics <- toString(unique(as.vector(as.matrix(questions[,c(2)]))))
	print(paste("Possible topics: ", allTopics))
	quit()
  }

  # reduce dataset based on selected topics
  dat <- dat[,c(1,2, 2+ topicIds)]
}

# raw data without metadata
x <- as.matrix(dat[, c(-1,-2)])

rownames(x) <- dat[,c(2)]
manhattan_distance <- function (v1, v2) sum(abs(v1 - v2))
res <- usedist::dist_make(x, manhattan_distance)

m <- as.matrix(res)

# add parti column to result
joined <- cbind(Parti = dat$Parti, m)

finalResult <- joined[order(joined[, 2]), c(1,2)]
finalResult