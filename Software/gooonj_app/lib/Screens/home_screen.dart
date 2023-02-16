import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gooonj_app/Screens/dispence_otp_screen.dart';

import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16,
          ),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Container(
                // color: Colors.amber,
                height: height * 0.25,
                width: width * 0.95,
                child: Stack(
                  children: [
                    SizedBox(
                      height: height * 0.25,
                      width: width * 0.95,
                      child: Image.asset(
                        'assets/png/Digital Card Gooonj.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '7f7r8e84',
                              style: TextStyle(
                                  fontFamily: "Outfit-Bold",
                                  fontSize: width * .06,
                                  color: Colors.white),
                            ),
                            Text(
                              'Sangita Kumari',
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                fontSize: width * .06,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Gooonj',
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                fontSize: width * .07,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Tap for user details',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: "Outfit-Regular",
                                fontSize: width * .04,
                                color: Colors.white,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Row(
              children: [
                Text(
                  'Sanitary Pads Withdrawls',
                  style: TextStyle(
                      fontFamily: "Outfit-SemiBold", fontSize: width * .06),
                ),
              ],
            ),
            SizedBox(
              height: height * .015,
            ),
            ListView.builder(
              itemCount: 4,
              itemBuilder:(BuildContext context,int index)=> ListTile(
                // tileColor:Colors.amber,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Place",
                  style: TextStyle(
                      fontFamily: "Outfit-Regular", fontSize: width * .06),
                ),
                subtitle: Text(
                  '27 Jan 5:23 PM',
                  style: TextStyle(
                      fontFamily: "Outfit-Regular", fontSize: width * .04),
                ),
                leading: CircleAvatar(
                  backgroundColor: mainRed,
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                ),
                trailing: Text(
                  '-2 Packets',
                  style: TextStyle(
                      fontFamily: "Outfit-Regular", fontSize: width * .05),
                ),
              ),

              shrinkWrap: true,
            ),
          ],),
        ),
      ),
      // Center(child: Text('home'),),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: height * .02),
        child: FloatingActionButton.extended(
          extendedTextStyle: buttonTextStyle,
          label: Text(
            'Get your pads',
          ),
          icon: Icon(Icons.health_and_safety_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DispenseOTPScreen(),),);
          },
          backgroundColor: floatingAction,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
