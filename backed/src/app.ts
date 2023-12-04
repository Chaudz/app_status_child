import express from "express";
import path from "path";
import bodyParser from "body-parser";
import { connect } from "./config/connect_db";
import indexRouter from "./router/index";

const app = express();

console.log(path.join(__dirname, "public"));
// connect db
connect();

// use static file
app.use(express.static(path.join(__dirname, "public")));

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

// create application/json parser
app.use(bodyParser.json());

// create application/x-www-form-urlencoded parser
app.use(bodyParser.urlencoded({ extended: false }));

//config router
app.use("/", indexRouter);

app.listen(3000, () => {
  console.log("server is running http://localhost:3000/");
});
