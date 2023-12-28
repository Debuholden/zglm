const c = @import("c.zig");
const zglm = @import("zglm.zig");

pub const Vec4 = struct {
    _cglm_vec4: c.vec4 align(16),

    x: f32,
    y: f32,
    z: f32,
    w: f32,

    r: f32,
    g: f32,
    b: f32,
    a: f32,

    // Create a new Vec4 struct
    pub fn new(x: f32, y: f32, z: f32, w: f32) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ x, y, z, w };

        return Vec4{
            ._cglm_vec4 = cglm_vec4,

            .x = cglm_vec4[0],
            .y = cglm_vec4[1],
            .z = cglm_vec4[2],
            .w = cglm_vec4[3],

            .r = cglm_vec4[0],
            .g = cglm_vec4[1],
            .b = cglm_vec4[2],
            .a = cglm_vec4[3],
        };
    }

    // Creates a new Vec4 with all members set to 0.0 (zero)
    pub fn newZero() Vec4 {
        var cglm_vec4: c.vec3 align(16) = .{};

        c.glm_vec4_zero(cglm_vec4);

        return cglm_vec4;
    }

    // Creates a new Vec3 with all members set to 1.0 (one)
    pub fn newOne() Vec4 {
        var cglm_vec4: c.vec3 align(16) = .{};

        c.glm_vec4_one(cglm_vec4);

        return cglm_vec4;
    }

    // Return the first 3 members of [src] with [w] being initilized to 0
    pub fn copy3(src: zglm.Vec3) Vec4 {
        return @This().new(src.x, src.y, src.z, 0);
    }

    // Return all members of [src]
    pub fn copy(src: Vec4) Vec4 {
        return @This().new(src.x, src.y, src.z, src.w);
    }

    // Makes all members of [self] 0.0 (zero)
    pub fn zero(self: *Vec4) void {
        c.glm_vec4_zero(self._cglm_vec4);
        self.set();
    }

    // Makes all members of [self] 1.0 (one)
    pub fn one(self: *Vec4) void {
        c.glm_vec4_one(self._cglm_vec4);
        self.set();
    }

    // Returns dot product of [self]
    pub fn dot(self: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_dot(self._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns norm * norm (magnitude) of [self]

    // We can use this function instead of calling norm * norm, because it would call sqrtf function twice, but with this func we can avoid function call

    // Note: This may not be a good name for this function
    pub fn norm2(self: Vec4) f32 {
        return c.glm_vec4_norm2(self._cglm_vec4);
    }

    // Returns euclidean norm (magnitude), also called L2 norm

    // Note: This will give magnitude of vector in euclidean space
    pub fn norm(self: Vec4) f32 {
        return c.glm_vec4_norm(self._cglm_vec4);
    }

    // Returns [self] + [other]
    pub fn add(self: Vec4, other: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_add(self._cglm_vec4, other._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns = [self] + vec[scalar]
    pub fn adds(self: Vec4, scalar: f32) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_adds(self._cglm_vec4, scalar, cglm_vec4);

        return cglm_vec4;
    }

    // Returns [self] - [other]
    pub fn sub(self: Vec4, other: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_sub(self._cglm_vec4, other._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns  [self] - vec([scalar])
    pub fn subs(self: Vec4, scalar: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_subs(self._cglm_vec4, scalar, cglm_vec4);

        return cglm_vec4;
    }

    // Returns [self] * [other]
    // Note: Function uses component-wise multiplication
    pub fn mul(self: Vec4, other: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_mul(self._cglm_vec4, other._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns [self] * vec(scalar)
    pub fn scale(self: Vec4, scalar: f32) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_scale(self._cglm_vec4, scalar, cglm_vec4);

        return cglm_vec4;
    }

    // Returns unit([self]) * [scalar]
    pub fn scaleAs(self: Vec4, scalar: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_scale_as(self._cglm_vec4, scalar._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns [self] / [other]
    // Note: Function uses component-wise division
    pub fn div(self: Vec4, other: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_div(self._cglm_vec4, other._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Returns  [self] / vec([scalar])
    pub fn divs(self: Vec4, divider_scalar: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_divs(self._cglm_vec4, divider_scalar._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // DEPRECATED:
    // use zglm.Vec4.negate()
    pub fn flipSign(self: Vec4) void {
        c.glm_vec4_flipsign(self._cglm_vec4);
        self.set();
    }

    // DEPRECATED:
    // use zglm.Vec4.negate()
    pub fn inv(self: Vec4) void {
        c.glm_vec4_inv(self._cglm_vec4);
        self.set();
    }

    // Negate vector components
    pub fn negate(self: Vec4) void {
        c.glm_vec4_negate(self._cglm_vec4);
        self.set();
    }

    // Normalize [self]
    pub fn normalize(self: Vec4) void {
        c.glm_vec4_normalize(self._cglm_vec4);
        self.set();
    }

    // Returns squared distance between two vectors
    pub fn distance2(self: Vec4, between: Vec4) f32 {
        return c.glm_vec4_distance2(self._cglm_vec4, between._cglm_vec4);
    }

    // Returns distance between two vectors
    pub fn distance(self: Vec4, between: Vec4) f32 {
        return c.glm_vec4_distance(self._cglm_vec4, between._cglm_vec4);
    }

    // Maxes the values in [self] with [other]
    pub fn maxv(self: Vec4, other: Vec4) void {
        c.glm_vec4_maxv(self._cglm_vec4, other._cglm_vec4, self._cglm_vec4);
        self.set();
    }

    // Mins the values in [self] with [other]
    pub fn minv(self: Vec4, other: Vec4) void {
        c.glm_vec4_minv(self._cglm_vec4, other._cglm_vec4, self._cglm_vec4);
        self.set();
    }

    // Returns possible orthogonal/perpendicular vector of [self]
    pub fn ortho(self: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_ortho(self._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Constrain a value to lie between two further values
    pub fn clamp(self: Vec4, minVal: f32, maxVal: f32) void {
        c.glm_vec4_clamp(self._cglm_vec4, minVal, maxVal);
        self.set();
    }

    // Returns the linear interpolation between [self] and [other]
    pub fn lerp(self: Vec4, other: Vec4) Vec4 {
        var cglm_vec4: c.vec4 align(16) = .{ self.x, self.y, self.z };

        c.glm_vec4_lerp(self._cglm_vec4, other._cglm_vec4, cglm_vec4);

        return cglm_vec4;
    }

    // Set [self] as {[s^3], [s^2], [s], 1}
    pub fn cubic(self: Vec4, s: f32) Vec4 {
        c.glm_vec4_cubic(s, self._cglm_vec4);
        self.set();
    }

    fn set(self: *Vec4) void {
        self.x = self._cglm_vec4[0];
        self.y = self._cglm_vec4[1];
        self.z = self._cglm_vec4[2];
        self.w = self._cglm_vec4[3];

        self.r = self._cglm_vec4[0];
        self.g = self._cglm_vec4[1];
        self.b = self._cglm_vec4[2];
        self.a = self._cglm_vec4[3];
    }
};
