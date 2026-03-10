
export const careerPathsData = [
  {
    _id: "65f1a2b3c4d5e6f7a8b9c001",
    title: "Frontend Developer",
    slug: "frontend-dev",
    description: "Master the art of creating magical user interfaces",
    themeColor: "0xFF8E74FF",
    iconName: "magic_wand",
    totalNodes: 4,
    isActive: true
  },
  {
    _id: "65f1a2b3c4d5e6f7a8b9c002",
    title: "Backend Developer",
    slug: "backend-dev",
    description: "Build robust APIs, manage databases, and handle server logic",
    themeColor: "0xFF4CAF50",
    iconName: "server",
    totalNodes: 4,
    isActive: true
  }
];

export const nodesData = [
  // --- Frontend Nodes ---
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c001')",
    "orderIndex": 1,
    "title": "Basics of Computer",
    "type": "reading",
    "xpReward": 20,
    "content": {
      "text": "Understand how computers work, memory, and basic hardware components."
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c001')",
    "orderIndex": 2,
    "title": "Internet and Web",
    "type": "multiple_choice",
    "xpReward": 50,
    "content": {
      "question": "What protocol is primarily used to transfer web pages?",
      "options": ["FTP", "HTTP", "SMTP", "SSH"],
      "correctAnswerIndex": 1
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c001')",
    "orderIndex": 3,
    "title": "Programming: HTML, CSS & JavaScript",
    "type": "multiple_choice",
    "xpReward": 50,
    "content": {
      "question": "Which of these is a CSS Framework?",
      "options": ["TypeScript", "React", "Tailwind", "npm"],
      "correctAnswerIndex": 2
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c001')",
    "orderIndex": 4,
    "title": "Frontend Frameworks",
    "type": "reading",
    "xpReward": 30,
    "content": {
      "text": "Learn modern tools like React, Angular, or Vue to build SPAs, and manage packages with npm."
    }
  },

  // --- Backend Nodes ---
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c002')",
    "orderIndex": 1,
    "title": "Internet and Web",
    "type": "reading",
    "xpReward": 20,
    "content": {
      "text": "Understand HTTP/HTTPS, DNS, and how browsers communicate with servers."
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c002')",
    "orderIndex": 2,
    "title": "Core Skills: Languages & Databases",
    "type": "multiple_choice",
    "xpReward": 50,
    "content": {
      "question": "Which of the following is an example of a NoSQL database?",
      "options": ["PostgreSQL", "MongoDB", "MySQL", "Oracle"],
      "correctAnswerIndex": 1
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c002')",
    "orderIndex": 3,
    "title": "Backend Frameworks",
    "type": "multiple_choice",
    "xpReward": 60,
    "content": {
      "question": "If you are using Java for your server-side logic, which framework from the roadmap would you utilize?",
      "options": ["Laravel", "Django", "Express.js", "Spring"],
      "correctAnswerIndex": 3
    }
  },
  {
    "pathId": "ObjectId('65f1a2b3c4d5e6f7a8b9c002')",
    "orderIndex": 4,
    "title": "Version Control Systems",
    "type": "multiple_choice",
    "xpReward": 50,
    "content": {
      "question": "Which of these platforms is used to host Git repositories?",
      "options": ["Composer", "GitHub", "npm", "pip"],
      "correctAnswerIndex": 1
    }
  }
];