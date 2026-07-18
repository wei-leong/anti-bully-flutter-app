# 🛡️ Anti-Bully Flutter App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)

> **Note:** This system was originally developed as a core project for my Software Engineering coursework. It has been architected to production standards, utilizing a feature-first folder structure and MVVM design patterns.

## 📱 Overview

The Anti-Bully Flutter App is a comprehensive, multi-role mobile platform designed to facilitate secure incident reporting, connect users with professional counselors, and provide access to educational resources. 

Built with scalability in mind, the application features distinct dashboards and navigation flows dynamically rendered based on the user's role (Admin, Counselor, or Student/User).

---

## 🏗️ Architecture & Design

This codebase rigorously adheres to the **MVVM (Model-View-ViewModel)** architectural pattern and a **Feature-First** directory structure. This ensures a strict separation of concerns, making the codebase highly testable, maintainable, and scalable.

*   **Presentation Layer (`/presentation`):** Contains UI screens and reusable widgets.
*   **Domain/Model Layer (`/model`):** Defines the core data structures and repository interfaces.
*   **Data Layer (`/data`):** Handles external API calls, Firebase interactions, and local storage (Shared Preferences).
*   **State Management (`/viewmodel`):** Manages business logic and state transitions between the Data and Presentation layers.

## 🛠️ Tech Stack

*   **Frontend:** Flutter & Dart
*   **Backend/BaaS:** Firebase (Authentication, Firestore Database)
*   **State Management:** Provider / MVVM
*   **Local Storage:** Shared Preferences

---

## ✨ Key Features

### 1. Role-Based Access Control (RBAC)
*   Dynamic application wrappers (`main_wrapper_admin.dart`, `main_wrapper_conselor.dart`, `main_wrapper_user.dart`) route users to isolated experiences based on their authenticated role.
*   **Admins:** Monitor system health, manage staff resources, and review escalated reports.
*   **Counselors:** Track assigned users, manage incoming chat requests, and publish resources.
*   **Users:** Submit reports, access educational materials, and initiate counseling sessions.

### 2. Secure Incident Reporting Workflow
*   Dedicated module for users to document and submit incident reports.
*   Includes detailed historical tracking and status updates via the `Report History` screen.

### 3. Real-Time Chat System
*   Integrated messaging platform allowing direct, private communication between users and verified counselors.
*   Custom UI implementations for chat lists, chat rooms, and dynamic message bubbles.

### 4. Multimedia Resource Hub
*   A centralized content delivery system supporting articles, event posters, and full-screen educational videos.
*   Administrators and Counselors can curate and manage these resources dynamically.

---

## 🚀 Installation & Setup

To run this project locally, ensure you have the Flutter SDK installed and a valid Firebase project configured.

**1. Clone the repository:**
```bash
git clone https://github.com/wei-leong/anti-bully-flutter-app.git
cd anti-bully-flutter-app
```

**2. Install Dependencies:**
```bash
flutter pub get
```

**3. Configure Firebase**
* Ensure your google-services.json (Android) and GoogleService-Info.plist (iOS) are placed in their respective directories.
* The firebase_options.dart file is pre-configured for initialization.

**4. Run the App**
```bash
flutter run
```
