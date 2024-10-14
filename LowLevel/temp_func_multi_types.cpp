#include <iostream>
#include <string>

template<typename T, typename U> 
void swap2(T& a, U& b) {
    T temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 10;
    int y = 20;

    swap2(x, y);

    std::cout << "x: " << x << std::endl;
    std::cout << "y: " << y << std::endl;

    std::string str1 = "Hello";
    std::string str2 = "World";

    swap2(str1, str2);

    std::cout << "str1: " << str1 << std::endl;
    std::cout << "str2: " << str2 << std::endl;

    return 0;
}
