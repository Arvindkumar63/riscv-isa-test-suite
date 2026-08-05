#!/bin/bash

TEST=$1
NAME=$(basename $TEST .S)

TEST_HOME=$PWD
OUT_DIR=$TEST_HOME/out/$NAME

mkdir -p $OUT_DIR
rm -rf $OUT_DIR/*

echo "Running Test: $TEST"

# Compile
riscv64-unknown-elf-gcc -march=rv64gc -mabi=lp64 -static \
    -T $TEST_HOME/link.ld \
    $TEST_HOME/tests/$NAME.S \
    -o $OUT_DIR/$NAME.elf

# Disassemble
riscv64-unknown-elf-objdump -D $OUT_DIR/$NAME.elf > $OUT_DIR/$NAME.disass

# Run spike
spike -l $OUT_DIR/$NAME.elf > $OUT_DIR/$NAME.log 2>&1

# Generate hex
elf2hex 8 4194304 $OUT_DIR/$NAME.elf 2147483648 > $OUT_DIR/code.mem

echo "Completed Test: $TEST"
