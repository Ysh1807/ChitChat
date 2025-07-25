// import 'package:chat_app/screens/auth.dart';
// import 'package:chat_app/screens/chat.dart';
// import 'package:chat_app/screens/splash.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterChat',
//       theme: ThemeData().copyWith(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color.fromARGB(255, 63, 17, 177)),
//       ),
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SplashScreen();
//           }
//           if (snapshot.hasData) {
//             return ChatScreen();
//           }

//           return AuthScreen();
//         },
//       ),
//     );
//   }
// }

import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.indigo[400]!, // Main accent color
          onPrimary: Colors.white,
          secondary: Colors.purpleAccent[200]!, // Secondary accent
          onSecondary: Colors.white,
          background: const Color(0xFF181A20), // Modern dark background
          onBackground: Colors.white70,
          surface: const Color(0xFF23272F), // Card/surface color
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF181A20),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF23272F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: const Color(0xFF23272F),
        iconTheme: const IconThemeData(color: Colors.purpleAccent),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: _themeMode,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'ChitChat',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  letterSpacing: 1.5,
                  color: _themeMode == ThemeMode.dark
                      ? Colors.white.withOpacity(0.9)
                      : Colors.deepPurple,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    _themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  onPressed: _toggleTheme,
                ),
                if (snapshot.hasData)
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                    ),
                  ),
              ],
            ),
            body: () {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading...'));
              }
              if (snapshot.hasData) {
                return ChatScreen();
              }
              return AuthScreen();
            }(),
          );
        },
      ),
    );
  }
}
