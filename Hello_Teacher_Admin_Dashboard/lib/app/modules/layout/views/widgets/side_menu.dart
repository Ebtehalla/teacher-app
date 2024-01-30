import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sidebarx/sidebarx.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {Key? key,
      required SidebarXController controller,
      required this.onItemSelected})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  final Function(int index) onItemSelected;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.white,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlue),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlueAccent),
          gradient: const LinearGradient(
            colors: [Colors.lightBlue, Colors.lightBlueAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            onItemSelected(0);
          },
        ),
        SidebarXItem(
            icon: Icons.people,
            label: 'Users',
            onTap: () {
              onItemSelected(1);
            }),
        SidebarXItem(
            icon: Icons.people,
            label: 'Teachers',
            onTap: () {
              onItemSelected(2);
            }),
        SidebarXItem(
            icon: Icons.people,
            label: 'Top Rated Teacher',
            onTap: () {
              onItemSelected(3);
            }),
        SidebarXItem(
            icon: Icons.category,
            label: 'Category',
            onTap: () {
              onItemSelected(4);
            }),
        SidebarXItem(
            icon: Icons.wallet,
            label: 'Transaction',
            onTap: () {
              onItemSelected(5);
            }),
        SidebarXItem(
            icon: Icons.money,
            label: 'Withdrawals',
            onTap: () {
              onItemSelected(6);
            }),
        SidebarXItem(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              onItemSelected(7);
            }),
      ],
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
