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
constexpr unsigned int Q_FRAMES = 10;
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
    float lifeTime;    
};

struct PRNG
{
    std::mt19937 engine;
};

void initGenerator(PRNG&);
size_t random_index(PRNG&, int); // Генерирует индекс в диапазоне [0, size)
bool checkBGColor(Colr&);
Colr initColor(PRNG, set<Colr>&);
float setBallPosition(float, float);
void initNewBall(PRNG, vector<Ball>&, Ball&, set<Colr>&);
void pollEvents(RenderWindow&, PRNG, vector<Ball>&, Ball&, set<Colr>&);
float length(const Vector2f&);
float distance(const Ball&, const Ball&);
float dot(const Vector2f&, const Vector2f&);
float sqr(float);
Vector2f getSpeedAfterStrike(const Ball&, const Ball&);
Vector2f setOffset(Ball ball);
void removeDeathBalls(vector<Ball>& balls);
void update(vector<Ball>&, float);
void redrawFrame(RenderWindow&, vector<Ball>&);
void initDefaultPlayGround(PRNG, vector<Ball>&, Ball&, set<Colr>&);
void init(PRNG, set<Colr>&, vector<Ball>&, Ball&);

int main()
{
    Clock clock;
    ContextSettings settings;
    RenderWindow window(VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), WINDOW_TITLE, Style::Default, settings);
    vector<Ball> balls(BALLS_COUNT);
    PRNG generator;
    Ball ball;
    set<Colr> isColrs; 

    initGenerator(generator);
    init(generator, isColrs, balls, ball);

    while (window.isOpen())
    {
        initGenerator(generator);
        float deltaTime = clock.restart().asSeconds();
        pollEvents(window, generator, balls, ball, isColrs);
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
        return 1;
    }    
    else
    {
        return 0;
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
        return initColor(generator, isColrs);        
    }
}

float setBallPosition(float left, float right)
{
    return (left - right); 
}

void initNewBall(PRNG generator, vector<Ball>& balls, Ball& ball, set<Colr>& isColrs)
{
    ball.offset.x = random_index(generator, 250);
    ball.offset.y = random_index(generator, 250);
    ball.lifeTime = 0.f;
    ball.shape.setRadius(DEF_RADIUS);
    Colr colr = initColor(generator, isColrs);
    ball.shape.setFillColor(sf::Color(colr.red, colr.green, colr.blue));
    ball.shape.setPosition(random_index(generator, setBallPosition(WINDOW_WIDTH, ball.shape.getRadius())), random_index(generator, setBallPosition(WINDOW_HEIGHT, ball.shape.getRadius())));
    ball.shape.setOrigin(ball.shape.getRadius(), ball.shape.getRadius());
    
    for (auto&& item: balls)
    {
        if (ball.shape.getPosition().y >= WINDOW_HEIGHT - ball.shape.getRadius())
        {
            return;
        }

        if (ball.shape.getPosition().y <= ball.shape.getRadius())
        {
            return;
        }

        if (ball.shape.getPosition().x >= WINDOW_WIDTH - ball.shape.getRadius())
        {
            return;
        }

        if (ball.shape.getPosition().x <= ball.shape.getRadius())
        {
            return;
        }

        const float currentDistance = distance(item, ball);
        const float intersectionDistance = item.shape.getRadius() + ball.shape.getRadius();
                
        if (currentDistance <= intersectionDistance)
        {
            return;
        }
    }
    balls.insert(balls.end(), ball);
}

