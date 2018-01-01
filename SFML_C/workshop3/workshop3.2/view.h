#include <SFML/Graphics.hpp>
#include <iostream>

using namespace std;
using namespace sf;
 
sf::View view;
 
 
void viewmap(float deltaTime) 
{ 
	if (Keyboard::isKeyPressed(Keyboard::Left))
	{
		cout << "Keyboard == Left" << endl;
		view.move(-0.1 * deltaTime, 0);
	}
 	if (Keyboard::isKeyPressed(Keyboard::Right))
	{
		cout << "Keyboard == Right" << endl;
		view.move(0.1 * deltaTime, 0);
	}
 	if (Keyboard::isKeyPressed(Keyboard::Up))
	{
		cout << "Keyboard == Up" << endl;
		view.move(0, 0.1 * deltaTime);
	}
	if (Keyboard::isKeyPressed(Keyboard::Down))
	{
		cout << "Keyboard == Down" << endl;
		view.move(0, -0.1 * deltaTime);
	}
}