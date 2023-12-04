import mongoose from "mongoose";

export async function connect() {
  try {
    await mongoose.connect(
      "mongodb+srv://buichau40:wO03htT4joGWg7oy@tomapp.vhpn4hm.mongodb.net/AppTom"
    );
    console.log("DB connected okiii!!");
  } catch (error) {
    console.log("DB connect fail !!");
  }
}
