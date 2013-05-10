# 默认配置选项
#####################################################################
option(BUILD_SHARED_LIBS "Build shared libraries (DLLs)." OFF)
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Default Compile Version.")
endif()

# 编译器选项 (仅做了GCC、VC和Clang兼容)
if( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	add_definitions(-Wall -Werror -Wno-unused-local-typedefs -rdynamic -fPIC)
elseif( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	add_definitions(-Wall -Werror -fPIC)
endif()

# 设置公共编译选项 
set(ALL_FLAGS_IN_ONE_COMMON "") 
if ( NOT ${MSVC} )
	set(ALL_FLAGS_IN_ONE_DEBUG "-g -ggdb -O0 ${ALL_FLAGS_IN_ONE_COMMON}")
	set(ALL_FLAGS_IN_ONE_RELEASE "-O2 ${ALL_FLAGS_IN_ONE_COMMON} -DNDEBUG")
	set(ALL_FLAGS_IN_ONE_RELWITHDEBINFO "-O2 -g -ggdb ${ALL_FLAGS_IN_ONE_COMMON}")
	set(ALL_FLAGS_IN_ONE_MINSIZEREL "-Os ${ALL_FLAGS_IN_ONE_COMMON} -DNDEBUG")
else()
	set(ALL_FLAGS_IN_ONE_DEBUG "/Od /MDd ${ALL_FLAGS_IN_ONE_COMMON}")
	set(ALL_FLAGS_IN_ONE_RELEASE "/O2 /MD ${ALL_FLAGS_IN_ONE_COMMON} /D NDEBUG")
	set(ALL_FLAGS_IN_ONE_RELWITHDEBINFO "/O2 /MDd ${ALL_FLAGS_IN_ONE_COMMON}")
	set(ALL_FLAGS_IN_ONE_MINSIZEREL "/Ox /MD ${ALL_FLAGS_IN_ONE_COMMON} /D NDEBUG")
endif()

# 设置实际的编译选项 
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} ${ALL_FLAGS_IN_ONE_DEBUG}")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} ${ALL_FLAGS_IN_ONE_RELEASE}")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "$ENV{CXXFLAGS} ${ALL_FLAGS_IN_ONE_RELWITHDEBINFO}")
set(CMAKE_CXX_FLAGS_MINSIZEREL "$ENV{CXXFLAGS} ${ALL_FLAGS_IN_ONE_MINSIZEREL}")

set(CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} ${ALL_FLAGS_IN_ONE_DEBUG}")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} ${ALL_FLAGS_IN_ONE_RELEASE}")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "$ENV{CFLAGS} ${ALL_FLAGS_IN_ONE_RELWITHDEBINFO}")
set(CMAKE_C_FLAGS_MINSIZEREL "$ENV{CFLAGS} ${ALL_FLAGS_IN_ONE_MINSIZEREL}")

# 库文件的附加参数 -fPIC, 多线程附加参数 -pthread -D_POSIX_MT_
