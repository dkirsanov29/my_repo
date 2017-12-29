#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <iostream>

using namespace std;
using namespace sf;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int DEF_RADIUS = 40;
constexpr char WINDOW_TITLE[] = "The Ball";

struct Ball
{
    CircleShape shape;
};

void pollEvents(RenderWindow& window);
void redrawFrame(RenderWindow& window);
void init(Ball& ball);


int main()
{
	ContextSettings settings;
    RenderWindow window(VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, Style::Default, settings);
        
	init(ball);

	while (window.isOpen())
    {
	    pollEvents(window);
        redrawFrame(window);
    }
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



Vector2f setOffset(Ball ball)
{
    if ((ball.shape.getPosition().y >= WINDOW_HEIGHT - ball.shape.getRadius()) || (ball.shape.getPosition().y <= ball.shape.getRadius()))
    {
        ball.offset.y = -ball.offset.y;
    }

    if ((ball.shape.getPosition().x >= WINDOW_WIDTH - ball.shape.getRadius()) || (ball.shape.getPosition().x <= ball.shape.getRadius()))
    {
        ball.offset.x = -ball.offset.x;
    }

    return ball.offset;
}

void update(vector<Ball>& balls, float deltaTime)
{
    for (auto& ball: balls)
    {
        ball.offset = setOffset(ball);
        ball.shape.move(ball.offset * deltaTime);
    }
}

void redrawFrame(RenderWindow& window, vector<Ball>& balls)
{
    window.clear();
    for (auto& ball: balls)
    {
        window.draw(ball.shape);
    }
    window.display();
}

void init(vector<Ball>& balls)
{
    const vector<Color> colors = {
        Color(128, 64, 255),
        Color(255, 64, 128),
        Color(128, 255, 64),
        Color(64, 128, 255)    
    };

    const vector<Vector2f> speeds = {
        { 100.f, 100.f },
        { -150.f, -150.f },
        { 200.f, 200.f },
        { -250.f, -250.f }    
    };

    const vector<Vector2f> positions = {
        { 5 * DEF_RADIUS, 5 * DEF_RADIUS },
        { WINDOW_WIDTH - 3 * DEF_RADIUS, WINDOW_HEIGHT - 12 * DEF_RADIUS },
        { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
        { WINDOW_WIDTH - 3 * DEF_RADIUS, WINDOW_HEIGHT - 3 * DEF_RADIUS }
    };

    for (int i = 0; i < BALLS_COUNT; ++i)
    {
        balls.at(i).offset = speeds.at(i);
        balls.at(i).shape.setRadius(DEF_RADIUS);
        balls.at(i).shape.setPosition(positions.at(i));
        balls.at(i).shape.setFillColor(colors.at(i));
        balls.at(i).shape.setOrigin(balls.at(i).shape.getRadius(), balls.at(i).shape.getRadius());
    }
}