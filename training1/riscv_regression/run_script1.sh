#!/bin/bash

TEST=$1
ELF=${TEST%.S}.elf

# Compile
riscv64-unknown-elf-gcc -static -o $ELF $TEST

# Run spike
spike -d $ELF > ${ELF}.log 2>&1

echo "Spike execution completed for $TEST"
