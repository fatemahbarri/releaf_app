<p align="center">
  <img src="ReLeaf_logo.png" width="300">
</p>
<h1 align="center">🌱 ReLeaf: Smart Waste Sorting System</h1>
<p align="center"><b>ReLeaf is a mobile application designed to help users classify waste items and promote proper recycling habits. Using image classification, gamification features, bilingual support, dark mode, and an AI-powered assistant, the system guides users in identifying waste types and locating nearby recycling bins.</b></p>
<p align="center">♻️ Turning waste into awareness.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Frontend-blue">
  <img src="https://img.shields.io/badge/Firebase-Database-orange">
  <img src="https://img.shields.io/badge/TensorFlowLite-ML-green">
  <img src="https://img.shields.io/badge/OpenAI-LLM-purple">
</p>

---

## 🎯 Project Goal

To develop an intelligent, user-friendly system that enhances recycling awareness and supports proper waste management using AI technologies.

---

## 🚀 Features

* 📷 Image-based waste classification (Plastic, Glass, Metal, Paper, Cardboard, Trash)
* 🤖 AI-powered assistant for recycling guidance
* 📍 Bin location finder using map interfaces
* 📝 Report issues feature for user feedback
* 🌍 Arabic & English language support for accessibility
* 🌙 Dark mode support for a more comfortable user experience
* 🎮 Gamification system with rewards and progress tracking to encourage recycling habits
* 🔔 Simple and user-friendly interface for all users

---

## 🛠️ Technologies Used

| Component        | Technology                    |
| ---------------- | ----------------------------- |
| Frontend         | Flutter                       |
| Backend          | Node.js (Express)             |
| Database         | Firebase Firestore            |
| Authentication   | Firebase Auth                 |
| Machine Learning | TensorFlow Lite (MobileNetV2) |
| AI Assistant     | OpenAI API                    |

---

## 📊 Dataset & Preparation

* Two datasets were used:

  * TrashNet dataset: https://github.com/garythung/trashnet
  * Garbage Classification dataset: https://www.kaggle.com/datasets/mostafaabla/garbage-classification

* After merging and cleaning:

  * Total images: **6434 images**
  * Classes:

    * Cardboard
    * Glass
    * Metal
    * Paper
    * Plastic
    * Trash

* Data was cleaned and duplicate images were removed to improve quality 

---

## 🧠 Model & Training

* **Model:** MobileNetV2 (Transfer Learning)
* **Input Size:** 224 × 224
* **Optimizer:** Adam
* **Batch Size:** 32

### Training Strategy:

* Initial training with frozen layers
* Fine-tuning last layers of the model
* Learning rate reduced during fine-tuning

### Data Split:

* Training: 80%
* Validation: 10%
* Testing: 10% 

---

## 📈 Results

* **Training Accuracy:** 96.48%
* **Validation Accuracy:** 92.69%
* **Test Accuracy:** 92.41% 

### Performance Insights:

* Best class: **Paper (F1 ≈ 0.95)**
* Most confusion between:

  * Plastic & Glass
  * Plastic & Trash

Overall, the model achieved strong performance across all classes with minimal misclassification.

---

## 🤖 AI Assistant (LLM Integration)

Three approaches were tested:

* **Ollama (Local LLM)** → simple but limited
* **LM Studio (Local + Backend)** → more control but slower
* **OpenAI API (Cloud)** → best performance

### ✅ Final Choice:

* OpenAI API (gpt-4.1-mini)

### Why?

* Faster responses
* Higher accuracy
* Better context understanding
* More reliable performance

---

## 📱 App Screenshots

### 🏠 Welcome & Authentication

<p align="center">
  <img src="assets/images/Welcome.png" width="250">
  <img src="assets/images/sign up, login,password.png" width="250">
</p>

<p align="center">
  <img src="assets/images/sign up, login,password2.png" width="250">
  <img src="assets/images/Home.png" width="250">
</p>

> Users can create accounts, securely log in, and access a clean and user-friendly home interface.

---

### ♻️ Waste Classification & AI Assistant

<p align="center">
  <img src="assets/images/Classification.png" width="250">
  <img src="assets/images/LLM.png" width="250">
</p>

> ReLeaf uses AI-powered image classification and an intelligent assistant to help users identify waste types and learn proper recycling practices.

---

### 📍 Recycling Bin Navigation

<p align="center">
  <img src="assets/images/Bins1.png" width="250">
  <img src="assets/images/list of bins.png" width="250">
</p>

<p align="center">
  <img src="assets/images/Location.png" width="250">
  <img src="assets/images/Report issue.png" width="250">
</p>

> Users can explore nearby recycling bins, view locations through map interfaces, and report issues or incorrect information directly through the app.

---

### 🌍 Accessibility & User Experience

<p align="center">
  <img src="assets/images/Arabic.png" width="250">
  <img src="assets/images/Drak mode.png" width="250">
</p>

> The application supports both Arabic and English languages, along with dark mode for a more comfortable and accessible user experience.

---

### 👤 Profile & About

<p align="center">
  <img src="assets/images/Profile.png" width="250">
  <img src="assets/images/User-About releaf.png" width="250">
</p>

> Users can manage their profile information and learn more about ReLeaf’s mission and recycling awareness goals.

---

## ⚙️ How It Works

1. 📷 User captures or uploads an image
2. 🧠 Model classifies the waste type
3. 📱 Result is displayed instantly
4. 🤖 AI assistant provides extra guidance
5. 📍 User finds nearest recycling bin

---

## 🧪 Development Experience

During development, several challenges were addressed:

* Integrating LLM with backend APIs
* Handling complex API responses and output cleaning
* Working with local LLM limitations (Ollama & LM Studio)
* Optimizing model for mobile deployment (TensorFlow Lite)

These challenges helped improve system performance and design decisions.

---

## 👥 Team

* Fatemah Hussain Alyami
* Ghadi Talal Alzahrani
* Nadeen Nasser Abduljabbar
* Dana Bader Alakeel
* Amal Salman Almirsal


---

## 📌 Note

This project is developed as part of a graduation project at Imam Abdulrahman Bin Faisal University. It aims to provide an efficient and user-friendly solution to improve recycling awareness and waste management.
