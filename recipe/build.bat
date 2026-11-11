copy "%RECIPE_DIR%\windows\CMakeLists.txt" CMakeLists.txt
if errorlevel 1 exit 1
copy "%RECIPE_DIR%\windows\RunTest.cmake" RunTest.cmake
if errorlevel 1 exit 1

cmake -G Ninja %CMAKE_ARGS% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
      -B build .
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

ctest --test-dir build --output-on-failure --parallel %CPU_COUNT%
if errorlevel 1 exit 1

cmake --install build
if errorlevel 1 exit 1
