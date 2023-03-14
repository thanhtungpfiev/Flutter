import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircleAvatar(
      radius: 100,
      backgroundColor: Theme.of(context).primaryColor,
      child: const CircleAvatar(
        radius: 95,
        backgroundColor: Colors.white70,
        backgroundImage: AssetImage('assets/images/Ass_Dao Thanh Tung.png'),
      ),
    );
  }
}
