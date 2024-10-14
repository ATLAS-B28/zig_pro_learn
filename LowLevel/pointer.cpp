#include <iostream>

using namespace std;

int main()
{
    int x = 10;
    int* px = &x;

    cout << "Value of x: " << x << endl;
    cout << "Memory address of x: " << &x << endl;
    cout << "Value of px: " << px << endl;
    cout << "Value at memory address px: " << *px << endl; 
    cout << "Memory address of px: " << &px << endl;

    return 0;
}