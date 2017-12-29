#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <vector>
#include <cmath>
#include <iostream>
#include <string>
#include <set>
#include <random>
#include <ctime>

using namespace std;
using namespace sf;

constexpr unsigned int WINDOW_WIDTH = 800;
constexpr unsigned int WINDOW_HEIGHT = 600;
constexpr unsigned int BALLS_COUNT = 4;
constexpr unsigned int DEF_RADIUS = 40;
constexpr char WINDOW_TITLE[] = "Moving balls";

static const sf::Color BACKGROUND_COLOR = sf::Color(0, 0, 0);

struct Colr
{
    int red;
    int green;
    int blue;

    bool operator<(const Colr& curr) const
    {
        if (red < curr.red)
        {
           return true;
        }
        else if (red == curr.red)
        {
            if (green < curr.green)
            {
                return true;
            }
            else if (green == curr.green)
            {
                return blue < curr.blue;
            }
        }

        return false;
    }
};

struct Ball
{
    CircleShape shape;
    Vector2f offset;
};

struct PRNG
{
    std::mt19937 engine;
};

void initGenerator(PRNG& generator);
size_t random_index(PRNG& generator, int size);
bool checkBGColor(Colr& colr);
Colr initColor(PRNG generator, set<Colr>& isColrs);
void pollEvents(RenderWindow& window);
float length(const Vector2f& value);
float distance(const Ball& ball, const Ball& curr);
float dot(const Vector2f& left, const Vector2f& right);
float sqr(float value);
Vector2f getSpeedAfterStrike(const Ball& first, const Ball& second);
Vector2f setOffset(Ball ball);
void update(vector<Ball>& balls, float deltaTime);
void redrawFrame(RenderWindow& window, vector<Ball>& balls);
void initBall(PRNG generator, vector<Ball>& balls, Ball& ball, set<Colr>& isColrs);
void init(PRNG& generator, set<Colr>& isColrs, vector<Ball>& balls, Ball& ball);

int main()
{
    Clock clock;
    ContextSettings settings;
    RenderWindow window(VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, Style::Default, settings);
    vector<Ball> balls(BALLS_COUNT);
    PRNG generator;
    Ball ball;
    set<Colr> isColrs; 

    init(generator, isColrs, balls, ball);

    while (window.isOpen())
    {
        float deltaTime = clock.restart().asSeconds();
        pollEvents(window);
        update(balls, deltaTime);
        redrawFrame(window, balls);
    }
}

void initGenerator(PRNG& generator)
{
    // Используем время с 1 января 1970 года в секундах как случайное зерно
    const unsigned seed = unsigned(std::time(nullptr));
    generator.engine.seed(seed);
}

// Генерирует индекс в диапазоне [0, size)
size_t random_index(PRNG& generator, int size)
{
    // Создаём распределение
    std::uniform_int_distribution<int> distribution(0, size - 1);
    
    // Вычисляем псевдослучайное число: вызовем распределение как функцию,
    //  передав генератор произвольных целых чисел как аргумент.
    return distribution(generator.engine);
}

bool checkBGColor(Colr& colr)
{
    if((colr.red != BACKGROUND_COLOR.r) && (colr.green != BACKGROUND_COLOR.g) && (colr.blue != BACKGROUND_COLOR.b))
    {
        return true;
    }
    else
    {
        return false;
    }
}

Colr initColor(PRNG generator, set<Colr>& isColrs)
{
    Colr colr;
    colr.red = random_index(generator, 256);
    colr.green = random_index(generator, 256);
    colr.blue = random_index(generator, 256);
    if(isColrs.empty() || (isColrs.find(colr) == isColrs.end()) && checkBGColor(colr))
    {
        isColrs.insert(colr);
        return colr;
    }
    else
    {
        initColor(generator, isColrs);        
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
    window.clear(BACKGROUND_COLOR);
    for (auto& ball: balls)
    {
        window.draw(ball.shape);        
    }
    window.display();
}

void initBall(PRNG generator, vector<Ball>& balls, Ball& ball, set<Colr>& isColrs)
{
    const vector<Vector2f> positions = {
        { 5 * DEF_RADIUS, 5 * DEF_RADIUS },
        { WINDOW_WIDTH - 3 * DEF_RADIUS, WINDOW_HEIGHT - 12 * DEF_RADIUS },
        { WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 },
        { WINDOW_WIDTH - 3 * DEF_RADIUS, WINDOW_HEIGHT - 3 * DEF_RADIUS }
    };

    for (int i = 0; i < BALLS_COUNT; ++i)
    {
        balls.at(i).offset.x = random_index(generator, 250);
        balls.at(i).offset.y = random_index(generator, 250);
        balls.at(i).shape.setRadius(DEF_RADIUS);
        balls.at(i).shape.setPosition(positions.at(i));
        Colr colr = initColor(generator, isColrs);
        balls.at(i).shape.setFillColor(sf::Color(colr.red, colr.green, colr.blue));
        balls.at(i).shape.setOrigin(balls.at(i).shape.getRadius(), balls.at(i).shape.getRadius());
    }
}

void init(PRNG& generator, set<Colr>& isColrs, vector<Ball>& balls, Ball& ball)
{
    initGenerator(generator);
    initBall(generator, balls, ball, isColrs);
}