#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>
#include <iostream>

using namespace std;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int DIVIDER = 10;
constexpr char WINDOW_TITLE[] = "Kitty moves";
constexpr char ERR_MSG[] = "Texture hasn't been downloaded. Try again, please";

static const sf::Color BACKGROUND_COLOR = sf::Color(255, 255, 255);


struct Pointer
{
    const std::string SPRITE_PATH = "./img/red_pointer.png";

    sf::Texture texture;
    sf::Sprite sprite;
};

struct Kitty
{
    const std::string SPRITE_PATH = "./img/cat.png";
        
    sf::Texture texture;
    sf::Sprite sprite;
};

void update(sf::Vector2f& mousePosition, Kitty& kitty, Pointer& pointer, float deltaTime);
void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition);
bool pollEvents(sf::RenderWindow& window, sf::Vector2f& mousePosition);
void init(Kitty& kitty, Pointer& pointer);
void redrawFrame(sf::RenderWindow& window, Kitty& kitty, Pointer& pointer);

int main()
{
    sf::ContextSettings settings;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    sf::Vector2f mousePosition;
    sf::Clock clock;
    Kitty kitty;
    Pointer pointer;

    init(kitty, pointer);

    while (window.isOpen())
    {
        float deltaTime = clock.restart().asMilliseconds();
        if (!pollEvents(window, mousePosition))
        {
            break;
        }
        update(mousePosition, kitty, pointer, deltaTime);
        redrawFrame(window, kitty, pointer);
    }
}

void update(sf::Vector2f& mousePosition, Kitty& kitty, Pointer& pointer, float deltaTime)
{
    const sf::Vector2f delta = mousePosition - kitty.sprite.getPosition();
    const float deltaLength = std::sqrt(std::pow(delta.x, 2) + std::pow(delta.y, 2));
    const sf::Vector2f direction = {delta.x / deltaLength, delta.y / deltaLength};  
    
    if(pointer.sprite.getPosition() != kitty.sprite.getPosition())
    {
        if(pointer.sprite.getPosition().x > kitty.sprite.getPosition().x)
        {
            kitty.sprite.setScale(1, 1);   
        }
        else
        {
            kitty.sprite.setScale(-1, 1);   
        }           
    }

    pointer.sprite.setPosition(mousePosition);
    kitty.sprite.setPosition(kitty.sprite.getPosition() + deltaTime / DIVIDER * direction);
}

//Обрабатываем событие MouseMove, обновляя позицию мыши
void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition)
{
    mousePosition = {float(event.x), float(event.y)};
}

bool pollEvents(sf::RenderWindow& window, sf::Vector2f& mousePosition)
{
    sf::Event event{};
    while (window.pollEvent(event))
    {
        switch (event.type)
        {
        case sf::Event::Closed:
            window.close();
            return false;
        case sf::Event::MouseMoved:
            onMouseMove(event.mouseMove, mousePosition);
            break;
        default:
            break;
        }
    }
    return true;
}

void init(Kitty& kitty, Pointer& pointer)
{
    if(!kitty.texture.loadFromFile(kitty.SPRITE_PATH) || !pointer.texture.loadFromFile(pointer.SPRITE_PATH))
    {
        cout << ERR_MSG << endl;   
    }
    else
    {
        kitty.sprite.setTexture(kitty.texture);
        pointer.sprite.setTexture(pointer.texture);
        kitty.sprite.setOrigin(kitty.texture.getSize().x / 2, kitty.texture.getSize().y / 2);
        pointer.sprite.setOrigin(pointer.texture.getSize().x / 2, pointer.texture.getSize().y / 2);
        kitty.sprite.setPosition(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2);
    }
}

void redrawFrame(sf::RenderWindow& window, Kitty& kitty, Pointer& pointer)
{
    window.clear(BACKGROUND_COLOR);
    window.draw(kitty.sprite);
    window.draw(pointer.sprite);
    window.display();
}