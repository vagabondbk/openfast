# -----------------------------------------------------------
# -- build specific
# -----------------------------------------------------------

set(MODEL "openfast")
set(CTEST_SOURCE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SOURCE_DIRECTORY}/ctest-build")

# verify that an openfast executable was given
if( "${EXECUTABLE}" STREQUAL "")
  message(FATAL_ERROR "
    The -DEXECUTABLE flag is required to run CTest alone.
    For example: ctest -S ctest/steer.cmake -V -DEXECUTABLE=/path/to/openfast.exe
    CTest will exit.
  ")
endif( "${EXECUTABLE}" STREQUAL "")

# convert to cmake style path
file(TO_CMAKE_PATH ${EXECUTABLE} EXECUTABLE)

# -----------------------------------------------------------
## -- Set build name
## --------------------------

#find_program(UNAME NAMES uname)
#macro(getuname name flag)
#  exec_program("${UNAME}" ARGS "${flag}" OUTPUT_VARIABLE "${name}")
#endmacro(getuname)
#
#getuname(osname -s)
#getuname(cpu -m)
#
#set(CTEST_BUILD_NAME "${osname}-${cpu}")

# -----------------------------------------------------------
# -- Configure CTest
# -----------------------------------------------------------

## -- CTest Config
configure_file(${CTEST_SOURCE_DIRECTORY}/ctest/CTestConfig.cmake ${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake)

## -- CTest Testfile
configure_file(${CTEST_SOURCE_DIRECTORY}/ctest/CTestTestfile.cmake ${CTEST_BINARY_DIRECTORY}/CTestTestfile.cmake)

# -----------------------------------------------------------
# -- Settings
# -----------------------------------------------------------

## -- Process timeout in seconds
set(CTEST_TIMEOUT "7200")

## -- Set output to english
set($ENV{LC_MESSAGES} "en_EN" )

# -----------------------------------------------------------
# -- Run CTest
# -----------------------------------------------------------

## -- Start
message(" -- Start testing ${MODEL} - ${CTEST_BUILD_NAME} --")
ctest_start(${MODEL} TRACK ${MODEL})

## -- TEST
message(" -- Test ${MODEL} - ${CTEST_BUILD_NAME} --")
ctest_test(     BUILD  "${CTEST_BINARY_DIRECTORY}" RETURN_VALUE res)

message(" -- Finished ${MODEL}  - ${CTEST_BUILD_NAME} --")
