import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String lastLogin;
  final String profileImage;

  const UserProfileCard({
    Key? key,
    required this.name,
    required this.lastLogin,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: profileImage.isNotEmpty
                  ? NetworkImage(profileImage)
                  : null,
              child: profileImage.isEmpty
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              'Welcome Back',
             
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
                 'Last Login: $lastLogin',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
