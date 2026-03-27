// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 1,
          title: Text("Training", style: KTextStyle.titleStyle),
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 30),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF4B5563),
            labelColor: Color(0xFF4B5563),
            dividerColor: Color(0xFFE5E7EB),
            unselectedLabelColor: Color(0xFFCACACA),
            tabs: [
              Tab(text: "Exercise", icon: Icon(Icons.person, size: 25)),
              Tab(text: "Coaches", icon: Icon(Icons.person_outline)),
            ],
          ),
        ),

        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Center(child: Text("Header")),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Item 1"),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Item 2"),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text("Tab 1 Content")),
                  Center(child: Text("Tab 2 Content")),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Training",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Programs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
