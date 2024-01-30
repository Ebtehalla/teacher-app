import 'package:flutter/material.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

class DataCard extends StatelessWidget {
  const DataCard({super.key, required this.data, required this.name});
  final String data;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: FittedBox(
          child: Column(
            children: [
              Text(
                data,
                style: const TextStyle(fontSize: 35),
              ),
              Text(name)
            ],
          ),
        ));
  }
}
