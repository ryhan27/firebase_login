import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:login_firebase/informasi_pengguna/user_info_screen.dart';

//filter mna yg hrus di render
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Menampilkan loading saat mengecek status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Jika terdapat data user (sudah login), tampilkan halaman info
        if (snapshot.hasData) {
          return UserInfoScreen(user: snapshot.data!);
        }

        // Jika tidak ada data user, tampilkan halaman login
        return const LoginScreen();
      },
    );
  }
}