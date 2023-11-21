const expect = @import("std").testing.expect;
const std = @import("std");
//if loop
//test "if statement expression" {
// const a = true;
//var x: u16 = 0;
//for this - test "if statement"
//if (a) {
//  x += 1;
//} else {
//  x += 2;
//}
// x += if (a) 1 else 2; //expression form
//  try expect(x == 1);
//}
//while loop
//test "while" {
//var i: u8 = 2;
//while (i < 100) {
//    i *= 2;
// }
//  try expect(i == 128);
//}
//while with  continue expression
//test "while with continue expression" {
//  var sum: u8 = 0;
//  var i: u8 = 1;
//  while (i <= 10) : (i += 1) {
//      sum += i;
//  }
// try expect(sum == 55);
//}
//continue keyword
//test "while with continue" {
//   var sum: u8 = 0;
//   var i: u8 = 0;
//   while (i <= 3) : (i += 1) {
//       if (i == 2) continue;
//       sum += i;
//   }
//   try expect(sum == 4);
//}
//test "while with break" {
//   var sum: u8 = 0;
//   var i: u8 = 0;
//   while (i <= 3) : (i += 1) {
//       if (i == 2) break;
//       sum += i;
//   }
//   try expect(sum == 1);
//}
//for loop
//test "for" {
//   const string = [_]u8{ 'a', 'b', 'c' };

//   for (string, 0..) |character, index| {
//       _ = character;
//       //Here, we’ve had to assign values to
//       //_, as Zig does not allow us to have unused values.
//       _ = index;
//   }
//   for (string) |character| {
//       _ = character;
//   }
//   for (string, 0..) |_, index| {
//       _ = index;
//  }
//   for (string) |_| {}
//}

//fn addFive(x: u32) u32 {
//  return x + 5;
//}

//test "function" {
//  const y = addFive(0);
//  try expect(@TypeOf(y) == u32);
//  try expect(y == 5);
//}

//fn fibonacci(n: u16) u16 {
//    if (n == 0 or n == 1) return n;
//    return fibonacci(n - 1) + fibonacci(n - 2);
//}

//test "function recursion" {
//    const x = fibonacci(10);
//    try expect(x == 55);
//}

// the defer keyword is used to schedule a
//function or block of code to be executed
//when the current scope is exited, regardless
//of the reason for the scope to be exited
//(such as normal execution, return, or panic).

test "defer" {
    var x: i16 = 5;
    { //<- define a block of code
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    try expect(x == 4.5);
}

//errors - it is like an enum, where each error
//in the set is a value
const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_err: AllocationError!u16 = 10;
    //Error type set combined with ! operator
    //to form an error union type.
    //Values of these types may be an error
    //value or a value of the other type.
    const no_err = maybe_err catch 0; //or noreturn;
    //0 is evaluated when the value before it is an
    //error

    try expect(@TypeOf(no_err) == u16);
    try expect(no_err == 10);
}

//functions often return error unions.
//in the below code we us catch where the |err|
//syntax gets the value of error. This is called
//payload capturing

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };
}
//short cut
fn failFn() error{Oops}!u32 {
    try failingFunction();
    return 12;
}

test "try" {
    var v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 12);
}

//errdefer works like defer, but executes the
//function is returned from with an error inside
//of the errdefer's block

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}
//we cab have error sets inferred by not having
//an explicit error set

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    //type coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    //Zig does not let us ignore error unions via _ = x;
    //we must unwrap it with "try", "catch",
    //or "if" by any means
    _ = x catch {};
}

//merging can happen
const A = error{ NotDir, PathNotFound };
const B = error{ OutOfMemory, PathNotFound };
const C = A || B;

//swtich
test "switch statement" {
    var x: i8 = 10;
    //switch (x) {
    //    -1...1 => {
    //        x = -x;
    //    },
    //    10, 100 => {
    //        x = @divExact(x, 10);
    //    },
    //    else => {},
    //}
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 1);
}
//runtime safety. Zig has many cases of so-called
//detectable illegal behaviour.

test "out of bounds" {
    //we may disable runtime safety for the current
    //block using built-in function
    @setRuntimeSafety(false);
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
}

//unreachable is an assertion to the compiler
//that this statement will not be reached.
//reaching an unreachable is detectable illegal behaviour

//test "unreachable" {
//    const x: i32 = 1;
//    const y: u32 = if (x == 2) 5 else unreachable;
//    _ = y;
//}

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}

//pointers
//Normal pointers in Zig cannot have 0 or null as a value
//They follow syntax *T, where T is child type.

fn increment(num: *u8) void {
    //num: *u8 -> here * is used to indicate that 'num' is a pointer type
    num.* += 1; //. -> zig syntax for the member access operator
    // It is used to access a member
    //or field of a struct, enum, or union.

    //* -> zig syntax for the pointer dereference operator
    //It is used to retrieve the value stored at the memory
    //address pointed to by a pointer.
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

//const pointers

test "const pointers" {
    const x: u8 = 1;
    var y = &x;
    _ = y;
}

//pointer sized integers - uszie and isize are
//given as unsigned and signed integers which are the
//same size as pointers

test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}

//many-item pointers

pub fn main() void { //pub stands for public function
    const runner = std.testing.createRunner();
    _ = try runner.run();
}
