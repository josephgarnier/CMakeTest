include(cmake_test/cmake_test)

ct_add_test(NAME assert_library_exists)
function(${assert_library_exists})
    include(cmake_test/asserts/library_exists)
    ct_add_section(NAME test_target_exists)
    function(${test_target_exists})
        ct_add_section(NAME test_target_is_library)
        function(${test_target_is_library})
            file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/a.c" "")
            add_library(my_lib "${CMAKE_CURRENT_BINARY_DIR}/a.c")
            ct_assert_library_target_exists(my_lib)
        endfunction()

        ct_add_section(NAME test_target_not_library EXPECTFAIL)
        function(${test_target_not_library})
            add_custom_target(non_lib_target ALL)
            ct_assert_library_target_exists(non_lib_target)
        endfunction()
    endfunction()

    ct_add_section(NAME test_library_does_not_exist EXPECTFAIL)
    function(${test_library_does_not_exist})
        ct_assert_library_target_exists(non_existant_lib)
    endfunction()
endfunction()

ct_add_test(NAME assert_library_does_not_exist)
function(${assert_library_does_not_exist})
    include(cmake_test/asserts/library_exists)

    ct_add_section(NAME test_target_exists)
    function(${test_target_exists})
        ct_add_section(NAME test_target_is_library EXPECTFAIL)
        function(${test_target_is_library})
            file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/a.c" "")
            add_library(my_lib "${CMAKE_CURRENT_BINARY_DIR}/a.c")
            ct_assert_library_does_not_exist(my_lib)
        endfunction()

        ct_add_section(NAME target_is_not_library)
        function(${target_is_not_library})
            add_custom_target(non_lib_target ALL)
            ct_assert_library_does_not_exist(non_lib_target)
        endfunction()
    endfunction()

    ct_add_section(NAME test_library_does_not_exist)
    function(${test_library_does_not_exist})
        ct_assert_library_does_not_exist(non_existant_lib)
    endfunction()
endfunction()
