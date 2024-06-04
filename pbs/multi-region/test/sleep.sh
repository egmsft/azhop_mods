#!/bin/bash
#PBS -N sleep
#PBS -l select=1:ncpus=1:slot_type=htc
#PBS -k oed
#PBS -j oe
#PBS -l walltime=00:30:00
#PBS -l place=shared:scatter

#place=shared:scatter
sleep 1200