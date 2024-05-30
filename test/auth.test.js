const request = require("supertest");
const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const bcryptjs = require("bcryptjs");
const User = require("../models/users");
require("dotenv").config();

const app = require("../server");

describe("Auth API", () => {
  beforeAll(async () => {
    const DB = process.env.DATABASE_URL;
    if (!DB) {
      throw new Error("DATABASE_URL is not defined");
    }
    await mongoose.connect(DB);
  }, 30000);

  afterAll(async () => {
    await mongoose.connection.close();
  });

  beforeEach(async () => {
    await User.deleteMany({ name: "Test User" });
  }, 30000);

  describe("POST /api/register", () => {
    it("should register a new user", async () => {
      const res = await request(app).post("/api/register").send({
        name: "Test User",
        email: "test@example.com",
        password: "password",
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });

      expect(res.statusCode).toBe(200);
      expect(res.body).toHaveProperty("email", "test@example.com");
    }, 300000);

    it("should not register user with existing email", async () => {
      await new User({
        name: "Test User",
        email: "test@example.com",
        password: await bcryptjs.hash("password", 8),
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      }).save();

      const res = await request(app).post("/api/register").send({
        name: "Test User",
        email: "test@example.com",
        password: "password",
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });

      expect(res.statusCode).toBe(400);
      expect(res.body).toHaveProperty(
        "msg",
        "User with same email already exists!"
      );
    });
  });

  describe("POST /api/login", () => {
    it("should login a registered user", async () => {
      const user = new User({
        name: "Test User",
        email: "test@example.com",
        password: await bcryptjs.hash("password", 8),
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });
      await user.save();

      const res = await request(app).post("/api/login").send({
        email: "test@example.com",
        password: "password",
        familyCode: "12345",
      });

      expect(res.statusCode).toBe(200);
      expect(res.body).toHaveProperty("token");
    });

    it("should not login user with incorrect password", async () => {
      const user = new User({
        name: "Test User",
        email: "test@example.com",
        password: await bcryptjs.hash("password", 8),
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });
      await user.save();

      const res = await request(app).post("/api/login").send({
        email: "test@example.com",
        password: "wrongpassword",
        familyCode: "12345",
      });

      expect(res.statusCode).toBe(400);
      expect(res.body).toHaveProperty("msg", "Incorrect password!!");
    });
  });

  describe("POST /tokenIsValid", () => {
    it("should validate a token", async () => {
      const user = new User({
        name: "Test User",
        email: "test@example.com",
        password: await bcryptjs.hash("password", 8),
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });
      await user.save();

      const token = jwt.sign({ id: user._id }, "passwordKey");

      const res = await request(app)
        .post("/tokenIsValid")
        .set("x-auth-token", token);

      expect(res.statusCode).toBe(200);
      expect(res.body).toBe(true);
    });

    it("should invalidate a wrong token", async () => {
      const res = await request(app)
        .post("/tokenIsValid")
        .set("x-auth-token", "wrongtoken");

      expect(res.statusCode).toBe(200);
      expect(res.body).toBe(false);
    });

    it("should invalidate a missing token", async () => {
      const res = await request(app).post("/tokenIsValid");

      expect(res.statusCode).toBe(200);
      expect(res.body).toBe(false);
    });
  });

  describe("GET /", () => {
    it("should get user data with valid token", async () => {
      const user = new User({
        name: "Test User",
        email: "test@example.com",
        password: await bcryptjs.hash("password", 8),
        familyCode: "12345",
        type: "watcher",
        watcherId: new mongoose.Types.ObjectId(),
        age: "30",
      });
      await user.save();

      const token = jwt.sign({ id: user._id }, "passwordKey");

      const res = await request(app).get("/").set("x-auth-token", token);

      expect(res.statusCode).toBe(200);
      expect(res.body).toHaveProperty("email", "test@example.com");
      expect(res.body).toHaveProperty("token", token);
    });

    it("should not get user data with invalid token", async () => {
      const res = await request(app).get("/").set("x-auth-token", "wrongtoken");

      expect(res.statusCode).toBe(500);
      expect(res.body).toHaveProperty("error");
    });

    it("should not get user data without token", async () => {
      const res = await request(app).get("/");

      expect(res.statusCode).toBe(401);
    });
  });
});
