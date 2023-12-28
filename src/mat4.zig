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

    // Creates a new identity mat4
    pub fn newIdentity() Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_mat4_identity(cglm_mat4);

        return cglm_mat4;
    }

    // Creates a new mat4 with all vales initilized to 0.0 (zero)
    pub fn newZero() Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_mat4_zero(cglm_mat4);

        return cglm_mat4;
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
    pub fn scaleP(self: Mat4, scalar: f32) void {
        c.glm_mat4_scale_p(self._cglm_mat4, scalar);
        self.set();
    }

    // Scale [self] with [scalar] without simd optimizations
    // NOTE: This is not a scale transform, use zglm.Mat4.scale for that.
    pub fn scaleScalar(self: Mat4, scalar: f32) void {
        c.glm_mat4_scale(self._cglm_mat4, scalar);
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

    // *** 3D Affine transformations *** \\

    // Translate [self] transform matrix by [other]
    pub fn translate(self: Mat4, other: zglm.Vec3) void {
        c.glm_translate(self._cglm_mat4, other._cglm_vec3);
        self.set();
    }

    // Translate [self] transform matrix by [x] factor
    pub fn translateX(self: Mat4, x: f32) void {
        c.glm_translate_x(self._cglm_mat4, x);
        self.set();
    }

    // Translate [self] transform matrix by [y] factor
    pub fn translateY(self: Mat4, y: f32) void {
        c.glm_translate_y(self._cglm_mat4, y);
        self.set();
    }

    // Translate [self] transform matrix by [z] factor
    pub fn translateZ(self: Mat4, z: f32) void {
        c.glm_translate_z(self._cglm_mat4, z);
        self.set();
    }

    // Creates a new translate transform matrix by [other]
    pub fn newTranslate(other: zglm.Vec3) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_translate_make(cglm_mat4, other);

        return cglm_mat4;
    }

    // Creates a new scale matrix by [other]
    pub fn newScale(other: zglm.Vec3) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_mat4_make(cglm_mat4, other);

        return cglm_mat4;
    }

    // Scale [self] transform matrix by [vec3]
    pub fn scale(self: Mat4, vec3: zglm.Vec3) void {
        c.glm_scale(self._cglm_mat4, vec3._cglm_vec3);
        self.set();
    }

    // Scale [self] transform matrix by [scalar]
    pub fn scaleUni(self: Mat4, scalar: f32) void {
        c.glm_scale_uni(self._cglm_mat4, scalar);
        self.set();
    }

    // Rotate transform of [self] around X axis by [angle]
    pub fn rotateX(self: Mat4, angle: f32) void {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_rotate_x(self._cglm_mat4, angle, cglm_mat4);

        return cglm_mat4;
    }

    // Rotate transform of [self] around Y axis by [angle]
    pub fn rotateY(self: Mat4, angle: f32) void {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_rotate_y(self._cglm_mat4, angle, cglm_mat4);

        return cglm_mat4;
    }

    // Rotate transform of [self] around Z axis by [angle]
    pub fn rotateZ(self: Mat4, angle: f32) void {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_rotate_z(self._cglm_mat4, angle, cglm_mat4);

        return cglm_mat4;
    }

    // Creates a new rotation matrix by angle and axis
    // NOTE: Axis will be normalized
    pub fn newRotate(angle: f32, axis: zglm.Vec3) Mat4 {
        var cglm_mat4: c.mat4 align(32) = .{};

        c.glm_rotate_make(cglm_mat4, angle, axis);

        return cglm_mat4;
    }

    // Rotate transform of [self] around Z axis by [angle] and [axis]
    pub fn rotate(self: Mat4, angle: f32, axis: zglm.Vec3) void {
        c.glm_rotate(self._cglm_mat4, angle, axis._cglm_vec3);
        self.set();
    }

    // Rotate existing transform around given axis
    // by angle at given pivot point (rotation center)
    pub fn rotateAtm(self: Mat4, pivot: zglm.Vec3, angle: f32, axis: zglm.Vec3) void {
        c.glm_rotate_atm(self._cglm_mat4, pivot._cglm_vec3, angle, axis._cglm_vec3);
        self.set();
    }

    // Decompose [p_scale]
    pub fn decomposeScalev(self: Mat4, p_scale: zglm.Vec3) void {
        c.glm_decompose_scalev(self._cglm_mat4, p_scale._cglm_vec3);
        self.set();
    }

    // Returns true if [self] is uniform scaled
    pub fn uniscaled(self: Mat4) bool {
        return c.glm_uniscaled(self._cglm_mat4);
    }

    // Decompose rotation [self] and [p_scale] [Sx, Sy, Sz]
    // NOTE:  Don't pass a projected matrix here
    pub fn decomposeRs(self: Mat4, rotation: Mat4, p_scale: zglm.Vec3) void {
        c.glm_decompose_rs(self._cglm_mat4, rotation._cglm_mat4, p_scale._cglm_vec3);
        self.set();
    }

    // Decompose affine transform
    // NOTE: Don't pass projected matrix here
    pub fn decompose(self: Mat4, translation: zglm.Vec4, rotation: Mat4, p_scale: zglm.Vec3) void {
        c.glm_decompose(self._cglm_mat4, translation._cglm_vec4, rotation._cglm_mat4, p_scale._cglm_vec3);
        self.set();
    }

    // TODO: Post functions

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
