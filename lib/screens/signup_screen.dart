import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _bioCtrl.dispose();
    _usernameCtrl.dispose();
  }

  Future<void> selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    final res = await AuthMethods().signUpUser(
        email: _emailCtrl.text,
        password: _passCtrl.text,
        username: _usernameCtrl.text,
        bio: _bioCtrl.text,
        file: _image!);
    print(res);
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            SvgPicture.asset('assets/images/ic_instagram.svg',
                color: primaryColor, height: 50),
            const SizedBox(height: 50),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(staticProfileImage)),
                Positioned(
                    bottom: -10,
                    right: 5,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(height: 25),
            TextInputField(
                textEditingController: _usernameCtrl,
                inputType: TextInputType.text,
                hintText: 'Enter your username'),
            const SizedBox(height: 25),
            TextInputField(
                textEditingController: _emailCtrl,
                inputType: TextInputType.emailAddress,
                hintText: 'Enter your email'),
            const SizedBox(height: 25),
            TextInputField(
                textEditingController: _passCtrl,
                inputType: TextInputType.text,
                hintText: 'Enter your password',
                isPass: true),
            const SizedBox(height: 25),
            TextInputField(
                textEditingController: _bioCtrl,
                inputType: TextInputType.text,
                hintText: 'Enter your bio'),
            const SizedBox(height: 25),
            InkWell(
              onTap: signUpUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : const Text("Sign up"),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(flex: 2, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account?")),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Login.",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
