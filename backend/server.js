const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const OpenAI = require("openai");

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const SYSTEM_PROMPT = `
You are the ReLeaf AI assistant.
Your role is to help users with waste sorting, recycling guidance, and environmentally responsible disposal.

Rules:
- Keep answers clear and simple.
- Focus on waste categories such as plastic, paper, metal, glass, cardboard, and general disposal guidance.
- If the item is unclear, ask for more details.
- Be friendly and practical.
- Do not invent facts.
- If the user asks something unrelated to ReLeaf, politely redirect them to recycling or waste-sorting topics.
- Format answers using simple Markdown when helpful.
- Use **bold** for important labels or mini-headings.
- Use bullet points or numbered lists for steps.
- You may use simple suitable emojis like ♻️🌱✅ when helpful, but do not overuse them.
`;

app.get("/", (req, res) => {
  res.json({ message: "ReLeaf backend is running." });
});

app.post("/ask-ai", async (req, res) => {
  try {
    const { message } = req.body;

    if (!message || typeof message !== "string") {
      return res.status(400).json({
        error: "Invalid message.",
      });
    }

    const response = await client.responses.create({
      model: "gpt-4.1-mini",
      input: [
        {
          role: "system",
          content: SYSTEM_PROMPT,
        },
        {
          role: "user",
          content: message,
        },
      ],
    });

    return res.status(200).json({
      reply: response.output_text || "Sorry, I could not generate a response.",
    });
  } catch (error) {
    console.error("Error in /ask-ai:", error);
    return res.status(500).json({
      error: "Something went wrong while contacting the AI service.",
    });
  }
});

app.listen(port, "0.0.0.0", () => {
  console.log(`ReLeaf backend is running on http://0.0.0.0:${port}`);
});