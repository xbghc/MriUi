cmake_minimum_required(VERSION 3.16)

project(MriUi VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED Core COMPONENTS Quick QuickControls2 Gui)

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
        ui/HistoryPage.qml
        ui/ExamDashboard.qml
        ui/SequenceList.qml
        ui/TuningWindow.qml
        ui/CentralFrequency.qml
        ui/RfPower.qml
        ui/Shiming.qml
        ui/SequenceSetting.qml
        ui/views/SequenceListView.qml
        ui/components/IconButton.qml
    RESOURCES
        resources.qrc
    SOURCES
    include/scanner.h
    src/scanner.cpp
    include/examconfig.h
    src/examconfig.cpp
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
)

# include(GNUInstallDirs)
# install(TARGETS MriUi
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
