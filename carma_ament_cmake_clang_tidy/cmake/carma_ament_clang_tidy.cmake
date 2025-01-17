# Copyright 2019 Open Source Robotics Foundation, Inc.
# Copyright 2024 Leidos
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Changes from original Open Source Robotics Foundation, Inc. version:
#   - replaced ament_clang_tidy with carma_ament_clang_tidy to avoid name collisions
#   - replaced ament_cmake_clang_tidy with carma_ament_cmake_clang_tidy to avoid name collisions

#
# Add a test to check the code for compliance with clang_tidy.
#
# The default configuration file for clang-tidy is located at
# configuration/.clang-tidy within the carma_ament_clang_tidy directory
# The default configuration file can be either overridden by the
# argument 'CONFIG_FILE' or by a global variable named
# 'carma_ament_cmake_clang_tidy_CONFIG_FILE'
# The 'CONFIG_FILE' argument takes priority over
# 'carma_ament_cmake_clang_tidy_CONFIG_FILE' if both are defined
#
# :param TESTNAME: the name of the test, default: "clang_tidy"
# :type TESTNAME: string
# :param CONFIG_FILE: the path of the configuration file
#                     for clang-tidy to consider
# :type CONFIG_FILE: string
# :param ARGN: the files or directories to check
# :type ARGN: list of strings
#
# @public
#
function(carma_ament_clang_tidy)
  cmake_parse_arguments(ARG "" "TESTNAME;CONFIG_FILE" "" ${ARGN})
  if(NOT ARG_TESTNAME)
    set(ARG_TESTNAME "clang_tidy")
  endif()

  find_program(carma_ament_clang_tidy_BIN NAMES "carma_ament_clang_tidy")
  if(NOT carma_ament_clang_tidy_BIN)
    message(FATAL_ERROR "carma_ament_clang_tidy() variable 'carma_ament_clang_tidy_BIN' must not be empty")
  endif()

  set(result_file "${AMENT_TEST_RESULTS_DIR}/${PROJECT_NAME}/${ARG_TESTNAME}.xunit.xml")
  set(cmd "${carma_ament_clang_tidy_BIN}" "--xunit-file" "${result_file}")
  list(APPEND cmd ${ARG_UNPARSED_ARGUMENTS})

  if(ARG_CONFIG_FILE)
    list(APPEND cmd "--config" "${ARG_CONFIG_FILE}")
  elseif(DEFINED carma_ament_cmake_clang_tidy_CONFIG_FILE)
    list(APPEND cmd "--config" "${carma_ament_cmake_clang_tidy_CONFIG_FILE}")
  endif()

  file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/carma_ament_clang_tidy")
  ament_add_test(
    "${ARG_TESTNAME}"
    COMMAND ${cmd}
    OUTPUT_FILE "${CMAKE_BINARY_DIR}/carma_ament_clang_tidy/${ARG_TESTNAME}.txt"
    RESULT_FILE "${result_file}"
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  )
  set_tests_properties(
    "${ARG_TESTNAME}"
    PROPERTIES
    LABELS "clang_tidy;linter"
  )
endfunction()
