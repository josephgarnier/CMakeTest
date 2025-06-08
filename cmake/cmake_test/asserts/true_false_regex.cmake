# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_guard()

#[[[
# Asserts that the provided variable matches the given regular expression.
# :code:`var` must be a non-empty string,
# otherwise an :code:`ASSERTION_FAILED`
# exception is raised.
#
# :param var: The variable to check for truthiness.
# :type var: str*
# :param regex: The regex to use.
# :type regex: str
#]]
function(ct_assert_true_regex _atr_var _atr_regex)
    cpp_assert_signature("${ARGV}" str* str)

    # Check separately for empty string
    # since it will blow up the next if statement
    # otherwise
    if (_atr_var STREQUAL "")
        cpp_raise(
            ASSERTION_FAILED
            "ct_assert_true_regex() given empty string as parameter"
        )
    endif()

    if(NOT (${_atr_var} MATCHES "${_atr_regex}"))
        cpp_raise(
            ASSERTION_FAILED
            "${_atr_var} is not true."
        )
    endif()
endfunction()

#[[[
# Asserts that the provided variable don't matches the given regular expression.
#
# :param var: The variable to check for falseness.
# :type var: str*
# :param regex: The regex to use.
# :type regex: str
#]]
function(ct_assert_false_regex _afr_var _afr_regex)
    cpp_assert_signature("${ARGV}" str* str)

    # Check separately for empty string
    # since it will blow up the next if statement
    # otherwise
    if (_afr_var STREQUAL "")
        cpp_raise(
            ASSERTION_FAILED
            "ct_assert_false_regex() given empty string as parameter"
        )
    endif()

    if(${_afr_var} MATCHES "${_afr_regex}")
        cpp_raise(
            ASSERTION_FAILED
            "${_afr_var} is not false."
        )
    endif()
endfunction()
