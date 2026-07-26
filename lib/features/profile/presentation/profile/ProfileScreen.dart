import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/profile/presentation/profile/state/ProfileState.dart';
import 'package:movie_app/features/profile/presentation/profile/state_management/ProfileManagement.dart';
import 'package:movie_app/features/profile/presentation/profile/widgets/CameraButton.dart';
import 'package:movie_app/features/profile/presentation/profile/widgets/EditProfileOptionsSheet.dart';
import 'package:movie_app/features/profile/presentation/profile/widgets/OptionTile.dart';
import 'package:movie_app/utils/MethodHelperUtils.dart';
import 'package:movie_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileManagement _profileManagement;
  late double _screenHeight;
  late double _screenWidth;
  final ImagePicker _pick = ImagePicker();
  XFile? image;
  final ValueNotifier<bool> _isUploadAvt = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _profileManagement = context.read<ProfileManagement>();
    _profileManagement.getMyProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = Constants.getHeightScreen(context);
    _screenWidth = Constants.getWidthScreen(context);
  }

  @override
  void dispose() {
    super.dispose();
    _isUploadAvt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VColors.blackBackground,
      appBar: AppBar(
        backgroundColor: VColors.blackBackground,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: VColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            Center(
              child: Column(
                children: [
                  BlocSelector<
                    ProfileManagement,
                    ProfileState,
                    (String?, String?, String?)
                  >(
                    selector: (state) => (state.avt, state.name, state.email),
                    builder: (context, state) {
                      final avtUrl = state.$1;
                      final name = state.$2;
                      final email = state.$3;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.grey[800],
                                  backgroundImage: avtUrl != null
                                      ? CachedNetworkImageProvider(avtUrl)
                                      : image != null
                                      ? FileImage(File(image!.path))
                                      : null,
                                  child: avtUrl == null && image == null
                                      ? Icon(
                                          Icons.person,
                                          size: 48,
                                          color: VColors.white.withAlpha(155),
                                        )
                                      : null,
                                ),
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) {
                                          return Center(
                                            child: ScaleTransition(
                                              scale: animation,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      20,
                                                    ),
                                                child: CachedNetworkImage(
                                                  height: _screenHeight * 0.5,
                                                  width: _screenWidth * 0.9,
                                                  imageUrl: avtUrl!,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                            Icons.error,
                                                            color: Colors.white,
                                                          ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: _isUploadAvt,
                                builder: (context, isUpload, child) {
                                  return !isUpload
                                      ? CameraButton(
                                          onTap: () async {
                                            image = await _pick.pickImage(
                                              source: ImageSource.gallery,
                                            );
                                            if (image != null) {
                                              _profileManagement
                                                  .setAvatarFromImagePicker();
                                              _isUploadAvt.value = true;
                                            }
                                          },
                                          size: 16,
                                          borderColor: VColors.blackBackground,
                                          icon: Icons.camera_alt,
                                          backgroundColor: VColors.colorIcon,
                                          iconColor: VColors.white,
                                        )
                                      : CameraButton(
                                          onTap: () {
                                            if (image != null) {
                                              _showLoadingDialog(context);
                                              _onUploadAvt(context, image!);
                                            }
                                          },
                                          size: 20,
                                          borderColor: VColors.blackBackground,
                                          icon: Icons.done_outline_rounded,
                                          iconColor: Colors.green,
                                          backgroundColor: VColors.white,
                                        );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            name ?? "",
                            style: TextStyle(
                              color: VColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            email ?? "",
                            style: TextStyle(
                              color: VColors.white.withAlpha(155),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => _onEditProfilePressed(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: VColors.colorIcon),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      "Edit profile",
                      style: TextStyle(color: VColors.colorIcon),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),

            // Account section
            OptionTile(
              icon: Icons.favorite_border,
              title: "My Favorites",
              onTap: () {
                // TODO: navigate to favorites screen
              },
            ),
            OptionTile(
              icon: Icons.history,
              title: "Watch History",
              onTap: () {
                // TODO: navigate to watch history screen
              },
            ),
            OptionTile(
              icon: Icons.download_outlined,
              title: "Downloads",
              onTap: () {
                // TODO: navigate to downloads screen
              },
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),
            OptionTile(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () {
                // TODO: navigate to help & support screen
              },
            ),
            OptionTile(
              icon: Icons.info_outline,
              title: "About",
              onTap: () {
                // TODO: navigate to about screen
              },
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),
            OptionTile(
              icon: Icons.logout,
              title: "Log out",
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
              onTap: () => _onLogoutPressed(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: VColors.blackBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: VColors.colorIcon, width: 2),
        ),
        title: Text("Log out", style: TextStyle(color: VColors.white)),
        content: Text(
          "Are you sure you want to log out?",
          style: TextStyle(color: VColors.white.withAlpha(155)),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.colorIcon,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text("Cancel", style: TextStyle(color: VColors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              _showLoadingDialog(dialogContext);
              _profileManagement
                  .logout()
                  .then((value) {
                    if (!context.mounted) return;
                    MethodHelperUtils.showSnackBar(
                      context,
                      Constants.logoutNotification,
                    );
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(dialogContext).pop();
                    context.pop("logout");
                  })
                  .catchError((e) {
                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    MethodHelperUtils.showSnackBar(context, e.toString());
                  });
            },
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _onUploadAvt(BuildContext context, XFile image) {
    _profileManagement
        .updateAvatar(image.path)
        .then((value) {
          if (!context.mounted) {
            return;
          }
          MethodHelperUtils.showSnackBar(context, "Update avatar successfully");
          _isUploadAvt.value = false;
          Navigator.of(context, rootNavigator: true).pop();
        })
        .catchError((e) {
          if (!context.mounted) {
            return;
          }
          MethodHelperUtils.showSnackBar(
            context,
            "Update avatar unsuccessfully because of ${e.toString()}",
          );
          Navigator.of(context, rootNavigator: true).pop();
        });
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: VColors.colorIcon),
      ),
    );
  }

  void _onEditProfilePressed(BuildContext context) {
    EditProfileOptionsSheet.show(
      context,
      onSelected: (option) {
        final currentName = _profileManagement.state.name ?? "";
        final currentEmail = _profileManagement.state.email ?? "";
        switch (option) {
          case EditProfileOption.name:
            _showEditDialog(
              context,
              title: "Update Name",
              hint: "Enter your name",
              initialValue: currentName,
              onSave: (value) => _profileManagement.updateName(value),
            );
            break;
          case EditProfileOption.email:
            _showEditDialog(
              context,
              title: "Update Email",
              hint: "Enter your email",
              initialValue: currentEmail,
              keyboardType: TextInputType.emailAddress,
              onSave: (value) => _profileManagement.updateEmail(value),
            );
            break;
        }
      },
    );
  }

  void _showEditDialog(
    BuildContext context, {
    required String title,
    required String hint,
    required String initialValue,
    required Future<void> Function(String value) onSave,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: VColors.blackBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: VColors.colorIcon, width: 2),
        ),
        title: Text(title, style: TextStyle(color: VColors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: keyboardType,
          style: const TextStyle(color: VColors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: VColors.white.withAlpha(120)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: VColors.colorIcon),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.colorIcon,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text("Cancel", style: TextStyle(color: VColors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final value = controller.text.trim();
              if (value.isEmpty) return;
              Navigator.of(dialogContext).pop();
              _showLoadingDialog(context);
              onSave(value)
                  .then((_) {
                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    MethodHelperUtils.showSnackBar(
                      context,
                      "Update successfully",
                    );
                  })
                  .catchError((e) {
                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    MethodHelperUtils.showSnackBar(context, e.toString());
                  });
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
