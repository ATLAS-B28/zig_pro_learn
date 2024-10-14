#include <iostream>
#include <string>

//template classes
template<typename T>
class Stack {
    private:
       int top;
       T* elements;
    
    public:
        Stack(int size) {
            top = -1;
            elements = new T[size];
        }

        ~Stack() {
            delete[] elements;
        }

        void push(T val) {
            elements[++top] = val;
        }

        T pop() {
            return elements[top--];
        }
};

int main() {
    Stack<int> intstack(9);

    intstack.push(10);
    intstack.push(20);
    intstack.push(30);

    int res1 = intstack.pop();
    int res2 = intstack.pop();
    int res3 = intstack.pop();

    std::cout << "Result1: " << res1 << std::endl;
    std::cout << "Result2: " << res2 << std::endl;
    std::cout << "result3: " << res3 << std::endl;

    Stack<std::string> stringStack(3);

    stringStack.push("Aditya");
    stringStack.push("Bhambere");

    std::string res4 = stringStack.pop();
    std::string res5 = stringStack.pop();

    std::cout << "Result4: " << res4 << std::endl;
    std::cout << "Result5: " << res5 << std::endl;

    return 0;
}