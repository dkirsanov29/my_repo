#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <cmath>

constexpr unsigned WINDOW_WIDTH = 800;
constexpr unsigned WINDOW_HEIGHT = 600;
constexpr unsigned BALL_SIZE = 40;
enum MOVING_STATUSES {toTheRight, toTheLeft};

int main()
{
    sf::RenderWindow window(sf::VideoMode({WINDOW_WIDTH, WINDOW_HEIGHT}), "Wave Moving Ball");
    sf::Clock clock;
    sf::Vector2f position = {10, 350};
    sf::CircleShape ball(BALL_SIZE);
    ball.setFillColor(sf::Color(0xFF, 0xFF, 0xFF));
    MOVING_STATUSES currMovingState = toTheRight;
    float time = 0;
    float x = 0;

    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }
        }

        constexpr float speedX = 100.f;
        constexpr float amplitudeY = 80.f;
        constexpr float periodY = 2;

        if (ball.getPosition().x <= 0)
        {
            currMovingState = toTheRight;
        }

        if (ball.getPosition().x + 2 * BALL_SIZE >= WINDOW_WIDTH)
        {
            currMovingState = toTheLeft;
        }

        const float deltaTime = clock.restart().asSeconds();
        time += deltaTime;
        const float wavePhase = time * float(2 * M_PI);
        const float y = amplitudeY * std::sin(wavePhase / periodY);
                
        if (currMovingState == toTheRight)
        {
            x += speedX * deltaTime;
        }

        if (currMovingState == toTheLeft)
        {
            x -= speedX * deltaTime;
        }
        
        const sf::Vector2f offset = {x, y};
        ball.setPosition(position + offset);

        window.clear();
        window.draw(ball);
        window.display();
    }
}
