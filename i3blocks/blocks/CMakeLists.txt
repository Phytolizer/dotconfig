cmake_minimum_required(VERSION 3.12...3.23)

project(blocks LANGUAGES C)

set(BLOCKS curtime curcpu curmem curdisk curnet)

foreach(BLOCK ${BLOCKS})
	add_executable(${BLOCK} ${BLOCK}.c)
endforeach()

