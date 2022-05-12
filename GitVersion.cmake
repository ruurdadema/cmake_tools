# Get version using git describe
find_package(Git)

execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --always --tags --dirty --match "v*"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        OUTPUT_VARIABLE GIT_DESCRIBE_VERSION
        RESULT_VARIABLE GIT_DESCRIBE_ERROR_CODE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Fallback if no tag was found
if (GIT_DESCRIBE_VERSION STREQUAL "")
    set(GIT_DESCRIBE_VERSION "v0.0.1-no-version")
endif ()

# Extract version components from git tags starting with 'v'
string(REGEX MATCHALL "^v([0-9]+)\\.([0-9]+)\\.([0-9]+)(.*)$" VERSION_MATCH ${GIT_DESCRIBE_VERSION})

set(GIT_VERSION_MAJOR ${CMAKE_MATCH_1})
set(GIT_VERSION_MINOR ${CMAKE_MATCH_2})
set(GIT_VERSION_PATCH ${CMAKE_MATCH_3})

message(STATUS "Git describe: ${GIT_DESCRIBE_VERSION}")
message(STATUS "Version major: ${GIT_VERSION_MAJOR}")
message(STATUS "Version minor: ${GIT_VERSION_MINOR}")
message(STATUS "Version patch: ${GIT_VERSION_PATCH}")
