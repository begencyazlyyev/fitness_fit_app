// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer_widget.dart';
import 'package:flutter_application_1/view/pages/bookmark_page/bookmark_page.dart';
import 'package:flutter_application_1/view/pages/settings_page/settings_page.dart';
import 'package:flutter_application_1/view/pages/training_page/view_exercises.dart';
import 'package:flutter_application_1/components/navbar_widet.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_application_1/view/pages/history_page/history_page.dart';
import 'package:flutter_application_1/view/pages/profile_page/profile_page.dart';
import 'package:flutter_application_1/view/pages/programs_page/programs_page.dart';
import 'package:flutter_application_1/view/pages/training_page/training_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> pages = [
  TrainingPage(),
  ProgramsPage(),
  HistoryPage(),
  ProfilePage(),
  BookmarksPage(),
  SettingsPage(),
];
final List<String> pageTitles = [
  "Training",
  "Programs",
  "History",
  "Profile",
  "Bookmarks",
  "Settings",
];

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
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, int selectedPage, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              titleSpacing: 1,
              title: Text(
                pageTitles[selectedPage],
                style: KTextStyle.titleStyle,
              ),
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.menu, size: 30),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              bottom: selectedPage == 0
                  ? TabBar(
                      indicatorColor: Color(0xFF4B5563),
                      labelColor: Color(0xFF4B5563),
                      dividerColor: Color(0xFFE5E7EB),
                      unselectedLabelColor: Color(0xFFCACACA),
                      tabs: [
                        Builder(
                          builder: (context) {
                            // Access the controller from DefaultTabController
                            final TabController controller =
                                DefaultTabController.of(context);
                            return AnimatedBuilder(
                              animation: controller,
                              builder: (context, _) {
                                bool isSelected = controller.index == 0;
                                return Tab(
                                  text: "Exercises",
                                  icon: SvgPicture.asset(
                                    isSelected
                                        ? "assets/svg/dumbell.svg" // Your filled version
                                        : "assets/svg/dumbell-outlined.svg", // Your outline version
                                    width: 30,
                                    height: 30,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            final TabController controller =
                                DefaultTabController.of(context);

                            return AnimatedBuilder(
                              animation: controller,
                              builder: (context, _) {
                                bool isSelected = controller.index == 1;
                                return Tab(
                                  text: "Coaches",
                                  icon: SvgPicture.asset(
                                    isSelected
                                        ? "assets/svg/coach-filled.svg"
                                        : "assets/svg/coach-outlined.svg",
                                    width: 30,
                                    height: 30,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  : null,
            ),
            drawer: buildDrawer(context), // Cleaned up for readability
            body: viewExercises(selectedPage),
            bottomNavigationBar: const NavbarWidget(),
          ),
        );
      },
    );
  }
}
