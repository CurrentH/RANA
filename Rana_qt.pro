#-------------------------------------------------
#
# Project created by QtCreator 2014-05-22T10:45:49
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += warn_on
TARGET = Rana_qt
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    output.cpp \
    control.cpp \
    graphics/agentItem.cpp \
    runner.cpp \
    postprocessing/eventprocessing.cpp \
    postprocessing/colorutility.cpp \
    eventdialog.cpp \
    postprocessing/graphics/zblock.cpp \
    postprocessing/postcontrol.cpp \
    postprocessing/eventrunner.cpp \
    postprocessing/graphics/zmap.cpp \
    helpdialog.cpp \
    api/gridmovement.cpp \
    api/maphandler.cpp \
    api/phys.cpp \
    api/scanning.cpp \
    api/shared.cpp \
    simulationcore/flowcontrol.cpp \
    simulationcore/interfacer.cpp \
    simulationcore/sector.cpp \
    simulationcore/supervisor.cpp \
    simulationcore/agents/agent.cpp \
    simulationcore/agents/agentinterface.cpp \
    simulationcore/agents/agentluainterface.cpp \
    simulationcore/eventqueue.cpp

HEADERS  += mainwindow.h \
    ID.h \
    utility.h \
    output.h \
    control.h \
    graphics/agentItem.h \
    runner.h \
    postprocessing/eventprocessing.h \
    postprocessing/colorutility.h \
    eventdialog.h \
    postprocessing/graphics/zblock.h \
    postprocessing/postcontrol.h \
    postprocessing/eventrunner.h \
    postprocessing/graphics/zmap.h \
    helpdialog.h \
    api/gridmovement.h \
    api/maphandler.h \
    api/phys.h \
    api/scanning.h \
    api/shared.h \
    simulationcore/flowcontrol.h \
    simulationcore/interfacer.h \
    simulationcore/sector.h \
    simulationcore/supervisor.h \
    simulationcore/agents/agent.h \
    simulationcore/agents/agentinterface.h \
    simulationcore/agents/agentluainterface.h \
    simulationcore/eventqueue.h

FORMS    += mainwindow.ui \
	eventdialog.ui \
    about.ui

#copy the lua modules to the correct directory, "wherever" Qmake puts it
unix: copydata.commands = $(COPY_DIR) $$PWD/modules $$OUT_PWD
unix: first.depends = $(first) copydata
unix: export(first.depends)
unix: export(copydata.commands)
unix: QMAKE_EXTRA_TARGETS += first copydata
#
QMAKE_CXXFLAGS += -Wextra -Wno-unused-variable -Wno-unused-parameter
QMAKE_CXXFLAGS_RELEASE += -o3
CONFIG += c++14
#QMAKE_CXXFLAGS += -std=c++1y -Wno-unused-variable -Wno-unused-parameter
#CONFIG += stdlib=libc++ lc++abi o3

unix: CONFIG += link_pkgconfig
#unix: PKGCONFIG += luajit
unix: PKGCONFIG += lua51
#unix: PKGCONFIG += lua5.3



macx: QMAKE_CXXFLAGS += -std=c++14 -mmacosx-version-min=10.7

macx: LIBS += -stdlib=libc++ -mmacosx-version-min=10.7
macx: LIBS += -L$$PWD/../lua-5.2_MacOS107_lib/ -llua52

macx: INCLUDEPATH += $$PWD/../lua-5.2_MacOS107_lib/include
macx: DEPENDPATH += $$PWD/../lua-5.2_MacOS107_lib/include

macx: PRE_TARGETDEPS += $$PWD/../lua-5.2_MacOS107_lib/liblua52.a

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../lua51_64bit/ -llua5.1
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../lua51_64bit/ -llua5.1

INCLUDEPATH += $$PWD/../lua51_64bit/include
DEPENDPATH += $$PWD/../lua51_64bit/include

RESOURCES += \
    images.qrc

DISTFILES += \
    lua_agents/01_pingpong.lua \
    lua_agents/02_data_collector.lua \
    lua_agents/02_master.lua \
    lua_agents/02_oscillator.lua \
    lua_agents/03_painter.lua \
    lua_agents/04_valueShare.lua \
    lua_agents/05_angular_event_module.lua \
    lua_agents/05_bat.lua \
    lua_agents/05_master.lua \
    lua_agents/05_pole.lua \
    lua_agents/06_mover.lua \
    lua_agents/07_repulser.lua \
    lua_agents/08_flasher.lua \
    lua_agents/08_master_flasher.lua \
    lua_agents/09_radial_scanner.lua \
    lua_agents/10_pingpong_targeted.lua \
    lua_agents/11_data_collector.lua \
    lua_agents/11_forage_module.lua \
    lua_agents/11_frog.lua \
    lua_agents/11_master.lua \
    lua_agents/11_oscillator_module.lua \
    lua_agents/12_female.lua \
    lua_agents/12_freerunning_osc.lua \
    lua_agents/12_greenfield_osc.lua \
    lua_agents/12_master.lua \
    lua_agents/13_precision_test.lua \
    modules/auxiliary.lua \
    modules/lib_env_lake.lua \
    modules/lib_table.lua \
    modules/ranalib_agent.lua \
    modules/ranalib_api.lua \
    modules/ranalib_collision.lua \
    modules/ranalib_core.lua \
    modules/ranalib_draw.lua \
    modules/ranalib_environment.lua \
    modules/ranalib_event.lua \
    modules/ranalib_map.lua \
    modules/ranalib_movement.lua \
    modules/ranalib_shared.lua \
    modules/ranalib_statistic.lua \
    modules/ranalib_utility.lua \
    modules/wrapper_auxiliary.lua
