#include <cstdio>
#include <math.h>

int main()
{
	// 1. prompt user to enter coefficients
	float a = 0;
	float b = 0;
	float c = 0;
	std::puts("please enter a, b and c for 'ax^2 + bx + c = 0':");
	// 2. read coefficients for equation `ax^2 + bx + c = 0`
	std::scanf("%f %f %f", &a, &b, &c);
	//std::printf("a = %f, b = %f, c = %f\n", a, b, c);
	// 3. solve equation `ax^2 + bx + c = 0`
	// solution: x1 = (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
	//           x2 = (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
	
	float x1 = 0;
	float x2 = 0;
	x1 = (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
	x2 = (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
	std::printf("solution x1 = %f, x2 = %f\n", x1, x2 );
}