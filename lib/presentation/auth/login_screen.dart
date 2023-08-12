import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_mon/presentation/main_screen.dart';
import 'package:poke_mon/presentation/widget/loading_widget.dart';
import 'package:poke_mon/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void handReq() async {
    setState(() => isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InnerPageLoadingIndicator(loading: isLoading),
                Text(
                  "Login",
                  style: textTheme.displayMedium?.copyWith(
                    fontSize: 50,
                    fontFamily: kAppFontFamily,
                    fontWeight: AppFontWeight.semibold,
                  ),
                ),
                const Space(30),
                Text(
                  "Email",
                  style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: AppFontWeight.medium),
                ),
                const Space(10),
                TextFormInput(
                  labelText: "Enter Email",
                  controller: username,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  validator: (value) => validateEmail(value),
                ),
                const Space(30),
                Text(
                  "Password",
                  style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: AppFontWeight.medium),
                ),
                const Space(10),
                TextFormInput(
                  labelText: "**************",
                  controller: password,
                  obscureText: obscure,
                  keyboardType: TextInputType.name,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    color: Colors.grey,
                    iconSize: 19,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  validator: (value) => validatePassword(value),
                ),
                const Space(50),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                          handReq();
                        }
                      }

                      if (isLoading) {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        if (mounted) {
                          context.navigateReplace(const MainScreen());
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: AppFontWeight.medium),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
