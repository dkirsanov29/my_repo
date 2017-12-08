#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>
#include <iostream>

constexpr unsigned WINDOW_WIDTH = 800;
constexpr unsigned WINDOW_HEIGHT = 600;
const std::string WINDOW_TITLE = "Polar rose moving ";

int main()
{
    constexpr int pointCount = 200;
    constexpr int amplitude = 20;

    sf::Vector2f position = {WINDOW_WIDTH/2, WINDOW_HEIGHT/2};
    sf::Clock clock;

    //Создаем окно с параметрами сглаживания
    sf::ContextSettings settings;
    settings.antialiasingLevel = 8;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);

    //Объявляем фигуру, которая будет выглядеть как полярная роза
    sf::ConvexShape curr_figure;
    
    //Устанавливаем цвет объявленной фигуры
    curr_figure.setFillColor(sf::Color(0xFF, 0x9, 0x80));    

    //Инициализируем вершины полярной розы
    curr_figure.setPointCount(pointCount);
    for (int pointNo = 0; pointNo < pointCount; ++pointNo)
    {
        float angle = float(2 * M_PI * pointNo) / float(pointCount);
        float curr_figureRadius = 200 * sin(6 * angle);
        sf::Vector2f point = {
            curr_figureRadius * std::sin(angle),
            curr_figureRadius * std::cos(angle)
        };
        curr_figure.setPoint(pointNo, point);            
    }

    //Выполняем основной цикл программы
    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if(event.type == sf::Event::Closed)
            {
                window.close();
            }        

        } 

        //Вычисляем смещение и задаем движение полярной розы
        float time = clock.getElapsedTime().asSeconds();
        float dt = time - dt;
        float wavePhase = time * float(2 * M_PI);
        float x = amplitude * std::cos(wavePhase);
        float y = amplitude * std::sin(wavePhase);
        sf::Vector2f offset = {x, y};
        curr_figure.setPosition(position + offset);

        window.clear();
        window.draw(curr_figure);
        window.display();
    }    
}