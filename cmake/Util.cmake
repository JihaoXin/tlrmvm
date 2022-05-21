# wrap cpu binary
function(WrapBinary TARGET ParentFolder)
    add_executable(${TARGET} ${ParentFolder}/${TARGET}.cpp)
    target_link_libraries(${TARGET} PUBLIC tlrmvmcpulib)
    target_include_directories(${TARGET} PUBLIC ${PROJECT_SOURCE_DIR}/src)
endfunction()

# wrap cuda binary
function(WrapCUDABinary TARGET ParentFolder)
    set_source_files_properties(${TARGET} PROPERTIES LANGUAGE CUDA)
    add_executable(${TARGET} ${ParentFolder}/${TARGET}.cpp)
    target_link_libraries(${TARGET} PUBLIC tlrmvmcudalib)
    target_include_directories(${TARGET} PUBLIC ${PROJECT_SOURCE_DIR}/src)
    if(USE_NVTX) # profiling binary
        add_executable(${TARGET}_nvtx ${ParentFolder}/${TARGET}.cu)
        target_link_libraries(${TARGET}_nvtx PUBLIC tlrmvmcudalib)
        target_compile_definitions(${TARGET}_nvtx PUBLIC USE_NVTX)
        target_link_libraries(${TARGET}_nvtx PUBLIC nvToolsExt)
    endif()
endfunction()

# wrap hip binary
function(WrapHIPBinary TARGET ParentFolder)
    add_executable(${TARGET} ${ParentFolder}/${TARGET}.cpp)
    target_link_libraries(${TARGET} PUBLIC tlrmvmhiplib)
    target_include_directories(${TARGET} PUBLIC ${PROJECT_SOURCE_DIR}/src)
endfunction()


function(AddCompileDefinitions TARGET)
    if(USE_OPENBLAS)
        target_compile_definitions(${TARGET} PUBLIC USE_OPENBLAS)
    endif()
    if(USE_MKL)
        target_compile_definitions(${TARGET} PUBLIC USE_MKL)
    endif()
    if(USE_BLIS)
        target_compile_definitions(${TARGET} PUBLIC USE_BLIS)
    endif()
    if(USE_COMPILER_BLAS)
        target_compile_definitions(${TARGET} PUBLIC USE_COMPILER_BLAS)
    endif()
    if(USE_MPI)
        target_compile_definitions(${TARGET} PUBLIC USE_MPI)
    endif()
endfunction()


function(OutputCUDAinfo)
    message ( STATUS "CUDAToolkit_FOUND = ${CUDAToolkit_FOUND}" )
    message ( STATUS "CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES = ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES}" )
    message ( STATUS "CUDAToolkit_VERSION = ${CUDAToolkit_VERSION}" )
    message ( STATUS "CUDAToolkit_VERSION_MAJOR = ${CUDAToolkit_VERSION_MAJOR}" )
    message ( STATUS "CUDAToolkit_VERSION_MINOR = ${CUDAToolkit_VERSION_MINOR}" )
    message ( STATUS "CUDAToolkit_VERSION_PATCH = ${CUDAToolkit_VERSION_PATCH}" )
    message ( STATUS "CUDAToolkit_BIN_DIR = ${CUDAToolkit_BIN_DIR}" )
    message ( STATUS "CUDAToolkit_INCLUDE_DIRS = ${CUDAToolkit_INCLUDE_DIRS}" )
    message ( STATUS "CUDAToolkit_LIBRARY_DIR = ${CUDAToolkit_LIBRARY_DIR}" )
    message ( STATUS "CUDAToolkit_LIBRARY_ROOT = ${CUDAToolkit_LIBRARY_ROOT}" )
    message ( STATUS "CUDAToolkit_TARGET_DIR = ${CUDAToolkit_TARGET_DIR}" )
    message ( STATUS "CUDAToolkit_NVCC_EXECUTABLE = ${CUDAToolkit_NVCC_EXECUTABLE}" )
    message ( STATUS "CMAKE_CUDA_FLAGS = ${CMAKE_CUDA_FLAGS}" )
    message ( STATUS "CUDA_STANDARD = ${CUDA_STANDARD}" )
    message ( STATUS "CMAKE_CUDA_EXTENSIONS = ${CMAKE_CUDA_EXTENSIONS}" )
endfunction()

function(ShowCompilerinfo)
    message("CMAKE_Fortran_COMPILER_ID = ${CMAKE_Fortran_COMPILER_ID}")
    message("CMAKE_C_COMPILER_ID = ${CMAKE_C_COMPILER_ID}")
    message("CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}")
endfunction()


