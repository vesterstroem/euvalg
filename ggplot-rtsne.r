library(ggplot2)
library(Rtsne)

dat <- AllCandidates.complete.annotated.flat

tsne <- Rtsne(dat[!duplicated(dat), c(-1,-2)])

df <- data.frame(x = tsne$Y[,1],
                 y = tsne$Y[,2],
                 Parti = dat[!duplicated(dat), 1])

ggplot(df, aes(x, y, colour = Parti)) +
geom_point()