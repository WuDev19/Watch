import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/auth/presentation/auth/state/AuthState.dart';
import 'package:movie_app/features/auth/presentation/auth/state_management/SignUpCubit.dart';

import '../../../../../utils/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double _screenWidth;
  late double _screenHeight;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  late final SignUpCubit _signUpCubit;

  @override
  void initState() {
    super.initState();
    _signUpCubit = context.read<SignUpCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = Constants.getWidthScreen(context);
    _screenHeight = Constants.getHeightScreen(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: VColors.colorIcon),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Colors.redAccent),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      fillColor: Colors.grey[800],
      filled: true,
      prefixIcon: Icon(icon, color: VColors.white),
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: TextStyle(color: VColors.white.withAlpha(190)),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name";
    }
    if (value.trim().length < 2) {
      return "Name is too short";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Invalid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  Future<void> _onSignUpPressed() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _signUpCubit.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: VColors.blackBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 0.08 * _screenHeight, bottom: 32),
          child: SizedBox(
            width: _screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.1 * _screenWidth),
                  child: Text(
                    "SIGN UP AND HAVE A NICE EXPERIENCE",
                    style: TextStyle(
                      color: VColors.colorIcon,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/images/movie_sign_up.png",
                  width: 0.3 * _screenWidth,
                  cacheWidth: 300,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 0.85 * _screenWidth,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: VColors.white),
                          validator: _validateName,
                          decoration: _inputDecoration(
                            label: "Full name",
                            icon: Icons.person_outline,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: VColors.white),
                          validator: _validateEmail,
                          decoration: _inputDecoration(
                            label: "Email",
                            icon: Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscurePassword,
                          builder: (context, obscure, _) {
                            return TextFormField(
                              controller: _passwordController,
                              obscureText: obscure,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(color: VColors.white),
                              validator: _validatePassword,
                              decoration: _inputDecoration(
                                label: "Password",
                                icon: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: VColors.white,
                                  ),
                                  onPressed: () {
                                    _obscurePassword.value = !obscure;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscureConfirmPassword,
                          builder: (context, obscure, _) {
                            return TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: obscure,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(color: VColors.white),
                              validator: _validateConfirmPassword,
                              decoration: _inputDecoration(
                                label: "Confirm password",
                                icon: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: VColors.white,
                                  ),
                                  onPressed: () {
                                    _obscureConfirmPassword.value = !obscure;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        BlocListener<SignUpCubit, AuthState>(
                          listener: (context, state) {
                            switch (state) {
                              case Initial():
                                break;
                              case Loading():
                                _isLoading.value = true;
                                break;
                              case Success():
                                _isLoading.value = false;
                                context.pop(
                                  "${_emailController.text.trim()}_${_passwordController.text.trim()}",
                                );
                                break;
                              case Error():
                                _isLoading.value = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Đăng ký không thành công, xem lại thông tin hoặc kết nối mạng",
                                    ),
                                  ),
                                );
                                break;
                            }
                          },
                          child: const SizedBox(height: 28),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isLoading,
                          builder: (context, isLoading, _) {
                            return SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _onSignUpPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: VColors.colorIcon,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                          color: VColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: VColors.white.withAlpha(180),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: VColors.colorIcon,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
