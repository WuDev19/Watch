import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';

enum EditProfileOption { name, email }

class EditProfileOptionsSheet extends StatelessWidget {
  final void Function(EditProfileOption option) onSelected;

  const EditProfileOptionsSheet({super.key, required this.onSelected});

  static Future<void> show(
      BuildContext context, {
        required void Function(EditProfileOption option) onSelected,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => EditProfileOptionsSheet(onSelected: onSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 40),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: VColors.blackBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          border: Border.all(color: Colors.white24),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                "Edit profile",
                style: TextStyle(
                  color: VColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildOptionTile(
                context,
                icon: Icons.person_outline,
                title: "Update Name",
                onTap: () {
                  Navigator.of(context).pop();
                  onSelected(EditProfileOption.name);
                },
              ),
              const SizedBox(height: 8),
              _buildOptionTile(
                context,
                icon: Icons.email_outlined,
                title: "Update Email",
                onTap: () {
                  Navigator.of(context).pop();
                  onSelected(EditProfileOption.email);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return Material(
      color: Colors.white.withAlpha(15),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: VColors.colorIcon),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: VColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: VColors.white.withAlpha(120)),
            ],
          ),
        ),
      ),
    );
  }
}