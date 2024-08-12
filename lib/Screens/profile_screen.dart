import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intellitutor/Models/AuthUser.dart';

import 'package:intellitutor/Providers/profile.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  List<int> score;
  final String emailId;
  ProfileScreen({required this.emailId, required this.score});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  AuthUser? User;
  bool _isMounted = false;
  int pivot = 0;

  @override
  void initState() {
    _isMounted = true;
    UserDataProvider instance = UserDataProvider();
    instance.getUserData(widget.emailId).then(
      (usersExists) {
        // check and traverse the list
        for (int i in widget.score) {
          if (i != -1) {
            pivot++;
          }
        }

        if (_isMounted) {
          setState(() {
            User = usersExists;
            isLoading = false;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: isLoading
            ? Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    size: 150,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      child: Stack(children: [
                        Positioned(
                          top: 0, // Start at the top of the column

                          child: Container(
                              color: Color.fromARGB(255, 248, 244,
                                  244), // matches the background oft he image dont change
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                top: 40,
                                bottom: 20,
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.4, // 1
                              width: MediaQuery.of(context).size.width,
                              child: pivot <= 3
                                  ? Image.asset(
                                      'lib/assets/noob.png',
                                      fit: BoxFit.cover,
                                    )
                                  : pivot <= 7
                                      ? Image.asset(
                                          'lib/assets/advanced.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'lib/assets/expert.png',
                                          fit: BoxFit.cover,
                                        )),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height *
                              0.36, // 2 , so do 1-2= d , a+b-d= height
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 12, 12, 12),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ), // Apply rounded edges
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                          ),
                        ),
                      ]),
                    ),
                    customTile(
                      icon: Icons.person_2_rounded,
                      title: 'Name:  ',
                      subtitle: User!.name.toString(),
                    ),
                    DividerWidget(),
                    customTile(
                      icon: Icons.email,
                      title: 'Email Id',
                      subtitle: widget.emailId,
                    ),
                    DividerWidget(),
                    customTile(
                      icon: Icons.numbers,
                      title: "Age",
                      subtitle: User!.age.toString(),
                    ),
                    DividerWidget(),
                    customTile(
                      icon: Icons.auto_graph_outlined,
                      title: "Milestone",
                      subtitle: pivot <= 3
                          ? "Rookie"
                          : pivot <= 7
                              ? "Intermediate"
                              : "Expert",
                    ),
                    DividerWidget(),
                    customTile(
                      icon: Icons.language,
                      title: "Language",
                      subtitle: User!.language.toString(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget customTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.black,
      padding: EdgeInsets.only(left: 20),
      child: ListTile(
        leading: Icon(
          icon,
          color: Color.fromARGB(255, 235, 235, 235),
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
        ),
      ),
    );
  }

  Widget DividerWidget() {
    return const Divider(
      thickness: 0.3,
      indent: 35,
      endIndent: 35,
    );
  }
}
