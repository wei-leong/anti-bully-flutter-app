import 'package:flutter/material.dart';

class EditProfileImg extends StatelessWidget {
  const EditProfileImg({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.surfaceContainerHighest,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ), // TODO: Change the Background Image
            ),
            // Change Profile Picture Icon
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: (){}, // Icon Button onTap function
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.primary),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: colorScheme.onPrimary,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
