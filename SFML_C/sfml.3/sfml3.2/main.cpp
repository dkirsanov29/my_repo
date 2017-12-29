#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600
#define WINDOW_TITLE "Looking eyes"
#define ANTIALIASING_LEVEL 8

const unsigned int pointCount = 200;
const sf::Color backColor = sf::Color(255, 255, 255);
const sf::Color irisColor = sf::Color(0, 0, 0);
const sf::Vector2f radius = { 50.f, 80.f };

struct Eye
{
	sf::ConvexShape back;
	sf::ConvexShape iris;
	float rotation = 0;
	sf::Vector2f position;
};

sf::Vector2f toEuclidian(float a, float b, float angle)
{
	return { a * std::sin(angle), b * std::cos(angle) };
}

void updateElement(Eye& leftEye, Eye& rightEye)
{
	sf::Vector2f offset = toEuclidian(radius.x / 3, radius.y / 3, leftEye.rotation);
	leftEye.iris.setPosition(leftEye.position + offset);
	
	offset = toEuclidian(radius.x / 3, radius.y / 3, rightEye.rotation);
	rightEye.iris.setPosition(rightEye.position + offset);
}

void update(const sf::Vector2f& mousePosition, Eye& leftEye, Eye& rightEye)
{
	const sf::Vector2f leftEyeDelta = mousePosition - leftEye.position;
	leftEye.rotation = std::atan2(leftEyeDelta.x, leftEyeDelta.y);
	const sf::Vector2f rightEyeDelta = mousePosition - rightEye.position;
	rightEye.rotation = std::atan2(rightEyeDelta.x, rightEyeDelta.y);
	updateElement(leftEye, rightEye);
}

void onMouseMove(const sf::Event::MouseMoveEvent& event, sf::Vector2f& mousePosition)
{
	mousePosition = { float(event.x), float(event.y) };
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

void redrawFrame(sf::RenderWindow& window, Eye& leftEye, Eye& rightEye)
{
	window.clear();
	window.draw(leftEye.back);
	window.draw(leftEye.iris);
	window.draw(rightEye.back);
	window.draw(rightEye.iris);
	window.display();
}

void buildElements(Eye& newEye)
{
	for(int pointNo = 0; pointNo < newEye.back.getPointCount(); ++pointNo)
	{
		float angle = float(2 * M_PI * pointNo) / float(newEye.back.getPointCount());
		sf::Vector2f point = {
			radius.x * std::sin(angle),
			radius.y * std::cos(angle) 
		};
		newEye.back.setPoint(pointNo, point);
	}

	for(int pointNo = 0; pointNo < newEye.iris.getPointCount(); ++pointNo)
	{
		float angle = float(2 * M_PI * pointNo) / float(newEye.iris.getPointCount());
		sf::Vector2f point = {
			radius.x / 4 * std::sin(angle),
			radius.y / 4 * std::cos(angle)  
		};
		newEye.iris.setPoint(pointNo, point);
	}
}

void init(Eye& leftEye, Eye& rightEye)
{
	const sf::Vector2f leftEyePosition = { WINDOW_WIDTH / 2 + WINDOW_WIDTH / 12, WINDOW_HEIGHT / 2 };
	const sf::Vector2f rightEyePosition = { WINDOW_WIDTH / 2 - WINDOW_WIDTH / 12, WINDOW_HEIGHT / 2 };

	leftEye.position = leftEyePosition;
	leftEye.back.setPosition(leftEyePosition);
	leftEye.back.setFillColor(backColor);
	leftEye.back.setPointCount(pointCount);

	leftEye.iris.setPosition(leftEyePosition);
	leftEye.iris.setFillColor(irisColor);
	leftEye.iris.setPointCount(pointCount / 4);

	buildElements(leftEye);

	rightEye.position = rightEyePosition;
	rightEye.back.setPosition(rightEyePosition);
	rightEye.back.setFillColor(backColor);
	rightEye.back.setPointCount(pointCount);

	rightEye.iris.setPosition(rightEyePosition);
	rightEye.iris.setFillColor(irisColor);
	rightEye.iris.setPointCount(pointCount / 4);

	buildElements(rightEye);
}

int main()
{
	sf::ContextSettings settings;
	settings.antialiasingLevel = ANTIALIASING_LEVEL;
	sf::RenderWindow window(sf::VideoMode(WINDOW_WIDTH, WINDOW_HEIGHT), WINDOW_TITLE, sf::Style::Default, settings);
	
	Eye leftEye;
	Eye rightEye;
	
	sf::Vector2f mousePosition;

	init(leftEye, rightEye);

	while (window.isOpen())
	{
		pollEvents(window, mousePosition);
		update(mousePosition, leftEye, rightEye);
		redrawFrame(window, leftEye, rightEye);
	}
}

