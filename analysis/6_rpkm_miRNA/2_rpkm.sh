#!/bin/bash
# run rpkm scripts
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
