function(get_project_list _project_list _srcs)
	set(new_list ${${_project_list}})
	file(GLOB srcs ${_srcs}/*)
	foreach(item ${srcs})
		if((IS_DIRECTORY ${item}) 
			OR (${item} MATCHES "\.cpp$") 
			OR (${item} MATCHES "\.c$")
			OR (${item} MATCHES "\.cc$"))
			set(m)
			string(REGEX MATCH "/([^/\.]+)[^/]*$" m ${item})
			set(m1 ${CMAKE_MATCH_1})
			list(APPEND new_list ${m1})
		endif()
	endforeach()
	set(${_project_list} ${new_list} PARENT_SCOPE)
endfunction()

function(get_source_list _source_list _path)
	set(new_list ${${_source_list}})
	set(postfix h hpp c cpp)
	if(EXISTS ${_path})
		foreach(item ${postfix})
			set(srcs)
			file(GLOB_RECURSE srcs ${_path}/*.${item})
			list(APPEND new_list ${srcs})
		endforeach()
	else()
		foreach(item ${postfix})
            set(file ${_path}.${item})
			if(EXISTS ${file})
				list(APPEND new_list ${file})
			endif()
		endforeach()
	endif()
	set(${_source_list} ${new_list} PARENT_SCOPE)
endfunction()
