# StudyMate 📚

**Your Smart Study Companion**

StudyMate is a comprehensive mobile-based educational application designed to help students prepare for exams through interactive quizzes, organized study notes, and an intelligent question solver with OCR capabilities.

## ✨ Features

### For Students
- **📝 Interactive Quizzes**
  - Subject-wise quiz selection
  - Multiple difficulty levels (Easy, Medium, Hard)
  - Timed quiz sessions
  - Instant score calculation
  - Detailed quiz history and progress tracking

- **📖 Study Notes**
  - Organized by subject
  - Search functionality
  - Bookmark favorite notes
  - Offline access support

- **🔍 Question Solver**
  - Type questions manually or capture with camera
  - OCR text extraction from images
  - Step-by-step solutions
  - Solution history tracking

- **📊 Progress Tracking**
  - Total quizzes taken
  - Average score statistics
  - Study streak counter
  - Performance analytics

### For Admins
- **📊 Dashboard*
  - Total users overview
  - Quiz statistics
  - Content management metrics

- **❓ Quiz Management**
  - Add/edit/delete questions
  - Subject and difficulty assignment
  - Question preview

- **📝 Notes Management**
  - Create and edit study notes
  - Rich text support
  - Visibility control

- **👥 User Management**
  - View all registered users
  - Activity statistics
  - Account management

## 🏗️ Architecture

### Tech Stack
- **Framework**: Flutter (Dart)
- **Backend**: Firebase
  - Authentication (Email/Password)
  - Cloud Firestore (Database)
  - Firebase Storage (Images)
- **State Management**: Provider
- **OCR**: Google ML Kit
- **UI**: Material Design 3 with Google Fonts

### Project Structure
```
lib/
├── core/
│   ├── constants/      # App constants, colors, strings
│   ├── themes/         # Light/dark themes
│   ├── utils/          # Helper functions
│   └── routes/         # Navigation routing
├── models/             # Data models
├── services/           # Firebase & OCR services
├── providers/          # State management
├── screens/            # UI screens
│   ├── auth/          # Authentication screens
│   ├── student/       # Student features
│   └── admin/         # Admin features
└── widgets/           # Reusable widgets
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.10.7)
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/itsmeishwar/StudyMate.git
   cd studymate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   
   Follow the detailed instructions in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
   
   Quick steps:
   - Create a Firebase project
   - Enable Email/Password authentication
   - Create Firestore database
   - Download and add `google-services.json` (Android)
   - Download and add `GoogleService-Info.plist` (iOS)

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Usage

### Student Workflow
1. Register with email and password (select "Student" role)
2. Login to access the dashboard
3. Take quizzes by selecting subject and difficulty
4. Browse and bookmark study notes
5. Use the question solver for help
6. Track your progress in the profile section

### Admin Workflow
1. Register with email and password (select "Admin" role)
2. Login to access the admin dashboard
3. Add quiz questions with subjects and difficulty levels
4. Create and manage study notes
5. Monitor user activity and statistics

## 🔒 Security

- Firebase Authentication for secure user management
- Firestore security rules for role-based access control
- Password validation and encryption
- Secure data transmission

## 🎨 Design

- Modern Material Design 3
- Custom color palette with gradients
- Google Fonts (Inter)
- Smooth animations and transitions
- Responsive layouts for all screen sizes
- Dark mode support

## 📦 Dependencies

Key packages used:
- `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`
- `provider` - State management
- `google_ml_kit` - OCR functionality
- `image_picker` - Camera/gallery access
- `google_fonts` - Typography
- `fl_chart` - Statistics charts
- `shared_preferences`, `hive` - Local storage

## 🛠️ Development

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📝 Firebase Collections

- `admin` - Admin user profiles
- `student` - Student user profiles
- `questions` - Quiz questions
- `notes` - Study notes
- `quiz_results` - Quiz attempt results
- `solver_history` - Question solver history

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Ishwar**
- GitHub: [@itsmeishwar](https://github.com/itsmeishwar)
- Email: ishwarawasthi3@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google ML Kit for OCR capabilities
- Material Design for UI guidelines

---

**Note**: This is an educational project. Make sure to configure proper security rules before deploying to production.