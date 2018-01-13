add_executable(pumpingBall main.cpp)

set(SFML_STATIC_LIBRARIES TRUE)

find_package(Freetype REQUIRED)
find_package(JPEG REQUIRED)
find_package(SFML 2 COMPONENTS window graphics system REQUIRED)

target_include_directories(pumpingBall PRIVATE ${SFML_INCLUDE_DIR})
target_compile_features(pumpingBall PUBLIC cxx_std_17)
target_compile_definitions(pumpingBall PRIVATE SFML_STATIC)

target_link_libraries(pumpingBall ${SFML_LIBRARIES} ${SFML_DEPENDENCIES})