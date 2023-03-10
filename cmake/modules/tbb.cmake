#
# Intel tbb
#
option(USE_BUNDLED_TBB "Enable building of the bundled tbb" ${USE_BUNDLED_DEPS})

if(TBB_INCLUDE_DIR)
	# we already have tbb
elseif(NOT USE_BUNDLED_TBB)
	find_path(TBB_INCLUDE_DIR tbb.h PATH_SUFFIXES tbb)
	find_library(TBB_LIB NAMES tbb)
	if(TBB_INCLUDE_DIR AND TBB_LIB)
		message(STATUS "Found tbb: include: ${TBB_INCLUDE_DIR}, lib: ${TBB_LIB}")
	else()
		message(FATAL_ERROR "Couldn't find system tbb")
	endif()
else()
	set(TBB_SRC "${PROJECT_BINARY_DIR}/tbb-prefix/src/tbb")
	set(TBB_INCLUDE_DIR "${TBB_SRC}/include/")
	set(TBB_LIB "${TBB_SRC}/build/lib_release/libtbb.a")
	if(NOT TARGET tbb)
		message(STATUS "Using bundled tbb in '${TBB_SRC}'")

		ExternalProject_Add(tbb
			PREFIX "${PROJECT_BINARY_DIR}/tbb-prefix"
			URL "https://kdlibrary.oss-cn-beijing.aliyuncs.com/2020_U3.tar.gz"
			URL_HASH "SHA256=2103cc6238c935664f87680618f6684d57501d4a2fa8ea8f6c97ad6ff7dc722a"
			PATCH_COMMAND curl -O https://gist.githubusercontent.com/Kindling-project/d95c8e972e65952f42fbcce4424da005/raw/c68753c1da52b3e775d414b04ee4ccfcf98ff558/tbb.patch && patch -p0 -i tbb.patch
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ${CMD_MAKE} tbb_build_dir=${TBB_SRC}/build tbb_build_prefix=lib extra_inc=big_iron.inc
			BUILD_IN_SOURCE 1
			BUILD_BYPRODUCTS ${TBB_LIB}
			INSTALL_COMMAND "")
	endif()
endif()

include_directories("${TBB_INCLUDE_DIR}")
