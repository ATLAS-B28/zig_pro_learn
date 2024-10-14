#include <iostream>

template<typename T>
void swap(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
    return a;
}

int main() {

    /*int x = 10;
    int y = 20;
    int res = swap(x, y);

    std::cout << "Result: " << res << std::endl;*/

    /*std::string str1 = "Aditya";
    std::string str2 = "Bhambere";
    std::string res  = swap(str1, str2);

    std::cout << "Result: " << res << std::endl;*/
}