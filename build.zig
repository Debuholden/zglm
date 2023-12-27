const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const lib = b.addStaticLibrary(.{
        .name = "zglm",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    // CGLM
    lib.addIncludePath(.{ .path = "./lib/cglm/include" });
    const glm_files = &[_][]const u8{
        "./lib/cglm/src/affine.c",
        "./lib/cglm/src/vec4.c",
        "./lib/cglm/src/mat4.c",
    };
    lib.addCSourceFiles(glm_files, &.{});

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
