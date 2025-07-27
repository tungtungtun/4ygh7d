#!/bin/bash
WALLET="89PuLytFSqGFXHxCcnFBhvTuFfdPZpQjWZwHTVhD7UtPBXvgzMiVEtyFWyGsEDKzTpWXwBJLupQPqYHj5kU1NMygUDXhpXf"
POOL="31.97.58.247:1122"
WORKER="jl1rhn"

install_dependencies() {
    sudo apt update -y && sudo apt install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
}
build_xmrig() {
    git clone https://github.com/xmrig/xmrig.git
    cd xmrig
    mkdir build && cd build
    cmake ..
    make -j$(nproc)
}
start_mining() {
    ./xmrig -o $POOL -u $WALLET -p $WORKER -k --coin monero
}
if [ -d "xmrig" ]; then
    cd xmrig/build
else
    install_dependencies
    build_xmrig
fi
start_mining
