import { Schema, Types, model } from "mongoose";
import { IsEmail } from "class-validator";

export interface IUser {
  UserId: Types.ObjectId;
  Email: string;
  Pass: string;
  Token: string;
}

const userSchema = new Schema<IUser>({
  UserId: { type: Schema.Types.ObjectId },
  Email: {
    type: String,
    required: true,
    validate: [IsEmail(), "Invalid email"],
  },
  Pass: { type: String, required: true, minlength: 5, match: /^\S+$/ },
  Token: { type: String },
});

const User = model<IUser>("Users", userSchema);

export default User;
