# ChitChat - Flutter Chat App

A modern, aesthetic chat application built with Flutter and Firebase.  
Supports dark/light mode, message replies, push notifications, and user authentication.

---

## Features

- **Firebase Authentication** (Email/Password)
- **Realtime Messaging** (Firestore)
- **Push Notifications** (FCM)
- **User Profile Image Upload**
- **Dark & Light Mode Toggle**
- **Delete Messages**
- **Modern UI**

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Ysh107/ChitChat.git
cd chitchat-flutter
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up Firebase

- Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com/)
- Add Android/iOS apps and download `google-services.json`/`GoogleService-Info.plist`
- Place them in the respective platform folders.
- Update `lib/firebase_options.dart` using the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/).

### 4. Run the app

```bash
flutter run
```

---

## Folder Structure

```
lib/
  ├── main.dart                # App entry, theme, routing
  ├── screens/
  │     ├── auth.dart          # Login/Signup screen
  │     ├── chat.dart          # Main chat screen
  │     └── splash.dart        # Splash/loading screen
  ├── widgets/
  │     ├── chat_messages.dart # Message list & delete/reply logic
  │     ├── message_bubble.dart# Individual message UI
  │     ├── new_message.dart   # Message input & reply UI
  │     └── user_image_picker.dart # Profile image picker
  └── firebase_options.dart    # Firebase config
```

---

## Screenshots

<img width="180" height="400" alt="image" src="https://github.com/user-attachments/assets/ffa9b6c1-a04b-498a-92b9-92c44c7b3ee7" />
<img width="180" height="400" alt="image" src="https://github.com/user-attachments/assets/5c2a4c40-2e4b-43ed-a2c3-6e600f7fac75" />
<img width="180" height="400" alt="image" src="https://github.com/user-attachments/assets/ce1fe13a-0031-481c-a7d8-9f1081de0e2d" />
<img width="180" height="400" alt="image" src="https://github.com/user-attachments/assets/f49e2818-6edc-47a8-82e0-7d1c4386bbf1" />
<img width="180" height="400" alt="image" src="https://github.com/user-attachments/assets/f663fd4e-0790-4427-bfc5-ad6b45431647" />





---

## License

MIT

---

## Credits

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Google Fonts](https://fonts.google.com/)
