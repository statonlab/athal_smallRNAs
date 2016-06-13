#!/bin/bash
# calculate rpkms
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
