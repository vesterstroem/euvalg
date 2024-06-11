# load csv files
dat <- AllCandidates.complete.annotated.flat <- read.csv("~/git/euvalg/AllCandidates.complete.annotated.flat.csv")
questions <- read.csv("~/git/euvalg/questions.csv", header=FALSE, sep=";")

# subset of questions based on topic
topicIds <- questions[questions[, 2] %like% "GRØN OMSTILLING",c(1)]

# reduce dataset based on selected topics
dat <- dat[,c(1,2, 2+ topicIds)]

# raw data without metadata
x <- dat[, c(-1,-2)]

rownames(x) <- dat[,c(2)]
manhattan_distance <- function (v1, v2) sum(abs(v1 - v2))
res <- usedist::dist_make(x, manhattan_distance)

m <- as.matrix(res)

# add parti column to result
joined <- cbind(Parti = dat$Parti, m)

View(joined)