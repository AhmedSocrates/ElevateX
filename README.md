# ElevateX 
**Level Up Your Career. Gamify Your Productivity.**

Welcome to the official repository for **ElevateX**, a cross-platform mobile application designed to transform career development and daily productivity into an engaging RPG-style experience. 

By combining the addictive loops of gaming with real-world career roadmaps, ElevateX helps users stay consistent, learn new skills, and achieve their goals.

---

##  About the Project

Traditional learning apps often suffer from high drop-off rates. ElevateX solves this by introducing core gamification mechanics—such as XP, leveling, daily streaks, and digital economies—directly into the educational and productivity journey. 

Users embark on specific "Career Paths" (e.g., *Zero to Flutter Master*), completing nodes and boss fights to earn rewards, climb leaderboards, and build real-world habits.

---

##  Core Features (Active Development)

* **Gamified Profiles:** Users earn XP and Coins by completing tasks, allowing them to level up and unlock new features.
* **The Streak Engine:** A custom-built backend algorithm that tracks daily logins, rewards consistency, and integrates an inventory system (e.g., using a "Streak Pauser" item to save a missed day).
* **Dynamic Roadmaps (Upcoming):** Interactive skill trees where users progress through curated nodes and boss fights.
* **Guilds & Leaderboards (Upcoming):** Social features allowing users to team up, compete, and share progress.

---

##  The Technology Stack

ElevateX is built using a modern, scalable client-server architecture.

### Frontend (Mobile App)
* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **Target Platforms:** Android for now 
* **State Management:** Riverpod
* **Security:** `flutter_secure_storage` for encrypted JWT management.

### Backend (RESTful API)
* **Environment:** [Node.js](https://nodejs.org/)
* **Framework:** Express.js
* **Database:** MongoDB Atlas (NoSQL) & Mongoose ODM
* **Authentication:** Stateless JWT (JSON Web Tokens) & bcryptjs
* **Architecture:** Feature-first modular design built for horizontal scaling.

---

##  System Architecture Overview

ElevateX utilizes a decoupled architecture where the Flutter mobile client communicates with the Express backend via a secure, stateless REST API. 

* **Authentication Flow:** Users authenticate via the backend, receiving a JWT that is stored in the device's secure enclave. This token acts as a digital wristband for all future requests.
* **Middleware Interceptors:** The backend utilizes custom Express middleware to act as "bouncers," validating tokens and automatically calculating daily streaks before granting access to protected resources.
* **Data Embeds:** MongoDB is optimized using embedded document schemas to quickly deliver complex Quest and Roadmap data to the mobile client in single, efficient network requests.

---

*Note: This repository is actively maintained by the ElevateX development team. Source code and local environment setups are restricted to core contributors.*
