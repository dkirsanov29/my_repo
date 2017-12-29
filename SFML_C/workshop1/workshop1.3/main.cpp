#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <iostream>

using namespace std;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr char WINDOW_TITLE[] = "Show Kitty";
constexpr char IMG_PATH[] = "D://cpp/Projects/labs/workshop1/workshop1.3/img/cat.png";
constexpr char ERR_MSG[] = "Texture hasn't been downloaded. Try again, please";

static const sf::Color BACKGROUND_COLOR = sf::Color(255, 255, 255);
static const sf::Color SPRITE_COLOR = sf::Color(255, 255, 255, 200);


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
		default:
			break;
		}
	}
}

void init(sf::Texture& texture, sf::Sprite& sprite)
{
    if(!texture.loadFromFile(IMG_PATH))
    {
        cout << ERR_MSG << endl;   
    }
    else
    {
        sprite.setTexture(texture);
        sprite.setColor(SPRITE_COLOR);
        sprite.setPosition(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);   
    }    
}

void redrawFrame(sf::RenderWindow& window, sf::Sprite sprite)
{
	window.clear(BACKGROUND_COLOR);
    window.draw(sprite);
    window.display();
}


int main()
{
	sf::ContextSettings settings;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    sf::Vector2f mousePosition;
    sf::Texture texture;
    sf::Sprite sprite;

	init(texture, sprite);
		
	while (window.isOpen())
    {
		pollEvents(window, mousePosition);
        redrawFrame(window, sprite);
    }
}