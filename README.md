# pointszr
**Point resizing for volcano plots**

Install the package with `devtools::install_github("harrig12/pointszr", build_vignettes = TRUE)`
    
## Try the app!

Deployed on [shinyapps.io](https://harrig12.shinyapps.io/pointszrApp/)

## Description

This package allows easy creation of volcano plots, and provides functions to highlight specified genes, and genes that meet criteria of interest by changing their size representations. This simplifies comparing several test conditions against a reference condition and each other on a single scale.

## Dependancies 
    BiocGenerics,
    methods,
    S4Vectors,
    DESeq2,
    graphics

## Usage

pointszr 0.2.0 is compatible with DESeqDataSet objects. Future renditions of this project may allow for a wider variety of object classes.

Please see the package vignette for an example workflow. Load the vignette with `vignette("pointszr-vignette")`

-----------------------------------------------

