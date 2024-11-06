cmake_minimum_required(VERSION 3.16)
set(DCMTK_DIR "C:\\dev\\vcpkg\\installed\\x64-windows\\share\\dcmtk")

project(MriUi VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)


find_package(Qt6 6.8 REQUIRED Core COMPONENTS Quick QuickControls2 Gui)
find_package(DCMTK CONFIG REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(MriUi
    src/main.cpp
)

qt_policy(SET QTP0004 NEW)
qt_add_qml_module(MriUi
    URI cn.cqu.mri
    VERSION 1.0
    QML_FILES 
        ui/Main.qml
        ui/history/HistoryPage.qml
        ui/study/StudyDashboard.qml
        ui/study/StudiesList.qml
        ui/tuning/TuningWindow.qml
        ui/tuning/CentralFrequency.qml
        ui/tuning/RfPower.qml
        ui/tuning/Shiming.qml
        ui/study/StudySetting.qml
        ui/study/StudiesListView.qml
        ui/study/StudyItem.qml
        ui/components/IconButton.qml
        ui/patient/PatientSetting.qml
        ui/patient/PatientWindow.qml
    RESOURCES
        resources.qrc
    SOURCES
    include/scanner.h
    src/scanner.cpp
    include/mriuiconfig.h
    src/mriuiconfig.cpp
    src/studyconfig.cpp
    include/patientmanager.h
    src/patientmanager.cpp
)

target_include_directories(MriUi
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_BINARY_DIR}
)

set_target_properties(MriUi PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(MriUi PRIVATE
    Qt::Core
    Qt::Quick
    DCMTK::DCMTK
)

# include(GNUInstallDirs)
# install(TARGETS MriUi
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
