#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>
#include <iostream>
#include <algorithm>
#include <stdlib.h>


//Инициализируем фигуру-указатель
void init(sf::ConvexShape& pointer)
{
    pointer.setPointCount(3);
    pointer.setPoint(0, {40, 0});
    pointer.setPoint(1, {-20, -20});
    pointer.setPoint(2, {-20, 20});
    pointer.setPosition({400, 300});
    pointer.setFillColor(sf::Color(0xFF, 0x80, 0x00));
}

//Обрабатываем событие MouseMove, обновляя позицию мыши
void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition)
{
    mousePosition = {float(event.x), float(event.y)}; 
}

//Опрашивает и обрабатывает доступные события в цикле
void pollEvents(sf::RenderWindow& window, sf::Vector2f& mousePosition)
{
    sf::Event event{};
    while (window.pollEvent(event))
    {
        switch (event.type)
        {
            case sf::Event::Closed:
                window.close();
                break;
            case sf::Event::MouseMoved:
                onMouseMove(event.mouseMove, mousePosition);
                break;
            default:
                break;        
        }
    }
}    

//Переводит радианы в градусы
float toDegrees(float radians)
{
    return (double(radians)*180.0/M_PI);
}

//Рисует и  выводит один кадр
void redrawFrame(sf::RenderWindow& window, sf::ConvexShape& pointer)
{
    window.clear();
    window.draw(pointer);
    window.display();       
}

//Объявляет фигуру, указывающую на мышь
void update(sf::Vector2f& mousePosition, sf::ConvexShape& pointer, float deltaTime)
{
    const sf::Vector2f delta = mousePosition - pointer.getPosition();
    float radians = atan2(delta.y, delta.x);
    if(radians < 0)
    {
        radians += 2 * M_PI;
    }
    float currAngle = toDegrees(radians);
    const float maxDegreesPerFrame = 15.f/ 1000 * deltaTime;
    float prevAngle = pointer.getRotation();
    const float degreesPerFrame = std::abs((currAngle - prevAngle) / 1000 * deltaTime);

    if(currAngle != prevAngle)
    {
        if(currAngle > prevAngle)
        {
            if(currAngle - 180 > prevAngle)
            {
                pointer.setRotation(prevAngle - std::min(degreesPerFrame, maxDegreesPerFrame));
            }
            else
            {
                pointer.setRotation(prevAngle + std::min(degreesPerFrame, maxDegreesPerFrame));
            }    
        }
        else
        {
            if(currAngle + 180 < prevAngle)
            {
                pointer.setRotation(prevAngle + std::min(degreesPerFrame, maxDegreesPerFrame));
            }
            else
            {
                pointer.setRotation(prevAngle - std::min(degreesPerFrame, maxDegreesPerFrame));
            }    
        }        
    }    
}

int main()
{
    constexpr unsigned WINDOW_WIDTH = 800;
    constexpr unsigned WINDOW_HEIGHT = 600;

    //Создаем окно с параметрами сглаживания
    sf::ContextSettings settings;
    settings.antialiasingLevel = 8;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), "Prints mouse events to terminal");

    sf::Clock clock;
    sf::ConvexShape pointer;
    sf::Vector2f mousePosition;
    
    init(pointer);
    
    //Выполняем основной цикл программы
    while (window.isOpen())
    {
        float deltaTime = clock.restart().asMilliseconds();
        pollEvents(window, mousePosition);
        update(mousePosition, pointer, deltaTime);
        redrawFrame(window, pointer);
    }
}

