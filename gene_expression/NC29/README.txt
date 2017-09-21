#This folder includes the gene expression data for NC29

We have reads for Germinated spores (GS), infected oat and 2 and 5 days (2,5) and haustoria (H). 

The key for the different 'treatments' are as follows.

GS = germinated spores
HS = haustoria
IT = infected tissue [including day]

Mapping was done with HISAT2.

Differential expression analysis was done with the R script NC29_AllGenesExpression_DEseq2.R found here.

Detailed information about DESeq2 can be found here: http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

The csv tables contain differential expression testing results, these are not filtered for fold change thresholds or p-values yet. The columns 'log2FoldChange' and 'padj' are the relevant ones for filtering for logFC and adjusted p-value. In the DESeq2 manual they suggest padj < 0.1.
