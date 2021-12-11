# R_Meets_Uniprot
A short script for searching in Uniprot using RESTful APIs of the European Bioinformatics Institute (EBI).

Make sure to have the [**Biostrings**](https://bioconductor.org/packages/release/bioc/html/Biostrings.html) package installed.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Biostrings")
```

For the future, I might try to improve the functionality of the searchEBI function, by accepting extra options, filters and other criteria to generate the final URLs. 
Filter by Reviewed/Unreviewed, Entry name, length, orgranism, etc must be added in the future.
I might code a similar program to retrieve pdb files from Protein Data Bank (PDB).
