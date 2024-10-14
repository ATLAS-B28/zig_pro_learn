const std = @import("std");

pub fn main() void {
    //(const|var) identifier[: type] = value
    const constant: i32 = 5;
    //inferred type of the value
    const constant1 = @as(i32, 5);
    //we also have var for mutable values
    var variable = @as(u32, 5000);
    std.debug.print("Hello, {s}!\n", .{"World"});
    std.debug.print("Signed 32-bit constant - {}\n", .{constant});
    std.debug.print("Signed 32-bit constant as inferred type with @as() - {}\n", .{constant1});
    std.debug.print("Unsigned 32-bit variable as inferred type with @as() - {}\n", .{variable});

    //array
    //const arrName = [N|_]T{1,2}
    //N - no. of elements
    //_ - For array literals, N may be replaced by _ to infer the size of the array.
    //const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    const length = a.len;
    std.debug.print("Array of size {} is-\n", .{length});
    std.debug.print("{s}\n", .{a});

    //many-item pointers
    //arrays is represented as many-pointers
    //to their first element
    var orders: [18]u8 = [18]u8{
        'T', 'a', 'k', 'e', ' ', 'o', 'f', 'f', ' ', 'e', 'v', 'e', 'r',
        'y', ' ', 'z', 'i', 'g',
    };
    var order_ptr: *[18]u8 = &orders;
    //var var_name: *[size]type = &original_arr
    std.debug.print("{s}", .{order_ptr.*});
}
