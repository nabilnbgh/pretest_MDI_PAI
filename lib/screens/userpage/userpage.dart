import 'package:flutter/material.dart';
import 'package:pandawatest/model/response/user/user.dart';
import 'package:pandawatest/screens/shared/userdetail.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.user});
  final User user;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(user.image!),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                UserDetail(
                    icon: Icons.person,
                    text: '${user.firstName!} ${user.lastName!}'),
                const SizedBox(
                  height: 8,
                ),
                UserDetail(icon: Icons.email, text: '${user.email}'),
                const SizedBox(
                  height: 8,
                ),
                UserDetail(icon: Icons.phone, text: '${user.phone}'),
                const SizedBox(
                  height: 8,
                ),
                UserDetail(
                    icon: Icons.pin_drop,
                    text: '${user.address!.address}, ${user.address!.city}'),
              ],
            ),
          )
        ],
      )),
    );
  }
}
