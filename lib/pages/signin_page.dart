import 'package:flutter/material.dart';
import 'package:majestic/providers/destination_provider.dart';
import 'package:majestic/providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:majestic/widgets/loading_btn_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleLogin() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: _emailController.text,
        password: _passwordController.text,
      )) {
        FocusManager.instance.primaryFocus?.unfocus();
        await Provider.of<DestinationProvider>(context, listen: false)
            .getProducts(
          id: authProvider.user!.id.toString(),
        );
        await Provider.of<EventProvider>(context, listen: false).getProducts(
          id: authProvider.user!.id.toString(),
        );
        Navigator.pushNamed(context, '/home');
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Login Gagal!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email Address",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
              // height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your email address",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10, right: 40, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
              // height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Expanded(
                child: TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  obscureText: true,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your password",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonSignin() {
      return Container(
        margin: const EdgeInsets.only(top: 15, right: 40, left: 40),
        decoration: BoxDecoration(
            color: const Color(0xFF73C993),
            borderRadius: BorderRadius.circular(10)),
        height: 48,
        width: double.infinity,
        child: TextButton(
          onPressed: handleLogin,
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: handleLogin,
              child: const Text(
                " Sign Up",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/majestic_banyuangi.png',
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/banyuangi.png',
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Log in now to continue",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
            emailInput(),
            passwordInput(),
            isLoading ? const LoadingBtnWidget() : buttonSignin(),
            const Spacer(),
            footer(),
          ],
        ),
      ),
    );
  }
}
