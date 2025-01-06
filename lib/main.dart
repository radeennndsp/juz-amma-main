import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:juz_amma/page/page_list_surah.dart';
import 'package:juz_amma/page/sign_in_page.dart';
import 'package:juz_amma/page/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        initialRoute: '/auth_checker',
        routes: {
          '/auth_checker': (context) => const AuthChecker(),
          '/sign_in': (context) => const SignInPage(),
          '/sign_up': (context) => const SignUpPage(),
          '/home': (context) => const PageListSurah(),
        });
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading sementara
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // Jika pengguna sudah login, arahkan ke HomePage
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          // Jika belum login, arahkan ke SignInPage
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/sign_in');
          });
        }

        return const SizedBox(); // Return widget kosong karena navigasi langsung diproses
      },
    );
  }
}
