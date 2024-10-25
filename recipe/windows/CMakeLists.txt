# Unfortunately NTL does not like GMP/MPIR on Windows
# so we had to disable some parts, see https://github.com/conda-forge/ntl-feedstock/pull/16#issuecomment-456953821

cmake_minimum_required(VERSION 3.6)
project(ntl)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# find_library(GMP_LIBRARY NAMES gmp)
# find_path(GMP_INCLUDE_DIR NAMES gmp.h)

find_library(GF2X_LIBRARY NAMES gf2x)
find_path(GF2X_INCLUDE_DIR NAMES gf2x.h)

file(GLOB SOURCES src/*.cpp)

# add_executable(gen_gmp_aux misc/gen_gmp_aux.cpp)
# target_include_directories(gen_gmp_aux PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include ${GMP_INCLUDE_DIR})
# target_link_libraries(gen_gmp_aux ${GMP_LIBRARY})
# target_compile_definitions(gen_gmp_aux PRIVATE MSC_USE_DLL)
# 
# file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/NTL)
# 
# add_custom_target(run_gmp_aux
#   COMMAND gen_gmp_aux > ${CMAKE_CURRENT_BINARY_DIR}/include/NTL/gmp_aux.h
#   COMMENT "Run gen_gmp_aux"
#   DEPENDS gen_gmp_aux
# )

add_library(${PROJECT_NAME} SHARED ${SOURCES})
# target_include_directories(ntl PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_CURRENT_BINARY_DIR}/include ${GMP_INCLUDE_DIR} ${GF2X_INCLUDE_DIR})
target_include_directories(ntl PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_CURRENT_BINARY_DIR}/include ${GF2X_INCLUDE_DIR})
# target_link_libraries(ntl ${GMP_LIBRARY} ${GF2X_LIBRARY})
target_link_libraries(ntl ${GF2X_LIBRARY})
target_compile_definitions(ntl PRIVATE MSC_USE_DLL)
# add_dependencies(${PROJECT_NAME} run_gmp_aux)

install(TARGETS ${PROJECT_NAME}
                RUNTIME DESTINATION bin
                ARCHIVE DESTINATION lib
                LIBRARY DESTINATION lib)
file(GLOB HEADERS include/NTL/*.h)
install(FILES ${HEADERS} DESTINATION include/NTL)
