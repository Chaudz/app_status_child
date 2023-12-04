import { Request, Response } from "express";

class HomeController {
  async renderHomeScreen(req: Request, res: Response) {
    try {
      res.json("homepage");
    } catch (error) {
      res.status(500).json({ message: "Lỗi nội bộ máy chủ" });
    }
  }
}

export default new HomeController();
