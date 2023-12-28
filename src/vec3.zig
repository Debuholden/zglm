const c = @import("c.zig");
const zglm = @import("zglm.zig");

pub const Vec3 = struct {
    _cglm_vec3: c.vec3 align(16),

    x: f32,
    y: f32,
    z: f32,

    r: f32,
    g: f32,
    b: f32,

    // Create a new Vec3 struct
    pub fn new(x: f32, y: f32, z: f32) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ x, y, z };

        return Vec3{
            ._cglm_vec3 = cglm_vec3,

            .x = cglm_vec3[0],
            .y = cglm_vec3[1],
            .z = cglm_vec3[2],

            .r = cglm_vec3[0],
            .g = cglm_vec3[1],
            .b = cglm_vec3[2],
        };
    }

    // Creates a new Vec3 with all members set to 0.0 (zero)
    pub fn newZero() Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{};

        c.glm_vec3_zero(cglm_vec3);

        return cglm_vec3;
    }

    // Creates a new Vec3 with all members set to 1.0 (one)
    pub fn newOne() Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{};

        c.glm_vec3_one(cglm_vec3);

        return cglm_vec3;
    }

    // TODO: Document
    pub fn copyVec4(src: zglm.Vec4) Vec3 {
        return @This().new(src.x, src.y, src.z);
    }

    // Return all members of [src]
    pub fn copy(src: Vec3) Vec3 {
        return @This().new(src.x, src.y, src.z);
    }

    // Makes all members of [self] 0.0 (zero)
    pub fn zero(self: *Vec3) void {
        c.glm_vec3_zero(self._cglm_vec3);
        self.set();
    }

    // Makes all members of [self] 1.0 (one)
    pub fn one(self: *Vec3) void {
        c.glm_vec3_one(self._cglm_vec3);
        self.set();
    }

    // Returns dot product of [self]
    pub fn dot(self: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_dot(self._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns cross product of [self] and [other] (RH)
    pub fn cross(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_cross(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns cross product of [self] and [other] (RH) normalized
    pub fn crossn(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_crossn(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns norm * norm (magnitude) of [self]

    // We can use this function instead of calling norm * norm, because it would call sqrtf function twice, but with this func we can avoid function call

    // Note: This may not be a good name for this function
    pub fn norm2(self: Vec3) f32 {
        return c.glm_vec3_norm2(self._cglm_vec3);
    }

    // Returns euclidean norm (magnitude), also called L2 norm

    // Note: This will give magnitude of vector in euclidean space
    pub fn norm(self: Vec3) f32 {
        return c.glm_vec3_norm(self._cglm_vec3);
    }

    // Returns [self] + [other]
    pub fn add(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_add(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns = [self] + vec[scalar]
    pub fn adds(self: Vec3, scalar: f32) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_adds(self._cglm_vec3, scalar, cglm_vec3);

        return cglm_vec3;
    }

    // Returns [self] - [other]
    pub fn sub(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_sub(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns  [self] - vec([scalar])
    pub fn subs(self: Vec3, scalar: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_subs(self._cglm_vec3, scalar, cglm_vec3);

        return cglm_vec3;
    }

    // Returns [self] * [other]
    // Note: Function uses component-wise multiplication
    pub fn mul(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_mul(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns [self] * vec(scalar)
    pub fn scale(self: Vec3, scalar: f32) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_scale(self._cglm_vec3, scalar, cglm_vec3);

        return cglm_vec3;
    }

    // Returns unit([self]) * [scalar]
    pub fn scaleAs(self: Vec3, scalar: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_scale_as(self._cglm_vec3, scalar._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns [self] / [other]
    // Note: Function uses component-wise division
    pub fn div(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_div(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns  [self] / vec([scalar])
    pub fn divs(self: Vec3, divider_scalar: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_divs(self._cglm_vec3, divider_scalar._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // DEPRECATED:
    // use zglm.Vec3.negate()
    pub fn flipSign(self: Vec3) void {
        c.glm_vec3_flipsign(self._cglm_vec3);
        self.set();
    }

    // DEPRECATED:
    // use zglm.Vec3.negate()
    pub fn inv(self: Vec3) void {
        c.glm_vec3_inv(self._cglm_vec3);
        self.set();
    }

    // Negate vector components
    pub fn negate(self: Vec3) void {
        c.glm_vec3_negate(self._cglm_vec3);
        self.set();
    }

    // Normalize [self]
    pub fn normalize(self: Vec3) void {
        c.glm_vec3_normalize(self._cglm_vec3);
        self.set();
    }

    // Returns the angle between [self] and [other] in radians
    pub fn angle(self: Vec3, other: Vec3) f32 {
        return c.glm_vec3_angle(self._cglm_vec3, other._cglm_vec3);
    }

    // Rotate [self] around [axis] by [rotation_angle] using Rodrigues’ rotation formula
    pub fn rotate(self: Vec3, rotation_angle: f32, axis: Vec3) void {
        c.glm_vec3_rotate(self._cglm_vec3, rotation_angle, axis._cglm_vec3);
        self.set();
    }

    // Project [other] onto [self]
    pub fn proj(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_proj(other._cglm_vec3, self._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Find the center point between [self] and [other]
    pub fn center(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_proj(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Returns squared distance between two vectors
    pub fn distance2(self: Vec3, between: Vec3) f32 {
        return c.glm_vec3_distance2(self._cglm_vec3, between._cglm_vec3);
    }

    // Returns distance between two vectors
    pub fn distance(self: Vec3, between: Vec3) f32 {
        return c.glm_vec3_distance(self._cglm_vec3, between._cglm_vec3);
    }

    // Maxes the values in [self] with [other]
    pub fn maxv(self: Vec3, other: Vec3) void {
        c.glm_vec3_maxv(self._cglm_vec3, other._cglm_vec3, self._cglm_vec3);
        self.set();
    }

    // Mins the values in [self] with [other]
    pub fn minv(self: Vec3, other: Vec3) void {
        c.glm_vec3_minv(self._cglm_vec3, other._cglm_vec3, self._cglm_vec3);
        self.set();
    }

    // Returns possible orthogonal/perpendicular vector of [self]
    pub fn ortho(self: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_ortho(self._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // Constrain a value to lie between two further values
    pub fn clamp(self: Vec3, minVal: f32, maxVal: f32) void {
        c.glm_vec3_clamp(self._cglm_vec3, minVal, maxVal);
        self.set();
    }

    // Returns the linear interpolation between [self] and [other]
    pub fn lerp(self: Vec3, other: Vec3) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec3_lerp(self._cglm_vec3, other._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    // From `mat4`

    // Returns [self] * [other]
    pub fn mulv(self: Vec3, other: zglm.Mat4) Vec3 {
        var cglm_vec3: c.vec3 align(16) = .{};

        c.glm_mat4_mulv3(other._cglm_mat4, self._cglm_vec3, cglm_vec3);

        return cglm_vec3;
    }

    fn set(self: *Vec3) void {
        self.x = self._cglm_vec3[0];
        self.y = self._cglm_vec3[1];
        self.z = self._cglm_vec3[2];

        self.r = self._cglm_vec3[0];
        self.g = self._cglm_vec3[1];
        self.b = self._cglm_vec3[2];
    }
};
