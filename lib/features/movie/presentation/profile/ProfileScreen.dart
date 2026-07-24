import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:movie_app/features/movie/presentation/profile/state/ProfileState.dart';
import 'package:movie_app/features/movie/presentation/profile/state_management/ProfileManagement.dart';
import 'package:movie_app/features/movie/presentation/profile/widgets/OptionTile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileManagement _profileManagement;

  @override
  void initState() {
    super.initState();
    _profileManagement = context.read<ProfileManagement>();
    _profileManagement.getMyProfile();
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
                  Stack(
                    children: [
                      BlocSelector<ProfileManagement, ProfileState, String?>(
                        selector: (ProfileState state) => state.avt,
                        builder: (context, state) {
                          final avtUrl = state;
                          return CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.grey[800],
                            backgroundImage: avtUrl != null
                                ? NetworkImage(avtUrl)
                                : null,
                            child: avtUrl == null
                                ? Icon(
                                    Icons.person,
                                    size: 48,
                                    color: VColors.white.withAlpha(155),
                                  )
                                : null,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: pick/upload a new avatar image
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: VColors.colorIcon,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: VColors.blackBackground,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "_name",
                    style: TextStyle(
                      color: VColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "_email",
                    style: TextStyle(
                      color: VColors.white.withAlpha(155),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: navigate to edit-profile screen
                    },
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

            // Logout
            OptionTile(
              icon: Icons.logout,
              title: "Log out",
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
              onTap: _onLogoutPressed,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _onLogoutPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
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
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel", style: TextStyle(color: VColors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: VColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // TODO: call the actual logout logic (clear session, navigate to login, etc.)
    }
  }
}
