#!/usr/bin/env bash

cd src
chmod +x configure

export CFLAGS="-O2 -g $CFLAGS"
export CXXFLAGS="-O2 -g $CXXFLAGS"
export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib:${DYLD_FALLBACK_LIBRARY_PATH}"

if [ "$(uname)" == "Darwin" ]; then
    CXXFLAGS="$CXXFLAGS -fno-common"
fi

./configure DEF_PREFIX="$PREFIX" SHARED=on \
        CXXFLAGS="$CXXFLAGS" \
        LDFLAGS="${LDFLAGS}" \
        NTL_GMP_LIP=on \
        NTL_GF2X_LIB=on \
        NATIVE=off \
        NTL_THREADS=off \
        CXX=$CXX

make -j${CPU_COUNT}
make check
make install

