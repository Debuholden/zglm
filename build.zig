const std = @import("std");
const CompileStep = std.build.CompileStep;
const CrossTarget = std.zig.CrossTarget;
const Mode = std.builtin.Mode;

pub fn build(b: *std.Build, target: CrossTarget, optimize: Mode, comptime path_prefix: []const u8) *CompileStep {
    const lib = b.addStaticLibrary(.{
        .name = "zglm",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    // CGLM
    const glm_files = &[_][]const u8{
        path_prefix ++ "/lib/cglm/src/affine.c",
    };
    lib.addIncludePath(.{ .path = path_prefix ++ "/lib/cglm/include" });
    lib.addCSourceFiles(glm_files, &.{});
    lib.linkLibC();

    // Tests
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/tests.zig" },
        .target = target,
        .optimize = optimize,
    });

    main_tests.addIncludePath(.{ .path = path_prefix ++ "/lib/cglm/include" });
    main_tests.addCSourceFiles(glm_files, &.{});
    main_tests.linkLibC();

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);

    return lib;
}
