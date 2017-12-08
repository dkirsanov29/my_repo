#include <iostream>

int main()
{
    int num = 0;
    for (int num = 1; num <= 100; num += 1)
    {
        // неправильны пример: если число чётное, выводим его и пишем "odd!", иначе пишем "odd!"
        switch (num % 15)
        {
            case 0:
                std::cout << "FizzBuzz" << std::endl;
                break;
            case 5:
            case 10:
                std::cout << "Buzz" << std::endl;
                break;
            case 3:
            case 6:
            case 9:
            case 12:
                std::cout << "Fizz" << std::endl;
                break;
            default:
                //выводим само число
                std::cout << num << std::endl;    
        }
    }
}    
