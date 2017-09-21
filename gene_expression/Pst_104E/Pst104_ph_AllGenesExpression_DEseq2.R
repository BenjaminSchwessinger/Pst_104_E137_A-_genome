#################################################################################################################################################################
theme_Publication <- function(base_size=14, base_family="helvetica") {
  library(grid)
  library(ggthemes)
  (theme_foundation(base_size=base_size, base_family=base_family)
    + theme(plot.title = element_text(face = "bold",
                                      size = rel(1.2), hjust = 0.5),
            text = element_text(),
            panel.background = element_rect(colour = NA),
            plot.background = element_rect(colour = NA),
            panel.border = element_rect(colour = NA),
            axis.title = element_text(face = "bold",size = rel(1)),
            axis.title.y = element_text(angle=90,vjust =2),
            axis.title.x = element_text(vjust = -0.2),
            axis.text = element_text(), 
            axis.line = element_line(colour="black"),
            axis.ticks = element_line(),
            panel.grid.major = element_line(colour="#f0f0f0"),
            panel.grid.minor = element_blank(),
            legend.key = element_rect(colour = NA),
            legend.position = "bottom",
            legend.direction = "horizontal",
            legend.key.size= unit(0.2, "cm"),
            legend.title = element_text(face="italic"),
            plot.margin=unit(c(10,5,5,5),"mm"),
            strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
            strip.text = element_text(face="bold")
    ))
  
}

scale_fill_Publication <- function(...){
  library(scales)
  discrete_scale("fill","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

scale_colour_Publication <- function(...){
  library(scales)
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}
########################################################################################
########################################################################################
##########################################################
# Now try DESeq2 on the pcontig data
##########################################################
countsTable = read.delim(file = "Pst_104E_v12_ph_ctg.in_house_IDParent.STAR.featureCounts.csv", 
                         sep=",", header=TRUE, 
                         row.names=1)
head(countsTable)

coldata <- read.csv("DeSeq2_Pst104Expression.csv",row.names=1)
head(coldata)

all(rownames(coldata) %in% colnames(countsTable))

dds <- DESeqDataSetFromMatrix(countData = countsTable,
                              colData = coldata,
                              design = ~ condition)
dds

# minimal pre-filtering to remove rows that have only 0 or 1 read
dds <- dds[ rowSums(counts(dds)) > 1, ]
########################################################################################
dds <- DESeq(dds)
########################################################################################
rld <- rlog(dds, blind=FALSE)
sampleDists <- dist(t(assay(rld)))

sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(rld$condition, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

plotPCA(rld, intgroup=c("condition"))

########################################################################################
pcaData <- plotPCA(rld, returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

head(pcaData)

p1 <- ggplot(pcaData, aes(x = PC1, y = PC2)) +
  geom_point(size =3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  coord_fixed() + 
  scale_shape_manual(values=1:nlevels(pcaData$group)) +
  geom_point(aes(fill=pcaData$group),colour="black",pch=21, size=5) +
  scale_fill_brewer("Sample", palette="Spectral") 

g1 <- p1 + scale_fill_Publication() + theme_Publication() + scale_fill_discrete(name = "")

g1

tiff("DeSeq2_PCAplot_Pst104_ph_ctgs.tiff", height = 6, width = 8, units = 'in', res = 300)
g1
dev.off()
########################################################################################
res <- results(dds, contrast=c("condition","Haustoria","GerminatedSpores"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)

plotMA(res, ylim=c(-2,2))

write.csv(as.data.frame(res), 
          file="DEseq2_phctg_HaustoriavsGerminatedSpores.csv")
########################################################################################
res <- results(dds, contrast=c("condition","6dpi","GerminatedSpores"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_6dpivsGerminatedSpores.csv")
########################################################################################
res <- results(dds, contrast=c("condition","9dpi","GerminatedSpores"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_9dpivsGerminatedSpores.csv")
########################################################################################
res <- results(dds, contrast=c("condition","UngerminatedSpores","GerminatedSpores"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_UngerminatedSporesvsGerminatedSpores.csv")
########################################################################################
res <- results(dds, contrast=c("condition","9dpi","6dpi"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_9dpivs6dpi.csv")
########################################################################################
res <- results(dds, contrast=c("condition","6dpi","Haustoria"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_6dpivsHaustoria.csv")
########################################################################################
res <- results(dds, contrast=c("condition","9dpi","Haustoria"))
res
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)
write.csv(as.data.frame(res), 
          file="DEseq2_phctg_9dpivsHaustoria.csv")
########################################################################################
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:500]

dat <- assay(rld)[select,]

dat  <- dat - rowMeans(dat)
dat <- as.matrix(dat)

wss <- (nrow(dat)-1)*sum(apply(dat,2,var))
for (i in 2:30){
  set.seed(1234)
  wss[i] <- sum(kmeans(dat, centers=i)$withinss)}
plot(1:30, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

library(cluster)
library(fpc)
clus <- kmeans(dat, centers=5)
clusplot(dat, clus$cluster, color=TRUE, shade=TRUE, labels=4, lines=0)
plotcluster(dat, clus$cluster)

k <- kmeans(dat, 5)
m.kmeans<- cbind(dat, k$cluster) # combine the cluster with the matrix
dim(m.kmeans)
o<- order(m.kmeans[,16]) # order the last column
m.kmeans<- m.kmeans[o,] # order the matrix according to the order of the last column

hmcol = colorRampPalette(brewer.pal(9, "GnBu"))(100)

png("Pst104_ph_Top500GenesExpressed_Clustering_kmeans.png", height = 30, width = 15, units = 'in', res = 300)
heatmap.2(m.kmeans[,1:15], col = hmcol, trace="none", margin=c(10, 30), 
          Colv=FALSE, Rowv=FALSE, density.info='none', lhei=c(0.03, 1), 
          RowSideColors=as.character(as.numeric(m.kmeans[,16])),
          sepwidth=c(0.05,0.05), sepcolor="white")
dev.off()
########################################################################################