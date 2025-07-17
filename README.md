# 🚀 EzServe – A Public Service Provider App

EzServe is a Flutter + Firebase-powered mobile and web application that connects users with trusted local service providers — such as doctors, electricians, plumbers, mechanics, cleaners, beauticians, and more. It offers a clean UI, real-time functionality, and a scalable codebase for further expansion.

## 📱 Features

- 🔐 **Firebase Authentication**  
  Secure login/signup with persistent session support.

- 📄 **Role-based Service Submission**  
  Dynamic forms for providers to submit their details based on selected service.

- 🗂️ **Service Listing by Category**  
  Users can browse available doctors, plumbers, electricians, etc.

- 👤 **User Profile Page**  
  Navigate to favorites, downloads, language settings, etc.

- 🌐 **Flutter Web Support**  
  Fully functional on `flutter run -d chrome`.

- 🔒 **Secure Firestore Rules**  
  Granular access control for services and user documents.

## 🔧 Tech Stack

- **Frontend:** Flutter (Mobile + Web)
- **Backend:** Firebase Firestore, Firebase Auth

## 🔜 Upcoming Features

- 🔔 Real-time Notifications  
- 📄 CV Upload + Service Verification  
- 💳 Payment Integration (e.g., Stripe)  
- 🗓️ Appointment Booking  
- 🧑‍💼 Admin Dashboard with Analytics

---

## 📂 Folder Structure

lib/
├── main.dart
├── home_screen.dart
├── login.dart
├── signup.dart
├── provideservice.dart
├── profile/
│ ├── ProfileScreen.dart
│ ├── EditProfileScreen.dart
├── services/
│ ├── electrician.dart
│ ├── plumber.dart
│ ├── doctor.dart
│ └── ...
└── booking/
├── book_electrician.dart
├── book_plumber.dart


