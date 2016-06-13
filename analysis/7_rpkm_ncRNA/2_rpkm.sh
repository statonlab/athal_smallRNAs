#!/bin/bash
# run rpkm calculation scripts
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
