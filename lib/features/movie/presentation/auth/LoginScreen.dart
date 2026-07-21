import 'package:flutter/material.dart';
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
  final FocusNode username = FocusNode();
  late double _screenWidth;
  late double _screenHeight;

  @override
  void initState() {
    super.initState();
    _loadRive();
    password.addListener(() {
      _stateMachine?.boolean('isHandsUp')?.value = password.hasFocus;
    });
    username.addListener(() {
      _stateMachine?.boolean('isChecking')?.value = username.hasFocus;
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
    password.dispose();
    username.dispose();
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
      body: SingleChildScrollView(
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
                focusNode: username,
                onChanged: (value) {
                  _stateMachine?.number('numLook')?.value = value.length
                      .toDouble();
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: VColors.colorIcon),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter username",
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 0.8 * _screenWidth,
              child: ValueListenableBuilder(
                valueListenable: _isShowPassword,
                builder: (context, isShow, child) {
                  return TextField(
                    focusNode: password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _isShowPassword.value = !_isShowPassword.value;
                          _stateMachine?.boolean('isHandsUp')?.value =
                              _isShowPassword.value;
                        },
                        child: isShow
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),

                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: VColors.colorIcon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Enter password",
                    ),
                    obscureText: isShow,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
