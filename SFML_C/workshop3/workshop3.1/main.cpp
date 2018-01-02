#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <vector>
#include <iostream>

using namespace std;
using namespace sf;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int DEF_RADIUS = 80;
constexpr unsigned int ANTI_ALIASING_LEV = 10;
constexpr char WINDOW_TITLE[] = "Yellow ball";
constexpr char FOND_PATH[] = "D:/cpp/Projects/labs/workshop3/workshop3.1/fonds/arial.ttf";
constexpr char ERR_MSG[] = "Error: could not load fond file";

struct Ball
{
    CircleShape shape;
    Text textLine;
};

void pollEvents(RenderWindow& window);
void redrawFrame(RenderWindow& window, Ball currBall);
void init(Ball& currBall);

int main()
{
    ContextSettings settings;
    settings.antialiasingLevel = ANTI_ALIASING_LEV;
    RenderWindow window(VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, Style::Default, settings);
    Ball currBall;
    init(currBall);
    while (window.isOpen())
    {
        pollEvents(window);
        redrawFrame(window, currBall);
    }
}

void init(Ball& currBall)
{
    currBall.shape.setFillColor(Color(255, 192, 0));
    currBall.shape.setRadius(DEF_RADIUS);
    currBall.shape.setOrigin(currBall.shape.getRadius(), currBall.shape.getRadius());
    currBall.shape.setPosition(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2);
    currBall.shape.setOutlineColor(Color(47, 85, 151));
    currBall.shape.setOutlineThickness(0.05 * currBall.shape.getRadius());
}

void pollEvents(RenderWindow& window)
{
    Event event{};
    while (window.pollEvent(event))
    {
        switch (event.type)
        {
        case Event::Closed:
            window.close();
            break;
        default:
            break;  
        }
    }
}

void redrawFrame(RenderWindow& window, Ball currBall)
{
    window.clear();
    window.draw(currBall.shape);
    window.display();
}