void pollEvents(RenderWindow& window, PRNG generator, vector<Ball>& balls, Ball& ball, set<Colr>& isColrs)
{
    Event event{};
    while (window.pollEvent(event))
    {
        switch (event.type)
        {
        case Event::Closed:
            window.close();
            break;
        case Event::MouseButtonReleased:
            if(event.mouseButton.button == sf::Mouse::Left)
            {
                initNewBall(generator, balls, ball, isColrs);    
            }    
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

void removeDeathBalls(vector<Ball>& balls)
{
    auto iterator = remove_if(balls.begin(), balls.end(), [](const Ball& ball){ return ball.lifeTime >= 10.f; });
    balls.erase(iterator, balls.end());
}

void update(vector<Ball>& balls, float deltaTime)
{
    constexpr float MAX_DELTA_TIME = 0.01f;
    deltaTime = std::min(deltaTime, MAX_DELTA_TIME);

    for (size_t fi = 0; fi < balls.size(); ++fi)
    {
        for (size_t si = fi + 1; si < balls.size(); ++si)
        {
            Ball& first = balls[fi];
            Ball& second = balls[si];
            if(distance(first, second) <= (first.shape.getRadius() + second.shape.getRadius()))
            {  
                const Vector2f newFirstSpeed = getSpeedAfterStrike(first, second);
                const Vector2f newSecondSpeed = getSpeedAfterStrike(second, first);
                first.offset = newFirstSpeed;
                second.offset = newSecondSpeed;
            }
        }
    }
    
    int tmp;

    while (tmp <= Q_FRAMES)
    {
        for (auto& ball: balls)
        {
        
            ball.shape.move(ball.offset * (deltaTime / Q_FRAMES));
            if (tmp == Q_FRAMES)
            {
                ball.offset = setOffset(ball);
                ball.lifeTime += deltaTime;
            } 
        }
        tmp++;
    }
    removeDeathBalls(balls);
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

void initDefaultPlayGround(PRNG generator, vector<Ball>& balls, Ball& ball, set<Colr>& isColrs)
{
    for (int i = 0; i < BALLS_COUNT; ++i)
    {
        balls.at(i).offset.x = random_index(generator, 250);
        balls.at(i).offset.y = random_index(generator, 250);
        balls.at(i).lifeTime = 0.f;
        balls.at(i).shape.setRadius(DEF_RADIUS);
        Colr colr = initColor(generator, isColrs);
        balls.at(i).shape.setFillColor(sf::Color(colr.red, colr.green, colr.blue));
        balls.at(i).shape.setPosition(random_index(generator, setBallPosition(WINDOW_WIDTH, balls.at(i).shape.getRadius())), random_index(generator, setBallPosition(WINDOW_HEIGHT, balls.at(i).shape.getRadius())));    
        balls.at(i).shape.setOrigin(balls.at(i).shape.getRadius(), balls.at(i).shape.getRadius());
        
        for (size_t fi = 0; fi < balls.size(); ++fi)
        {
            while((balls.at(fi).shape.getPosition().x <= balls.at(fi).shape.getRadius()) || (balls.at(fi).shape.getPosition().y <= balls.at(fi).shape.getRadius()))
            {
                balls.at(fi).shape.setPosition(random_index(generator, setBallPosition(WINDOW_WIDTH, balls.at(fi).shape.getRadius())), random_index(generator, setBallPosition(WINDOW_HEIGHT, balls.at(fi).shape.getRadius())));
                balls.at(fi).shape.setOrigin(balls.at(fi).shape.getRadius(), balls.at(fi).shape.getRadius());
            }

            for (size_t si = fi + 1; si < balls.size(); ++si)
            {
                Ball& first = balls[fi];
                Ball& second = balls[si];
                while((distance(first, second) <= (first.shape.getRadius() + second.shape.getRadius())) || (balls.at(si).shape.getPosition().x <= balls.at(si).shape.getRadius()) || (balls.at(si).shape.getPosition().y <= balls.at(si).shape.getRadius()))
                {
                    balls.at(si).shape.setPosition(random_index(generator, setBallPosition(WINDOW_WIDTH, balls.at(si).shape.getRadius())), random_index(generator, setBallPosition(WINDOW_HEIGHT, balls.at(si).shape.getRadius())));
                    balls.at(si).shape.setOrigin(balls.at(si).shape.getRadius(), balls.at(si).shape.getRadius());
                }
            }
        }
    }
}

void init(PRNG generator, set<Colr>& isColrs, vector<Ball>& balls, Ball& ball)
{
    initDefaultPlayGround(generator, balls, ball, isColrs);
}