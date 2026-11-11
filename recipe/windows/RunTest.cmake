# Runs TEST (through EMULATOR if set) with stdin from INPUT. If EXPECTED is
# set, compares stdout to it ignoring changes in the amount of whitespace like
# "diff -b" in src/TestScript.

execute_process(COMMAND ${EMULATOR} ${TEST}
  INPUT_FILE ${INPUT}
  OUTPUT_VARIABLE output
  RESULT_VARIABLE result
)
message("${output}")
if(NOT result EQUAL 0)
  message(FATAL_ERROR "${TEST} failed: ${result}")
endif()

if(DEFINED EXPECTED)
  file(READ ${EXPECTED} expected)
  foreach(var output expected)
    string(REPLACE "\r" "" ${var} "${${var}}")
    string(REGEX REPLACE "[ \t]+" " " ${var} "${${var}}")
    string(REGEX REPLACE " \n" "\n" ${var} "${${var}}")
  endforeach()
  if(NOT output STREQUAL expected)
    message(FATAL_ERROR "Output of ${TEST} differs from ${EXPECTED}")
  endif()
endif()
