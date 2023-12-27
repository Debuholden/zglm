const std = @import("std");
const testing = std.testing;

const zglm = @import("zglm.zig");

// TODO: Tests
test "vec3" {
    _ = zglm.Vec3.new(0, 1, 2);
}
