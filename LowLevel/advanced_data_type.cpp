//struct
#include <iostream>
#include <ostream>
#include <string>

struct Person {
   std::string name;
   int age;
};

union Value {
    int i;
    double d;
    char c;
};

enum Color {
    RED,
    BLUE,
    GREEN
};

struct Flags {
    unsigned int flag1 : 1;
    unsigned int flag2 : 1;
    unsigned int flag3 : 1;
};

/**
 * @brief Main function
 * 
 * This function is the entry point of the program. It tests the different
 * features of C++ including structs, unions, enums and bitfields.
 * 
 * @return 0 on successful execution
 */
int main() {
    Person person;

    person.name = "Aditya";
    person.age = 22;

    std::cout << "Name: " << person.name << std::endl;
    std::cout << "Age: " << person.age << std::endl;

    Person person1 = {"Abhijeet", 29};

    std::cout << "Name: " << person1.name << std::endl;
    std::cout << "Age: " << person1.age << std::endl;

    Value val;

    val.i = 10;

    std::cout << "Value: " << val.i << std::endl;

    val.d = 20.5;

    std::cout << "Value: " << val.d << std::endl;

    val.c = 'A';

    std::cout << "Value: " << val.c << std::endl;

    Color color = RED;

    std::cout << "Color: " << color << std::endl;

    Flags flag;

    flag.flag1 = 1;
    flag.flag2 = 0;
    flag.flag3 = 1;

    std::cout << "Flag1: " << flag.flag1 << std::endl;
    std::cout << "Flag2: " << flag.flag2 << std::endl;
    std::cout << "Flag3: " << flag.flag3 << std::endl;

    return 0;
}