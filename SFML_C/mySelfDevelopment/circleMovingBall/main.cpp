#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>

constexpr unsigned WINDOW_WIDTH = 800;
constexpr unsigned WINDOW_HEIGHT = 600;
constexpr unsigned AMPLITUDE = 50;
constexpr unsigned BALL_SIZE = 20;
const std::string WINDOW_TITLE = "Moving ball";

void init(sf::CircleShape&, sf::Vector2f);
void redrawFrame(sf::RenderWindow&, sf::CircleShape&);
void pollEvents(sf::RenderWindow&);
void update(float, sf::Vector2f, sf::CircleShape&);

int main()
{
    sf::Vector2f position = {WINDOW_WIDTH/2, WINDOW_HEIGHT/2};
    sf::Clock clock;

    //Создаем окно с параметрами сглаживания
    sf::ContextSettings settings;
    settings.antialiasingLevel = 8;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    
    //Объявляем фигуру
    sf::CircleShape curr_ball;

    init(curr_ball, position);
    
    //Выполняем основной цикл программы
    while (window.isOpen())
    {
        float time = clock.getElapsedTime().asSeconds();
        update(time, position, curr_ball);
        pollEvents(window);
        redrawFrame(window, curr_ball);
    }
}

//Инициализируем фигуру-указатель
void init(sf::CircleShape& curr_ball, sf::Vector2f position)
{
    //Устанавливаем радиус шара
    curr_ball.setRadius(BALL_SIZE);
    //Устанавливаем координаты центра шара
    curr_ball.setPosition(position.x, position.y);
    curr_ball.setOrigin(curr_ball.getRadius(), curr_ball.getRadius());
    //Устанавливаем цвет шара
    curr_ball.setFillColor(sf::Color(0xFF, 0x9, 0x80));
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

//Устанавливает траекторию движения шара
void update(float time, sf::Vector2f position, sf::CircleShape& curr_ball)
{
    float wavePhase = time * float(2 * M_PI);
    float x = AMPLITUDE * std::cos(wavePhase);
    float y = AMPLITUDE * std::sin(wavePhase);
    sf::Vector2f offset = {x, y};
    curr_ball.setPosition(position + offset);        
}
