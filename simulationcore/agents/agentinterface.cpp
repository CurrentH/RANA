
#include <iostream>
#include <cstring>
#include <string>
#include <random>
#include <chrono>
#include <iostream>
#include <exception>
#include <climits>
#include <cmath>
#include <mutex>

#include "output.h"

#include "ID.h"
#include "agentinterface.h"
#include "../interfacer.h"
#include "../../api/phys.h"
#include "../../api/gridmovement.h"
#include "../../api/maphandler.h"
#include "../../api/shared.h"
#include "../../api/scanning.h"

AgentInterface::AgentInterface(int ID, double posX, double posY, double posZ, Sector *sector, std::string filename)
:Agent(ID, posX, posY, posZ, sector), destinationX(posX), destinationY(posY), speed(1),
 	 	 moving(false), gridmove(false), filename(filename), nofile(false), removed(false)
{

	Output::Inst()->addGraphicAgent(ID, -1,-1);

	moveFactor = Phys::getMacroFactor() * Phys::getTimeRes();
}

AgentInterface::~AgentInterface()
{
	if(initiated)
	{
		//Delete everything
	}
}

void AgentInterface::InitializeAgent()
{
	if(removed) return;
}

/********************************************************
 * Simulation flow functions:
 ********************************************************/

/**
 * Handler for external events.
 * Will send all relevant event data to the LUA script which will then
 * process the event and either return a null string, or arguments
 * to initiate an internal event.
 * @param event pointer to the external event.
 * @return internal event.
 */
std::unique_ptr<EventQueue::iEvent> AgentInterface::processEvent(const EventQueue::eEvent *event)
{
	return NULL;
}

/**
 * Query if the auton will initiate an event.
 * This will call up the LUA autons initEvent function which will
 * either return a 'null' string or data to build an
 * external event.
 * @return EventQueue::eEvent pointer to an external event or
 * a null pointer in which case nothing happens.
 */
std::unique_ptr<EventQueue::eEvent> AgentInterface::takeStep()
{
	return NULL;
}

/**
 * Handler for internal events.
 * Will send all relevant event data to the LUA script which will then
 * process the event and either return a null string, or arguments
 * to initiate an external event.
 * @param event pointer to the internal event.
 * @return external event.
 */
std::unique_ptr<EventQueue::eEvent> AgentInterface::handleEvent(std::unique_ptr<EventQueue::iEvent> eventPtr)
{
	return NULL;
}

/********************************************************
 * RANA agent API functions:
 ********************************************************/

//	Interface
void AgentInterface::debug( std::string string )
{
	string.resize(4096);
	Output::Inst()->kdebug( string.c_str() );
}

void AgentInterface::print( std::string string )
{
	string.resize(4096);
	Output::Inst()->kdebug( string.c_str() );
}

int AgentInterface::generateEventID()
{
	unsigned long long id = ID::generateEventID();
	return id;
}

//	Physics
















































