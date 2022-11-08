#!/bin/bash
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=/home/pinhaozhang/workspace/build/cache/toolchain/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin:$PATH

home=`pwd`
outdir=$home/build-output
CONFIG_FILE="mx6ul_sinimx_defconfig"

function log_info()
{
    echo -e "\033[47;31m $*\033[0m"
}

function clean()
{
    make distclean
    rm -rf $outdir/*
}

function build()
{
    log_info "Uboot build start, config file: $CONFIG_FILE"
    make O=$outdir $CONFIG_FILE
    make O=$outdir -j8
    log_info "Uboot build done, output dir: $outdir"
}


if [ $1 ]; then
    if [ $1 = sd ]; then
        CONFIG_FILE="sinlinx_imx6ul_sd_defconfig"
    elif [ $1 = clean ]; then
        clean
        exit 0
    fi
fi

build