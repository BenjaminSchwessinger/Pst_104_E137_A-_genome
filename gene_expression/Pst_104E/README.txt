#This folder includes the gene expression data for Pst_104E_v12
The key for the different 'treatments' are as follows.

GS = germinated spores
HE = haustoria
IT = infected tissue [including day]
UG = ungerminated spores

The key for different assemblies are as follows:

Pst_104E_v12_ph = mapping against primary contigs and haplotig contigs at the same time.
Pst_104E_v12_p  = mapping against the primary contigs only

Mapping was done with the STAR script found in the script folder on NCI.
overlap counting was done with the featureCount.sh script in the script folder on fisher.

Differential expression analysis was done with the R script Pst104AllGenesExpression_DEseq2.R found here.

Detailed information about DESeq2 can be found here: http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

The csv tables contain differential expression testing results, these are not filtered for fold change thresholds or p-values yet. The columns 'log2FoldChange' and 'padj' are the relevant ones for filtering for logFC and adjusted p-value. In the DESeq2 manual they suggest padj < 0.1.


