import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sdp_ca/views/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            sideBuilder: (context, constraints) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(60),
                  child: AspectRatio(
                      aspectRatio: 3.3,
                      child: Text(
                        "Software Design Patterns - Web App",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      )),
                ),
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome! Please sign in to continue.'
                      : 'Welcome! Please create an account to continue',
                ),
              );
            },
          );
        }
        return const Home();
      },
    );
  }
}
