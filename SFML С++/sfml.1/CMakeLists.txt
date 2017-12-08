# Минимальная версия CMake: 3.8
cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
# Имя проекта: sfml-lab-1
project(sfml-lab-1)
# Подкаталог 00 содержит ещё один CMakeLists.txt
# Подкаталог 01 содержит ещё один CMakeLists.txt
# Подкаталог 02 содержит ещё один CMakeLists.txt
# Подкаталог 03 содержит ещё один CMakeLists.txt
# Подкаталог sfml1.1 содержит ещё один CMakeLists.txt
# Подкаталог sfml1.2 содержит ещё один CMakeLists.txt
# Подкаталог sfml1.3 содержит ещё один CMakeLists.txt

add_subdirectory(00)
add_subdirectory(01)
add_subdirectory(02)
add_subdirectory(03)
add_subdirectory(sfml1.1)
add_subdirectory(sfml1.2)
add_subdirectory(sfml1.3)
