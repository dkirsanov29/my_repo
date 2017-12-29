#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <vector>
#include <cmath>
#include <iostream>

using namespace std;
using namespace sf;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int BALLS_COUNT = 4;
constexpr unsigned int DEF_RADIUS = 40;
constexpr char WINDOW_TITLE[] = "Moving balls";

struct Ball
{
    CircleShape shape;
    Vector2f offset;
};

void pollEvents(RenderWindow& window);
float length(const Vector2f& value);
float distance(const Ball& ball, const Ball& curr);
float dot(const Vector2f& left, const Vector2f& right);
float sqr(float value);
Vector2f getSpeedAfterStrike(const Ball& first, const Ball& second);
Vector2f setOffset(Ball ball);
void update(vector<Ball>& balls, float deltaTime);
void redrawFrame(RenderWindow& window, vector<Ball>& balls);
void init(vector<Ball>& balls);

int main()
{
	Clock clock;
    ContextSettings settings;
    RenderWindow window(VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, Style::Default, settings);
    vector<Ball> balls(BALLS_COUNT);
    
	init(balls);

	while (window.isOpen())
    {
	    float deltaTime = clock.restart().asSeconds();
        pollEvents(window);
        update(balls, deltaTime);
        redrawFrame(window, balls);
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

float length(const Vector2f& value)
{
    return std::hypot(value.x, value.y);
}

float distance(const Ball& ball, const Ball& curr)
{
    return length(ball.shape.getPosition() - curr.shape.getPosition());
}

float dot(const Vector2f& left, const Vector2f& right)
{
    return left.x * right.x + left.y * right.y;
}

float sqr(float value)
{
    return value * value;
}

Vector2f getSpeedAfterStrike(const Ball& first, const Ball& second)
{
    const Vector2f deltaSpeed = first.offset - second.offset;
    const Vector2f deltaPos = first.shape.getPosition() - second.shape.getPosition();
    return first.offset - deltaPos * (dot(deltaSpeed, deltaPos) / sqr(length(deltaPos)));
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
    constexpr float MAX_DELTA_TIME = 0.1f;
    deltaTime = std::min(deltaTime, MAX_DELTA_TIME);

    for (size_t fi = 0; fi < balls.size(); ++fi)
    {
        for (size_t si = fi + 1; si < balls.size(); ++si)
        {
            Ball& first = balls[fi];
            Ball& second = balls[si];
            if (distance(first, second) <= (first.shape.getRadius() + second.shape.getRadius()))
            {
                const Vector2f newFirstSpeed = getSpeedAfterStrike(first, second);
                const Vector2f newSecondSpeed = getSpeedAfterStrike(second, first);
                first.offset = newFirstSpeed;
                second.offset = newSecondSpeed;
            }
        }
    }

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