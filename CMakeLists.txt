cmake_minimum_required(VERSION 3.16)
project(SensorDashboard VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSensorDashboard
    main.cpp
    sensormodel.cpp
    sensormodel.h
)

qt_add_qml_module(appSensorDashboard
    URI SensorDashboard
    VERSION 1.0
    QML_FILES
        Main.qml
)

target_link_libraries(appSensorDashboard PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS appSensorDashboard
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
