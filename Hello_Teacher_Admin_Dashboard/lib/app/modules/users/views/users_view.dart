import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/data_count.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/my_fields.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/storage_details.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/dashboard/views/components/storage_info_card.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';
import 'package:hello_teacher_admin_dashboard/responsive.dart';

import '../controllers/users_controller.dart';

class Person {
  String name;
  String email;

  Person({required this.name, required this.email});
}

class UsersView extends GetView<UsersController> {
  UsersView({Key? key}) : super(key: key);
  List<Person> _people = [
    Person(name: 'John Doe', email: 'johndoe@example.com'),
    Person(name: 'Jane Doe', email: 'janedoe@example.com'),
    Person(name: 'Bob Smith', email: 'bobsmith@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listUser) {
          return SizedBox(
            height: 720,
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text('Name'),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Created At'),
                  ),
                  DataColumn(
                    label: Text('Role'),
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    listUser!.length,
                    (index) => DataRow(cells: [
                          DataCell(Text(listUser[index].displayName!)),
                          DataCell(Text(listUser[index].email!)),
                          DataCell(Text(listUser[index].createdAt.toString())),
                          DataCell(Text(listUser[index].role.toString())),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          )
                        ]))),
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
