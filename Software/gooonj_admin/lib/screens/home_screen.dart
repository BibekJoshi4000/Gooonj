import 'package:flutter/material.dart';
import 'package:gooonj_admin/screens/user_register_screen.dart';
import 'package:gooonj_admin/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * .045,
                      bottom: size.height * .045,
                      right: size.width * .06,
                      left: size.width * .07),
                  decoration: containerDeco,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning,',
                            style: TextStyle(
                                fontFamily: 'Outfit-Medium',
                                fontSize: size.width * .05),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(
                            'Aakash Singh',
                            style: TextStyle(
                                color: mainRed,
                                fontFamily: 'Outfit-Bold',
                                fontSize: size.width * .08),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.store,
                                color: mainRed,
                              ),
                              Text(
                                'Hotspots : 5',
                                style: TextStyle(
                                    color: Color(0xff595959),
                                    fontFamily: 'Outfit-Regular',
                                    fontSize: size.width * .035),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: mainRed,
                              ),
                              Text(
                                'Users : 100',
                                style: TextStyle(
                                    color: Color(0xff595959),
                                    fontFamily: 'Outfit-Regular',
                                    fontSize: size.width * .035),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                TabBar(
                    indicatorColor: mainRed,
                    labelColor: mainRed,
                    labelStyle: TextStyle(
                      fontFamily: 'Outfit-Medium',
                    ),
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Outfit-Medium',
                    ),
                    tabs: [
                      // Text(data),
                      Tab(
                        text: 'Vending Machine Status',
                      ),
                      Tab(
                        text: "User's Q&A Feedback",
                      )
                    ]),
                SizedBox(
                  height: size.height * .02,
                ),
                SizedBox(
                  height: size.height * .65,
                  width: size.width,
                  child: TabBarView(children: [
                    machineStatusList(context, size),
                    qaList(context, size),
                  ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: size.height * .05),
          child: FloatingActionButton.extended(
            extendedTextStyle: TextStyle(
              fontFamily:'Outfit-Bold',
            ),
            label: Text(
              'New Registration',
            ),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRegisterScreen(),),);
            },
            backgroundColor: floatingAction,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget machineStatusList(context, Size size) {
    return ListView.builder(
      itemCount: 7,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => ListTile(
        leading: Image.asset(
          'assets/png/locationmarker.png',
          height: size.width * .095,
          width: size.width * .095,
        ),
        title: Text(
          'Rajdeep Nagar',
          style: TextStyle(
            fontFamily: 'Outfit-Regular',
            fontSize: size.width * .04,
          ),
        ),
        trailing: Text(
          '24/40',
          style: TextStyle(
              color: Colors.green,
              fontFamily: "Outfit-Bold",
              fontSize: size.width * .04),
        ),
      ),
    );
  }

  Widget qaList(context, Size size) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) => SizedBox(
        height: size.height * .18,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 10.0, right: 8, left: 8, top: 8),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: containerDeco,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  Text(
                    'Name : Geeta Singh',
                    style: TextStyle(
                      fontFamily: 'Outfit-Medium',
                      fontSize: size.width * .055,
                    ),
                  ),
                  Text(
                    'Contact Number : +91 xxxxx xxxxx',
                    style: TextStyle(
                      fontFamily: 'Outfit-Regular',
                      fontSize: size.width * .04,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Gooonj ID : 12345678',
                    style: TextStyle(
                      color: mainRed,
                      fontFamily: 'Outfit-Medium',
                      fontSize: size.width * .055,
                    ),
                  ),
                ]),
                Spacer(),
                Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: mainRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
