#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>
#include <iostream>

constexpr unsigned WINDOW_WIDTH = 800;
constexpr unsigned WINDOW_HEIGHT = 600;
constexpr float MAX_SIZE = 100.f; 
constexpr float MIN_SIZE = 30.f;
constexpr float MAX_RISING = 15.f;
constexpr float FRAME_DIVIDER = 100.f;
const std::string WINDOW_TITLE = "Pumping ball";

void init(sf::CircleShape&, bool&, bool&);
void redrawFrame(sf::RenderWindow&, sf::CircleShape&);
void pollEvents(sf::RenderWindow&);
void update(float, sf::CircleShape&, bool&, bool&);

int main()
{
    sf::Clock clock;
    
    //Создаем окно с параметрами сглаживания
    sf::ContextSettings settings;
    settings.antialiasingLevel = 8;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    
    //Объявляем фигуру
    sf::CircleShape curr_ball;

    bool isIncrease;
    bool isDecrease;
    
    init(curr_ball, isIncrease, isDecrease);
    
    //Выполняем основной цикл программы
    while (window.isOpen())
    {
        float deltaTime = clock.restart().asMilliseconds();
        pollEvents(window);
        update(deltaTime, curr_ball, isIncrease, isDecrease);
        redrawFrame(window, curr_ball);
    }
}

//Инициализируем фигуру-указатель
void init(sf::CircleShape& curr_ball, bool& isIncrease, bool& isDecrease)
{
    //Устанавливаем радиус шара
    curr_ball.setRadius(MIN_SIZE);
    //Устанавливаем координаты центра шара
    curr_ball.setPosition(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
    curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
    //Устанавливаем цвет шара
    curr_ball.setFillColor(sf::Color(0xFF, 0x9, 0x80));
    ////Устанавливаем значения переменных рост/уменьшение шара
    isIncrease = true;
    isDecrease = false;
}

//Рисует и  выводит один кадр
void redrawFrame(sf::RenderWindow& window, sf::CircleShape& curr_ball)
{
    window.clear();
    window.draw(curr_ball);
    window.display();       
}

//Опрашивает и обрабатывает доступные события в цикле
void pollEvents(sf::RenderWindow& window)
{
    sf::Event event{};
    while (window.pollEvent(event))
    {
        switch (event.type)
        {
            case sf::Event::Closed:
                window.close();
                break;
            default:
                break;        
        }
    }
} 

void update(float deltaTime, sf::CircleShape& curr_ball, bool& isIncrease, bool& isDecrease)
{
    //Вычисляем смещение и задаем пульсации шара
    const float maxRisingPerFrame = MAX_RISING/ FRAME_DIVIDER * deltaTime;
    const float currRisingPerFrame = std::abs((MAX_SIZE - curr_ball.getRadius()) / FRAME_DIVIDER * deltaTime);
    
    if (isIncrease == true && isDecrease == false)
    {
        if ((curr_ball.getRadius() + std::min(maxRisingPerFrame, currRisingPerFrame)) >= MAX_SIZE)
        {
            curr_ball.setRadius(curr_ball.getRadius() + std::min(maxRisingPerFrame, currRisingPerFrame));
            curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
            isIncrease = false;
            isDecrease = true;    
        }
        else
        {
            curr_ball.setRadius(curr_ball.getRadius() + maxRisingPerFrame);
            curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
        }    
    }
    else if (isIncrease == false && isDecrease == true)
    {
        if ((curr_ball.getRadius() - std::min(maxRisingPerFrame, currRisingPerFrame)) <= MIN_SIZE)
        {
            curr_ball.setRadius(curr_ball.getRadius() - std::min(maxRisingPerFrame, currRisingPerFrame));
            curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
            isIncrease = true;
            isDecrease = false;
        }
        else
        {
            curr_ball.setRadius(curr_ball.getRadius() - maxRisingPerFrame);
            curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
        }
    } 
}