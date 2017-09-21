#Small script for feature_count
ANNO=/home/benjamin/genome_assembly/PST79/FALCON/p_assemblies/v9_1/032017_assembly
bams=$(ls *.bam)
set -vex
echo $(pwd)
echo 'featureCounts -T 8 -t Name -g ID -a $ANNO/$1.anno.gff3 -G $ANNO/$1.fa -o $1.$2.STAR.featureCounts.txt -p $bams'
featureCounts -T 8 -t exon -g Parent -a $ANNO/$1.anno.gff3 -G $ANNO/$1.fa -o $1.$2.STAR.featureCounts.txt -p $bams 
