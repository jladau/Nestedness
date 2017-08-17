#!/bin/bash

sIODir=$HOME/Documents/Research/Java/Distribution/Nestedness
sOutputDir=$sIODir/test-output
sBiomPath=$sIODir/test-data/test-data.biom
sJavaDir=$sIODir/bin
sTaxonRank=otu
sNullModel=equiprobablefixed
sAxis=sample
sComparisonMode=betweeneachpairoftypes

mkdir -p $sOutputDir
cd $sOutputDir

#loading sample subset
java -cp $sJavaDir/Utilities.jar edu.ucsf.BIOM.PrintMetadata.PrintMetadataLauncher \
	--sDataPath=$sBiomPath \
	--sOutputPath=$sOutputDir/temp.0.csv \
	--sAxis=sample
cut -d\, -f1 temp.0.csv | head --lines=15 > samples-to-keep.csv

#making nestedness graph
#java -cp $sJavaDir/Autocorrelation.jar edu.ucsf.Nestedness.Grapher.GrapherLauncher --help
#exit
java -cp $sJavaDir/Autocorrelation.jar edu.ucsf.Nestedness.Grapher.GrapherLauncher \
	--sSamplesToKeepPath=$sOutputDir/samples-to-keep.csv \
	--sBIOMPath=$sBiomPath \
	--bNormalize=false \
	--sTaxonRank=$sTaxonRank \
	--sOutputPath=$sOutputDir/graphs.csv \
	--rgsSampleMetadataFields=latitude

#loading comparisons
#java -cp $sJavaDir/Autocorrelation.jar edu.ucsf.Nestedness.ComparisonSelector.ComparisonSelectorLauncher --help
#exit
java -Xmx5g -cp $sJavaDir/Autocorrelation.jar edu.ucsf.Nestedness.ComparisonSelector.ComparisonSelectorLauncher \
	--sBIOMPath=$sBiomPath \
	--sOutputPath=$sOutputDir/comparisons.csv \
	--bNormalize=false \
	--sTaxonRank=$sTaxonRank \
	--sMetadataField=latitude \
	--iRandomSeed=1234 \
	--sComparisonMode=$sComparisonMode \
	--iNestednessPairs=250 \
	--sSamplesToKeepPath=$sOutputDir/samples-to-keep.csv \
	--sNestednessAxis=$sAxis \
	--iPrevalenceMinimum=1

#running statistics
java -cp $sJavaDir/Autocorrelation.jar edu.ucsf.Nestedness.Calculator.CalculatorLauncher \
	--sBIOMPath=$sBiomPath \
	--sOutputPath=$sOutputDir/statistics.csv \
	--bNormalize=false \
	--sTaxonRank=$sTaxonRank \
	--sGraphsPath=$sOutputDir/comparisons.csv \
	--iNullModelIterations=10000 \
	--bOrdered=false \
	--sNestednessAxis=$sAxis \
	--sSamplesToKeepPath=$sOutputDir/samples-to-keep.csv \
	--sNullModel=$sNullModel \
	--iPrevalenceMinimum=1 \
	--bSimulate=false

#cleaning up
rm $sOutputDir/temp.*.*



