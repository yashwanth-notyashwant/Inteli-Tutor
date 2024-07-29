import 'package:flutter/material.dart';
import 'package:intellitutor/Screens/course_section_list.dart';

class DistScreen extends StatefulWidget {
  final String? email;
  final String? courseName;
  final List<String> items;
  DistScreen({required this.items, this.email, this.courseName});

  @override
  State<DistScreen> createState() => _DistScreenState();
}

class _DistScreenState extends State<DistScreen> {
  //
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //

  @override
  Widget build(BuildContext context) {
    return
        // theme: ThemeData(
        //   colorScheme: const ColorScheme.dark(),
        //   useMaterial3: true,
        //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //     unselectedItemColor: Colors.white,
        //     selectedItemColor: Colors.white, // Color for the filled icon
        //   ),
        //   splashColor: Colors.transparent, // Disable splash color
        // ),
        Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // CourseListScreen(
          //   email: widget.email,
          //   itemColor2: widget.itemColor2,
          //   itemColor: widget.itemColor,
          //   numb: widget.numb,
          // ),
          //
          CourseSecionsScreen(
            courseName: widget.courseName!,
            email: widget.email!,
          ),
          SearchScreen(),
          NotificationsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: '',
            activeIcon: Icon(
              Icons.home_filled,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.quiz_outlined,
              size: 30,
            ),
            label: '',
            activeIcon: Icon(
              Icons.quiz,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pie_chart,
              size: 30,
            ),
            label: '',
            activeIcon: Icon(
              size: 30,
              Icons.pie_chart,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              size: 30,
            ),
            label: '',
            activeIcon: Icon(
              size: 30,
              Icons.person_2,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Screen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
