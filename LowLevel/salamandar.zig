const std = @import("std");

pub fn main() !void {
    const x: u32 = 42;
    var y: i32 = -40;
    std.debug.print("The value of x is {}\n", .{x});
    std.debug.print("The value of y is {}\n", .{y});
    y = 43;
    std.debug.print("The value of y as updated is {}\n", .{y});

    const arr: [3]u32 = [_]u32{ 1, 2, 3 };
    std.debug.print("Element at index 2: {d}\n", .{arr[2]}); //d - decimal integer
    std.debug.print("Element at index 2: {x}\n", .{arr[2]}); //x - hexadecimal
    std.debug.print("Element at index 2: {b}\n", .{arr[2]}); //x - binary
    std.debug.print("Element at index 2: {o}\n", .{arr[2]}); //o - octal

}
