//--begin_license--
//
//Copyright 	2013-2014 	Søren Vissing Jørgensen.
//			2014-	Søren Vissing Jørgensen, Center for Bio-Robotics, SDU, MMMI.
//
//This file is part of RANA.
//
//RANA is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//RANA is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with RANA.  If not, see <http://www.gnu.org/licenses/>.
//
//--end_license--

#include "src/control.h"
#include "src/mainwindow.h"
#include "src/output.h"

Control::Control(MainWindow* mainwindow)
    : agentDomain(NULL), mainwindow(mainwindow),
      running(false), generated(false), stopped(true),generating(false)
{
	runner = new Runner();
	runner->moveToThread(&runThread);

	connect(this, &Control::startDoWork, runner, &Runner::doWork);
	connect(&runThread, &QThread::finished, runner, &QObject::deleteLater);
	connect(runner, &Runner::simulationDone, this, &Control::on_simDone);  
    //runThread.setStackSize(1024*1024*512);
    runThread.start();
}

Control::~Control()
{
    Output::Inst()->kprintf("Control - ~Control");
	runThread.quit();
    runThread.wait();
}

unsigned long long Control::getRunTime()
{
    return runTime;
}

void Control::runSimulation(unsigned long long runTime)
{
    Output::Inst()->kprintf("Control - runSimulation1");
    this->runTime = runTime;
    runsimulation();
}

void Control::runsimulation()
{
    Output::Inst()->kprintf("Control - runsimulation2");
    running = true;
    //runThread.setStackSize(1024*1024*1024);
    Output::SimRunning.store(true);
    mainwindow->changeRunButton("Stop");
    emit startDoWork(agentDomain, this->runTime);
    //runner->setParameters(agentDomain, runTime);
    //runThread->start();
}

void Control::stopSimulation()
{
    Output::Inst()->kprintf("Control - stopSimulation");
    agentDomain->stopSimulation();
}

void Control::generateEnvironment(int width, int heigth, int threads, double timeRes,
                                    double macroRes, int agentAmount, std::string agentPath)
{
    Output::Inst()->kprintf("Control - generateEnvironment - 2");
    if(!running || !generating)
    {
        Output::Inst()->kprintf("Control - generateEnvironment - 3");
        generating = true;

        if(populateFuture.isRunning())
        {
            Output::Inst()->kprintf("A previous system was being populated, it will be cancelled");
            populateFuture.cancel();
            populateFuture.waitForFinished();
        }

        Output::KillSimulation.store(true);
        Output::Inst()->kprintf("Control - generateEnvironment - 4");

        if(agentDomain != NULL)
        {
            agentDomain->~FlowControl();
        }

        agentDomain = new FlowControl(this);

        Output::Inst()->kprintf("Control - generateEnvironment - 5");

        agentDomain->generateEnvironment(width,heigth,threads, agentAmount,timeRes,macroRes,agentPath);

        generating = false;
    } else{
        Output::Inst()->kprintf("Simulation is being generating or it is running");
    }
    //retrieve and update the positions:
    Output::Inst()->kprintf("Control - generateEnvironment - 6");
}

void Control::generateEnvironment(QImage *map, int threads, double timeRes,
                                  double macroRes, int agentAmount, std::string agentPath)
{
    Output::Inst()->kprintf("Control - generateEnvironment - 1");
    generateEnvironment(map->width(),map->height(),threads,timeRes,macroRes,agentAmount,agentPath);
    Output::Inst()->kprintf("Control - generateEnvironment - 7");
}

void Control::threadTest(std::string something)
{
    int i = 0;
}

void Control::on_simDone()
{
    Output::Inst()->kprintf("Control - on_simDone");
    running = false;
    mainwindow->changeRunButton("Run");
    mainwindow->runButtonHide();
	Output::SimRunning.store(false);
    //Output::Inst()->kprintf("Simulation Done");
}

void Control::refreshPopPos(std::list<agentInfo> infolist)
{
    mainwindow->updateMap(infolist);
}

bool Control::isRunning()
{
    return running;
}

bool Control::isGenerated()
{
	if(agentDomain!=NULL)
	{
		return true;
	}

	return false;
}

void Control::saveEvents(QString path)
{
	agentDomain->saveExternalEvents(path.toStdString());
}

void Control::toggleLiveView(bool enable)
{
    if(agentDomain != NULL)
        agentDomain->toggleLiveView(enable);
}
