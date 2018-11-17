# pointszr

## Point resizing for volcano plots

-----------------------------------------------

## Description

This package allows easy creation of volcano plots, and provides functions to highlight specified genes, and genes that meet criteria of interest by changing their size representations. This simplifies comparing several test conditions against a reference condition and each other on a single scale.

## Dependancies 
    tibble,
    dplyr,
    DESeq2,
    graphics

## Usage

pointszr 0.1.0 is compatible with DESeqDataSet objects. Future renditions of this project will allow for a wider variety of cobject classes.

An example workflow could look like the following:

```R
#using simulated data provided with package
#this data has a reference condition, C 
summary(simDDS)

#compute DESeq (fit model)
simDDS <- DESeq(simDDS)

#get results 
res <- results(simDDS)

#note default reference (A) and test conditions (C)
attributes(res)$elementMetadata

#Create result sets with contrasts specified
resAB <- results(simDDS, contrast = c("condition", "A","B"))
resAC <- results(simDDS, contrast = c("condition", "A","C"))

#Plot volcano plot for first comparison
vplot(resAB, 
	  ylab = "-log10 p-value",
	  xlab = "log 2 fold change",
	  main = "sample volcano plot")

#Overlay volcano plot for second comparison
overlay(resAC, col = 2)

#Notice overlay plot may cut off some points from view 
#(see warning). Re-plot with plot with larger margins.

xWidth <- c(getPlotLims(resAC)$x, getPlotLims(resAB)$x)
xWidth <- c(min(xWidth), max(xWidth))

yWidth <- c(getPlotLims(resAC)$y, getPlotLims(resAB)$y)
yWidth <- c(min(yWidth), max(yWidth))

vplot(resAB, 
	  ylab = "-log10 p-value",
	  xlab = "log 2 fold change",
	  main = "sample volcano plot",
	  xlim = xWidth,
	  ylim = yWidth)

overlay(resAC, col = 2)

#want to vary point size to disply information. Preview sizes
sizes <- lseq(0.5, 8, length.out = 6)
szPreview(sizes)

#perhaps we are interested in a subset of genes that meet a threshold
sel <- subset(resAC, (padj<.1 & abs(log2FoldChange)>1) )

vplot(resAB, 
      ylab = "-log10 p-value",
      xlab = "log 2 fold change",
      main = "sample volcano plot",
      xlim = xWidth,
      ylim = yWidth)
overlay(resAC, col = 2)
overlay(sel, szMod = sizes[5], col = 2)

#where were those significant genes selected from resAC in resAB?
sel <- subset(resAB, rownames(resAB) %in% rownames(sel))
overlay(sel, szMod = sizes[4])

#perhaps we are interested in the relative expression of sepcific genes...
sel <- c("gene14", "gene211")

#under condition C (in resAC)
resizeGenes(resAC, sel, sz = sizes[5], col = 2, bg = 3, pch = 2)
            
#under condition B (in resAB)
resizeGenes(resAB, sel, sz = sizes[4])

``` 

-----------------------------------------------


Load the package with:
    `devtools::install_github("harrig12/pointszr")`


