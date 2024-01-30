import 'package:flutter/material.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/teachers/controllers/teachers_controller.dart';
import 'package:hello_teacher_admin_dashboard/app/utils/timeformat.dart';

class DetailTeacher extends StatelessWidget {
  final TeachersController controller;
  const DetailTeacher({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 400,
            child: AspectRatio(
              aspectRatio: 1, // Maintain aspect ratio (1.0 means square)
              child: Image.network(
                controller.selectedTeacher!.picture!,
                // fit: BoxFit.scaleDown, // Preserve aspect ratio and fit inside
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildKeyValueRow('Name', controller.selectedTeacher?.name),
              _buildKeyValueRow('Category',
                  controller.selectedTeacher?.category?.categoryName),
              _buildKeyValueRow(
                  'Biography', controller.selectedTeacher?.shortBiography),
              _buildKeyValueRow(
                  'Education', controller.selectedTeacher?.education),
              _buildKeyValueRow('Base Price',
                  controller.selectedTeacher?.basePrice.toString()),
              _buildKeyValueRow(
                  'Balance', controller.selectedTeacher?.balance.toString()),
              _buildKeyValueRow(
                  'Account Status', controller.selectedTeacher?.accountStatus),
              _buildKeyValueRow(
                  'Created at',
                  TimeFormat()
                      .formatDate(controller.selectedTeacher?.createdAt)),
              _buildKeyValueRow(
                  'Last Update at',
                  TimeFormat()
                      .formatDate(controller.selectedTeacher?.updatedAt)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text('$key :',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? '',
              maxLines: 5, // Display up to 5 lines before ellipsis
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
