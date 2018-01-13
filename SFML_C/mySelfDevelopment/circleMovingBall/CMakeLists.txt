add_executable(circleMovingBall main.cpp)

set(SFML_STATIC_LIBRARIES TRUE)

find_package(Freetype REQUIRED)
find_package(JPEG REQUIRED)
find_package(SFML 2 COMPONENTS window graphics system REQUIRED)

target_include_directories(circleMovingBall PRIVATE ${SFML_INCLUDE_DIR})
target_compile_features(circleMovingBall PUBLIC cxx_std_17)
target_compile_definitions(circleMovingBall PRIVATE SFML_STATIC)

target_link_libraries(circleMovingBall ${SFML_LIBRARIES} ${SFML_DEPENDENCIES})