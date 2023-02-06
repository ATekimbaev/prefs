import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prefs_1/home_page.dart';
import 'package:prefs_1/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogined = false;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    routing();
    super.initState();
  }

  void routing() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    String token = await storage.read(key: 'token') ?? '';
    isLogined = token.isNotEmpty;

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isLogined ? const MyHomePage(title: '') : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
