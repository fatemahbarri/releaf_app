const { onCall, HttpsError } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const OpenAI = require("openai");

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

exports.askAi = onCall(
  {
    region: "us-central1",
    timeoutSeconds: 60,
    memory: "256MiB",
  },
  async (request) => {
    try {
      const message = request.data?.message?.trim();

      if (!message) {
        throw new HttpsError("invalid-argument", "Message is required.");
      }

      const systemPrompt = `
You are the ReLeaf AI assistant.
Your role is to help users with waste sorting, recycling guidance, and environmentally responsible disposal.

Rules:
- Keep answers clear and simple.
- Focus on waste categories such as plastic, paper, metal, glass, cardboard, and general disposal guidance.
- If the item is unclear, ask for more details.
- Be friendly and practical.
- Do not invent facts.
- If the user asks something unrelated to ReLeaf, politely redirect them to recycling or waste-sorting topics.
      `.trim();

      const response = await openai.responses.create({
        model: "gpt-5.4",
        input: [
          {
            role: "system",
            content: systemPrompt,
          },
          {
            role: "user",
            content: message,
          },
        ],
      });

      return {
        reply: response.output_text || "Sorry, I could not generate a reply.",
      };
    } catch (error) {
      logger.error("askAi failed", error);

      if (error instanceof HttpsError) {
        throw error;
      }

      throw new HttpsError("internal", "Failed to get AI response.");
    }
  }
);