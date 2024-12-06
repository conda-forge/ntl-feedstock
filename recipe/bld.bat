mkdir build
cd build

cmake -G Ninja ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_TESTING=On ^
      ..

ninja install -j%CPU_COUNT%
ctest
