#!/bin/bash
# calculate rpkms and create matrix. Also create matrix of raw counts
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
Rscript create_raw_matrix.R
