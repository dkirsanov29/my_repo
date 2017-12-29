#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <iostream>

constexpr unsigned WINDOW_WIDTH = 800;
constexpr unsigned WINDOW_HEIGHT = 600;

int main()
{
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), "Prints mouse events to terminal");

    while (window.isOpen())
    {
        //1. process events with nested loop
        sf::Event event;
        while (window.pollEvent(event))
        {
            switch (event.type)
            {
            case sf::Event::Closed:
                window.close();
                break;
            case sf::Event::MouseButtonPressed:
                std::cout << "mouse pressed, "
                          << "x= " << event.mouseButton.x
                          << " y= " << event.mouseButton.y
                          << std::endl;
                break;                   
            case sf::Event::MouseButtonReleased:
                std::cout << "mouse released, "
                          << "x= " << event.mouseButton.x
                          << " y= " << event.mouseButton.y
                          << std::endl;
                break;
            default:
                break;        
            }

        }
        window.clear();
        window.display();
    }
}    