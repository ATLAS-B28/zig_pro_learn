#include <iostream>
#include <memory>
#include <ostream>


class MyClass {
    public:
        MyClass() { std::cout << "Constructed" << std::endl; }
        ~MyClass() { std::cout << "MyClass destroyed" << std::endl; }

        void doSomething() {
            std::cout << "Doing something...." << std::endl;
        }
};

int main() {

    int x = 10;
    double y = 20.5;

    void* ptr4;//void pointer

    ptr4 = &x;

    std::cout << "Value of x: " << *((int*)ptr4) << std::endl;

    ptr4 = &y;

    std::cout << "Value of y: \n" << *((double*) ptr4) << std::endl;

    std::unique_ptr<MyClass> ptr(new MyClass());
    std::shared_ptr<MyClass> ptr1(new MyClass());
    std::weak_ptr<MyClass> ptr2(ptr1);
    

   ptr->doSomething();

   if(std::shared_ptr<MyClass> ptr3 = ptr2.lock()) {
    ptr3->doSomething();
    std::cout << "Object is still alive...." << std::endl;
   } else {
    std::cout << "Object has expired..." << std::endl;
   }
    

    //std::cout << "Object is still alive...." << std::endl;

    return 0;
}