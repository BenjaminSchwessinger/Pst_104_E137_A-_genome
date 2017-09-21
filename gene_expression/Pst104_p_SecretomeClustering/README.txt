The secretome was filtered for genes that are differentially expressed with -1.5 < logFC > 1.5 and padj < 0.1 in at least one of the following comparisons:
- Haustoria vs. germinated spores
- 6dpi vs. germinated spores
- 9dpi vs. germinated spores
- Ungerminated vs. germinated spores

This was done so that the clustering is only done on genes that show some strong expression in the data.

The DESeq2 rlog transformation on all genes was used. The average rlogs over the replicates were calculated for each condition. For each gene in the secretome, the average rlogs were used to perform k-means clustering. The elbow plot method was used to define the optimal number of clusters. 

A heatmap was drawn for the clusters. Color intensity relates to rlog values, the darker the more highly expressed.
