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

float toDegrees(float radians);
void update(sf::Vector2f& mousePosition, sf::ConvexShape& arrow, float deltaTime);
void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition);
void pollEvents(sf::RenderWindow& window, sf::Vector2f& mousePosition);
void init(sf::ConvexShape& arrow);
void redrawFrame(sf::RenderWindow& window, sf::ConvexShape arrow);

int main()
{
	sf::ContextSettings settings;
    settings.antialiasingLevel = ANTIALIASING_LEVEL;
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, sf::Style::Default, settings);
    sf::Vector2f mousePosition;
    sf::Clock clock;
    sf::ConvexShape arrow;

	init(arrow);
		
	while (window.isOpen())
    {
		float deltaTime = clock.restart().asMilliseconds();
        pollEvents(window, mousePosition);
        update(mousePosition, arrow, deltaTime);
		redrawFrame(window, arrow);   	
    }
}

//Переводит радианы в градусы
float toDegrees(float radians)
{
    return (double(radians)*180.0/M_PI);
}

//Объявляет фигуру, указывающую на мышь
void update(sf::Vector2f& mousePosition, sf::ConvexShape& arrow, float deltaTime)
{
    const sf::Vector2f delta = mousePosition - arrow.getPosition();
    float radians = atan2(delta.y, delta.x);
    if(radians < 0)
    {
        radians += 2 * M_PI;
    }
    float currAngle = toDegrees(radians);

    const float maxDegreesPerFrame = 90.f / deltaTime;
    float prevAngle = arrow.getRotation();
    const float degreesPerFrame = std::abs(currAngle - prevAngle);

    const float deltaLength = std::sqrt(std::pow(delta.x, 2) + std::pow(delta.y, 2));
    const sf::Vector2f direction = {delta.x / deltaLength, delta.y / deltaLength};  


    if(currAngle != prevAngle)
    {
        if(currAngle > prevAngle)
        {
            if(currAngle - 180 > prevAngle)
            {
                arrow.setRotation(prevAngle - std::min(degreesPerFrame, maxDegreesPerFrame));
            }
            else
            {
                arrow.setRotation(prevAngle + std::min(degreesPerFrame, maxDegreesPerFrame));
            }    
        }
        else
        {
            if(currAngle + 180 < prevAngle)
            {
                arrow.setRotation(prevAngle + std::min(degreesPerFrame, maxDegreesPerFrame));
            }
            else
            {
                arrow.setRotation(prevAngle - std::min(degreesPerFrame, maxDegreesPerFrame));
            }    
        }        
    } 

    arrow.setPosition(arrow.getPosition() + deltaTime * direction);
}

//Обрабатываем событие MouseMove, обновляя позицию мыши
void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition)
{
    mousePosition = {float(event.x), float(event.y)}; 
}

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