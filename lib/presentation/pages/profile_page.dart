import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/presentation/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = 'profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  late User _activeUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    try {
      var currentUser = _auth.currentUser;

      if (currentUser != null) {
        _activeUser = currentUser;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Saya'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/images/user_picture.png', height: 128),
                Center(
                    child: Text(
                  _activeUser.displayName!,
                  style: kHeading5,
                )),
                Center(
                    child: Text(
                  _activeUser.email!,
                  style: kHeading6.copyWith(color: kSecondaryTextColor),
                )),
                const Card(
                  child: ListTile(
                    title: Text('Tentang'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
              color: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () async {
                await _auth.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.routeName, (route) => false));
              },
              child: const Text('Keluar')),
        ),
      ),
    );
  }
}
