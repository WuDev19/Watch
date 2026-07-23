import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/movie/presentation/auth/state/AuthState.dart';
import 'package:movie_app/features/movie/presentation/auth/state_management/LoginCubit.dart';
import 'package:rive/rive.dart';

import '../../../../core/colors/VColors.dart';
import '../../../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  File? _riveFile;
  RiveWidgetController? _riveController;
  StateMachine? _stateMachine;
  bool _riveReady = false;
  final ValueNotifier<bool> _isShowPassword = ValueNotifier(false);
  final FocusNode password = FocusNode();
  final FocusNode email = FocusNode();
  late double _screenWidth;
  late double _screenHeight;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = context.read<LoginCubit>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loadRive();
    password.addListener(() {
      _stateMachine?.boolean('isHandsUp')?.value = password.hasFocus;
    });
    email.addListener(() {
      _stateMachine?.boolean('isChecking')?.value = email.hasFocus;
    });
  }

  Future<void> _loadRive() async {
    final file = await File.asset(
      'assets/rive/teddy.riv',
      riveFactory: Factory.rive,
    );
    if (file == null || !mounted) return;
    final controller = RiveWidgetController(
      file,
      stateMachineSelector: StateMachineSelector.byName('Login Machine'),
    );
    setState(() {
      _riveFile = file;
      _riveController = controller;
      _stateMachine = controller.stateMachine;
      _riveReady = true;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    password.dispose();
    email.dispose();
    _isShowPassword.dispose();
    _riveController?.dispose();
    _riveFile?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = Constants.getWidthScreen(context);
    _screenHeight = Constants.getHeightScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/movie_bg.jpg",
            cacheWidth: 300,
            fit: BoxFit.cover,
            width: _screenWidth,
            height: _screenHeight,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.15 * _screenHeight),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: RepaintBoundary(
                        child: _riveReady
                            ? RiveWidget(
                                controller: _riveController!,
                                fit: Fit.cover,
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 0.8 * _screenWidth,
                  child: TextField(
                    controller: _emailController,
                    focusNode: email,
                    onChanged: (value) {
                      _stateMachine?.number('numLook')?.value = value.length
                          .toDouble();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: VColors.colorIcon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter email",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 0.8 * _screenWidth,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _isShowPassword,
                        builder: (context, isShow, child) {
                          return TextField(
                            controller: _passwordController,
                            focusNode: password,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _isShowPassword.value =
                                      !_isShowPassword.value;
                                  _stateMachine?.boolean('isHandsUp')?.value =
                                      !_isShowPassword.value;
                                },
                                child: isShow
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),

                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: VColors.colorIcon,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              hintText: "Enter password",
                            ),
                            obscureText: !isShow,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: VColors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocListener<LoginCubit, AuthState>(
                  listener: (context, state) {
                    switch (state) {
                      case Initial():
                        break;
                      case Loading():
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                            child: CircularProgressIndicator(
                              color: VColors.colorIcon,
                            ),
                          ),
                        );
                        break;
                      case Success():
                        context.pop();
                        context.pop();
                        break;
                      case Error():
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Đăng nhập không thành công, xem lại thông tin hoặc kết nối mạng",
                            ),
                          ),
                        );
                        break;
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      email.unfocus();
                      password.unfocus();
                      _loginCubit.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VColors.colorIcon,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: VColors.white),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: VColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: VColors.white),
                      ),
                      TextSpan(
                        text: "Register now",
                        style: TextStyle(
                          color: VColors.colorIcon,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
