import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(245, 241, 185, 42),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 25),
          const Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: Text(
              'ApriStore',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsetsGeometry.all(6),
            ),
            badgeContent: const Text(
              '9',
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/listChat_page'),
              child: Icon(
                Icons.message_rounded,
                size: 30,
                color: Color.fromARGB(255, 90, 92, 92),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
