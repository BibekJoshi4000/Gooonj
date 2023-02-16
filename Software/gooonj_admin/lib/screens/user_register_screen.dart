import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  TextEditingController name=TextEditingController();
  TextEditingController phno=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController gooonjID=TextEditingController();
  TextEditingController gooonjPIN=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color textgrey=Color(0xff595959);

    TextStyle headingstyle = TextStyle(
        fontFamily: 'Outfit-Regular',
        color: textgrey,
        fontSize: size.width * .055);

    TextStyle hintstyle =
        TextStyle(fontFamily: 'Outfit-Regular', fontSize: size.width * .04,color: textgrey);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Details',
              style: TextStyle(
                  fontFamily: 'Outfit-Bold', fontSize: size.width * .07),
            ),
            SizedBox(height: size.height*.02,),
            Container(
              padding: EdgeInsets.only(
                  top: size.height * .02,
                  left: size.width * .05,
                  right: size.width * .05,
                  bottom: size.width * .05),
              color: Color(0xffF7F7F7),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Details',
                    style: headingstyle,
                  ),
                  SizedBox(height: size.height*.006,),
                  Divider(color: Colors.grey),
                  SizedBox(height: size.height*.02,),
                  TextField(
                    controller: name,
                    decoration:InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Name',
                      hintStyle: hintstyle,
                      icon: Icon(Icons.person_outline),
                      iconColor: textgrey
                    ),
                  ),
                  SizedBox(height: size.height*.02,),
                  TextField(
                    controller: phno,
                    // decoration: ,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
