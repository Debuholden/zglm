const c = @import("c.zig");
const zglm = @import("zglm.zig");

pub const Mat4 = struct {
    _cglm_mat4: c.mat4 align(32),

    x: zglm.Vec4,
    y: zglm.Vec4,
    z: zglm.Vec4,
    w: zglm.Vec4,

    r: zglm.Vec4,
    g: zglm.Vec4,
    b: zglm.Vec4,
    a: zglm.Vec4,

    // Create a new Mat4 struct
    pub fn new(x: zglm.Vec4, y: zglm.Vec4, z: zglm.Vec4, w: zglm.Vec4) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{ x, y, z, w };

        return Mat4{
            ._cglm_mat4 = cglm_mat4,

            .x = cglm_mat4[0],
            .y = cglm_mat4[1],
            .z = cglm_mat4[2],
            .w = cglm_mat4[3],

            .r = cglm_mat4[0],
            .g = cglm_mat4[1],
            .b = cglm_mat4[2],
            .a = cglm_mat4[3],
        };
    }

    // Return all members of [src]
    pub fn copy(src: Mat4) Mat4 {
        return @This().new(src.x, src.y, src.z, src.w);
    }

    // Copy identity mat4 to [self], or makes [self] identity mat4
    pub fn identity(self: *Mat4) void {
        c.glm_mat4_identity(self._cglm_mat4);
        self.set();
    }

    // Makes all members of [self] 0.0 (zero)
    pub fn zero(self: *Mat4) void {
        c.glm_mat4_zero(self._cglm_mat4);
        self.set();
    }

    // TODO: Make Mat3
    // pub fn pick3(self: Mat4) zglm.Mat3 {
    //     var cglm_mat3: c.mat3 align(32) = .{};

    //     c.glm_mat4_pick3(self._cglm_mat4, cglm_mat3);

    //     return cglm_mat3;
    // }

    // TODO: Make Mat3
    // pub fn pick3t(self: Mat4) zglm.Mat3 {
    //     var cglm_mat3: c.mat3 align(32) = .{};

    //     c.glm_mat4_pick3t(self._cglm_mat4, cglm_mat3);

    //     return cglm_mat3;
    // }

    // TODO: Make Mat3
    // pub fn ins3(self: Mat4) zglm.Mat3 {
    //     var cglm_mat3: c.mat3 align(32) = .{};

    //     c.glm_mat4_ins3(cglm_mat3, self._cglm_mat4);

    //     return cglm_mat3;
    // }

    // Returns [self] * [other]
    pub fn mul(self: Mat4, other: Mat4) Mat4 {
        var cglm_mat4: c.vec4 align(32) = .{};

        c.glm_mat4_mul(self._cglm_mat4, other._cglm_mat4, cglm_mat4);

        return cglm_mat4;
    }

    // Returns [self] * [other]
    pub fn mulv(self: Mat4, other: zglm.Vec4) Mat4 {
        var cglm_mat4: c.vec4 align(32) = .{};

        c.glm_mat4_mulv(self._cglm_mat4, other._cglm_vec4, cglm_mat4);

        return cglm_mat4;
    }

    // Returns the sum of the elements on the main diagonal of
    // [self] from upper left to the lower right
    pub fn trace(self: Mat4) f32 {
        return c.glm_mat4_trace(self._cglm_mat4);
    }

    // Returns the sum of the elements on the rotation part of
    // the main diagonal of [self] from upper left to the lower right
    pub fn trace3(self: Mat4) f32 {
        return c.glm_mat4_trace3(self._cglm_mat4);
    }

    // Returns the rotational part of
    // [self] converted to a quaternion
    pub fn quat(self: Mat4) c.versor {
        var cglm_vec4: c.vec4 align(16) = .{};

        c.glm_mat4_quat(self._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Scale [self] with [scalar] without simd optimizations
    pub fn scaleScalarP(self: Mat4, scalar: f32) void {
        c.glm_mat4_scale_p(self._cglm_mat4, scalar);
        self.set();
    }

    // Scale [self] with [scalar] without simd optimizations
    // NOTE: This is not a scale transform, use zglm.Mat4.scale for that.
    pub fn scaleScalar(self: Mat4, scalar: f32) void {
        c.glm_mat4_scale(self._cglm_mat4, scalar);
        self.set();
    }

    // Scale [self] with [scalar]
    pub fn scale(self: Mat4, scalar: zglm.Vec3) void {
        c.glm_scale(self._cglm_mat4, scalar);
        self.set();
    }

    // Transpose a matrix
    pub fn transpose(self: Mat4) void {
        c.glm_mat4_transpose(self._cglm_mat4);
        self.set();
    }

    // Returns the determinant of [self]
    pub fn determinate(self: Mat4) void {
        return c.glm_mat4_det(self._cglm_mat4);
    }

    // Returns the inverse of [self]
    pub fn inv(self: Mat4) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_mat4_inv(self._cglm_mat4, cglm_mat4);

        return cglm_mat4;
    }

    // Returns the inverse of [self] with
    // reciprocal approximation and without extra corrections

    // NOTE: You will lose precision, zglm.Mat4.inv is more accurate
    // Returns the inverse of [self]
    pub fn invFast(self: Mat4) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_mat4_inv_fast(self._cglm_mat4, cglm_mat4);

        return cglm_mat4;
    }

    // Swap 2 matrix columns
    pub fn swapCol(self: Mat4, col1: i32, col2: i32) void {
        c.glm_mat4_swap_col(self._cglm_mat4, col1, col2);
        self.set();
    }

    // Swap 2 matrix rows
    pub fn swapRow(self: Mat4, row1: i32, row2: i32) void {
        c.glm_mat4_swap_row(self._cglm_mat4, row1, row2);
        self.set();
    }

    // Helper for [row] * [self] * [col]
    pub fn rmc(self: Mat4, row: zglm.Vec4, col: zglm.Vec4) f32 {
        return c.glm_mat4_rmc(row._cglm_vec4, self._cglm_mat4, col._cglm_vec4);
    }

    fn set(self: Mat4) void {
        self.x._cglm_vec4 = self._cglm_mat4[0];
        self.y._cglm_vec4 = self._cglm_mat4[1];
        self.z._cglm_vec4 = self._cglm_mat4[2];
        self.w._cglm_vec4 = self._cglm_mat4[3];

        self.r._cglm_vec4 = self._cglm_mat4[0];
        self.g._cglm_vec4 = self._cglm_mat4[1];
        self.b._cglm_vec4 = self._cglm_mat4[2];
        self.a._cglm_vec4 = self._cglm_mat4[3];
    }
};
