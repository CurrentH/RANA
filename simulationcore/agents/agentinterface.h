#ifndef AGENTINTERFACE_H
#define AGENTINTERFACE_H

#include <random>
#include <vector>
#include <memory>

#include "../sector.h"
#include "agent.h"

class Sector;
class AgentInterface : public Agent
{
public:
	AgentInterface(int ID, double posX, double posY, double posZ, Sector *sector, std::string filename);
	~AgentInterface();

    /*******************************************
    * Functions
    ********************************************/

	//	Interface
	void debug( std::string string );
	void print( std::string string );
	int generateEventID();

	//	Physics
	void speedOfSound();
	void distance();
	void currentTime();
	void currentTimeS();
	void getMacroFactor();
	void getTimeResolution();
	void getMersenneFloat();
	void getMersenneInteger();

	//	Map and movement
	void getEnvironmentSize();
	void modifyMap();
	void checkMap();
	void checkMapAndChange();
	void radialMapScan();
	void radialMapColorScan();

	void addPosition();
	void checkPosition();
	void updatePosition();
	void checkCollision();
	void checkCollisionRadial();
	void getMaskRadial();
	void gridMove();
	void getGridScale();
	void initializeGrid();
	void radialCollisionScan();
	void updatePositionIfFree();

	//	Shared values
	void getSharedNumber();
	void addSharedNumber();
	void getSharedString();
	void addSharedString();

	//	Simulation core
	void stopSimulation();
	void getAgentPath();
	void addAgent();
	void removeAgent();

	//	Agents
	void emitEvent();
	void addGroup();
	void removeGroup();
	void setMacroFactorMultipler();
	void changeAgentColor();

	//	Panic
	void panic();

	void processFunction(EventQueue::dataEvent *devent, double mapRes, double x, double y, double &zvalue, double &duration);
	void InitializeAgent();

private:
	std::unique_ptr<EventQueue::iEvent> processEvent(const EventQueue::eEvent *event);
	std::unique_ptr<EventQueue::eEvent> handleEvent(std::unique_ptr<EventQueue::iEvent> eventPtr);
	std::unique_ptr<EventQueue::eEvent> takeStep();

	void movement();
    double destinationX;
    double destinationY;
    double speed; //meters pr second
    bool moving;
    bool gridmove;

    void setRemoved();
    void simDone();
    double eventChance();

    std::string filename;
    //the LUA state:	//TODO: rewrite state
    friend class Sector;
    friend class Supervisor;
    bool nofile;
    bool removed;

    double moveFactor;
    void getSyncData();

    bool initiated = false;

};
