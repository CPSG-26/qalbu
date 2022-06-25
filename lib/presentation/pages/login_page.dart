import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/presentation/pages/home_page.dart';
import 'package:qalbu/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'Selamat Datang',
                      child: Text(
                        'Selamat Datang',
                        style: kHeading6.copyWith(
                            color: kPrimary, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Masuk sekarang untuk melanjutkan',
                        style: kSubtitle.copyWith(color: kPrimary)),
                    Image.asset('assets/images/signin_illustration.png'),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Masukkan email anda',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: 'Masukkan password anda',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      textTheme: ButtonTextTheme.primary,
                      height: 40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          await _auth
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) => Navigator.pushReplacementNamed(
                                  context, HomePage.routeName));
                        } catch (e) {
                          final snackbar =
                              SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: const Text('Masuk'),
                    ),
                    TextButton(
                      child: const Text('Tidak punya akun? Daftar'),
                      onPressed: () =>
                          Navigator.pushNamed(context, RegisterPage.routeName),
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
