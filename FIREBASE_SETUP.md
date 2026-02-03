Firebase Configuration Guide

## Important: Firebase Setup Required

Before running the app, you need to configure Firebase for your project. Follow these steps:

1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select an existing project
3. Follow the setup wizard

### 2. Enable Firebase Services

In your Firebase project console:

1. **Authentication**:
   - Go to Authentication → Sign-in method
   - Enable "Email/Password" provider

2. **Firestore Database**:
   - Go to Firestore Database
   - Click "Create database"
   - Start in **test mode** (for development)
   - Choose a location close to your users

3. **Firebase Storage** (Optional for now):
   - Go to Storage
   - Click "Get started"
   - Start in test mode

### 3. Add Android App

1. In Firebase Console, click the Android icon
2. Enter your package name: `com.example.studymate` (or your custom package)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### 4. Add iOS App (if targeting iOS)

1. In Firebase Console, click the iOS icon
2. Enter your bundle ID
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### 5. Update Android Configuration

The following files need to be updated (already done in this project):

**android/build.gradle** - Add:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

**android/app/build.gradle** - Add at the bottom:
```gradle
apply plugin: 'com.google.gms.google-services'
```

### 6. Firestore Security Rules (Initial Setup)

In Firebase Console → Firestore Database → Rules, use these rules for development:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Admin collection - only authenticated admins can read/write
    match /admin/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Student collection - only authenticated students can read/write their own data
    match /student/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Questions - students can read, only admins can write
    match /questions/{questionId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                      exists(/databases/$(database)/documents/admin/$(request.auth.uid));
    }
    
    // Notes - students can read visible notes, admins can write
    match /notes/{noteId} {
      allow read: if request.auth != null && resource.data.isVisible == true;
      allow write: if request.auth != null && 
                      exists(/databases/$(database)/documents/admin/$(request.auth.uid));
    }
    
    // Quiz Results - users can read/write their own results
    match /quiz_results/{resultId} {
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow write: if request.auth != null && request.resource.data.userId == request.auth.uid;
    }
    
    // Solver History - users can read/write their own history
    match /solver_history/{historyId} {
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow write: if request.auth != null && request.resource.data.userId == request.auth.uid;
    }
  }
}
```

### 7. Create Initial Admin User

After setting up Firebase and running the app:

1. Register a new account through the app
2. Select "Admin" role during registration
3. The user will be created in the `admin` collection

OR manually create an admin user in Firestore:

1. Go to Firestore Database
2. Create a collection named `admin`
3. Add a document with the user's UID as the document ID
4. Add fields:
   - `email`: "admin@example.com"
   - `name`: "Admin Name"
   - `role`: "admin"
   - `uid`: (same as document ID)

### 8. Run the App

After completing the above steps:

```bash
flutter pub get
flutter run
```

### Troubleshooting

**Error: "No Firebase App '[DEFAULT]' has been created"**
- Make sure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
- Run `flutter clean` and `flutter pub get`

**Error: "MissingPluginException"**
- Run `flutter clean`
- Delete `ios/Podfile.lock` (if on iOS)
- Run `flutter pub get`
- For iOS: `cd ios && pod install`

**Authentication not working**
- Verify Email/Password is enabled in Firebase Console
- Check Firebase Console logs for errors

### Database Structure

The app uses the following Firestore collections:

- `admin` - Admin user profiles
- `student` - Student user profiles
- `questions` - Quiz questions
- `notes` - Study notes
- `quiz_results` - Quiz attempt results
- `solver_history` - Question solver history
- `solver_questions` - Predefined solver solutions (optional)

### Next Steps

Once Firebase is configured, you can:

1. Test authentication (register/login)
2. Add quiz questions through admin panel
3. Create study notes
4. Take quizzes as a student
5. Use the question solver

For production deployment, update Firestore security rules to be more restrictive.
