import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mid_term/pages/product_list_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Người dùng đã đăng xuất!");
      } else {
        print("Người dùng đang đăng nhập: ${user.email}");
      }
    });
    await signOut();
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductListPage()));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Người dùng đã đăng xuất thành công!");
    } catch (e) {
      print("Lỗi khi đăng xuất: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập Firebase")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              child: Text("Đăng nhập"),
            ),
          ],
        ),
      ),
    );
  }
}
