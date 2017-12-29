#include <iostream>

int main()
{
    for (int num = 1; num <= 100; num += 1)
    {
        if ((num % 3 == 0) && (num % 5 == 0))
        {
            //Выводим Fizz            
            std::cout << "FizzBuzz" << std::endl;
        }
        else if (num % 5 == 0)
        {
            //Выводим Buzz            
            std::cout << "Buzz" << std::endl;
        }
        else if (num % 5 == 0)
        {
            //Выводим Buzz            
            std::cout << "Buzz" << std::endl;
        }
        else
        {
            std::cout << num << std::endl;    
        }        
    }
}


