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
    const glm_files = &[_][]const u8{
        "./lib/cglm/src/affine.c",
    };
    lib.addIncludePath(.{ .path = "./lib/cglm/include" });
    lib.addCSourceFiles(glm_files, &.{});
    lib.linkLibC();

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    main_tests.addIncludePath(.{ .path = "./lib/cglm/include" });
    main_tests.addCSourceFiles(glm_files, &.{});
    main_tests.linkLibC();

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
