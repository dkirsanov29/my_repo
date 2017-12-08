#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int ANTIALIASING_LEVEL = 8;
constexpr unsigned int OUTLINE_THICKNESS = 5;
constexpr char WINDOW_TITLE[] = "Moving Arrow";

static const sf::Color BACKGROUND_COLOR = sf::Color(255, 255, 255);
static const sf::Color ARROW_COLOR = sf::Color(255, 255, 0);
static const sf::Color OUTLINE_COLOR = sf::Color(0, 0, 0);


void init(sf::ConvexShape& arrow);
void redrawFrame(sf::RenderWindow& window, sf::ConvexShape arrow);
void pollEvents(sf::RenderWindow& window);

int main()
{
	sf::ContextSettings settings;
    settings.antialiasingLevel = ANTIALIASING_LEVEL;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    sf::ConvexShape arrow;

	init(arrow);
		
	while (window.isOpen())
    {
		pollEvents(window);
		redrawFrame(window, arrow);   	
    }
}
void init(sf::ConvexShape& arrow)
{
	arrow.setPointCount(7);
	arrow.setPoint(0, sf::Vector2f(40, 0));
	arrow.setPoint(1, sf::Vector2f(0, -40));
	arrow.setPoint(2, sf::Vector2f(0, -20));
	arrow.setPoint(3, sf::Vector2f(-40, -20));
	arrow.setPoint(4, sf::Vector2f(-40, 20));
	arrow.setPoint(5, sf::Vector2f(0, 20));
	arrow.setPoint(6, sf::Vector2f(0, 40));
	arrow.setOutlineColor(OUTLINE_COLOR);
	arrow.setFillColor(ARROW_COLOR);
	arrow.setOutlineThickness(OUTLINE_THICKNESS);
	arrow.setPosition(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
	arrow.setRotation(280);
}

void redrawFrame(sf::RenderWindow& window, sf::ConvexShape arrow)
{
	window.clear(BACKGROUND_COLOR);
    window.draw(arrow);
    window.display();
}

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