import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shmart/screens/old_screens/menu.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  var dbobj, p;
  Login({super.key, this.dbobj, this.p});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var db, p;

  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
    p = widget.p;
    try{
      if(p.getString('username')!=null){
        username.text = p.getString('username');
        password.text = p.getString('password');
      }
    }catch(e){
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              imageCard(),
              loginCard(),
            ],
          )
        ],
      ),
    );
  }

  loginCard() {
    return Container(
      margin: const EdgeInsets.only(top: 320),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        // color: Color(0xffFFF1D7),
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      // height: 900,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FadeInUp(
                duration: const Duration(milliseconds: 900),
                delay: const Duration(milliseconds: 650),
                child: const Center(
                  child: Text(
                    "Login to SH Mart",
                    style: TextStyle(
                        color: Color(0xf2ff5000),
                        fontSize: 38,
                        fontFamily: 'Dashiki-Bold'),
                  ),
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 700),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    floatingLabelStyle:
                    const TextStyle(color: Colors.grey, fontSize: 18),
                    labelText: 'Username',
                    hintText: 'Enter you username',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 700),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(

                    prefixIcon: const Icon(
                      Icons.key_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: (Colors.grey[400])!),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    floatingLabelStyle: const TextStyle(color: Colors.grey),

                    labelText: 'Password',
                    hintText: 'Enter you password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 700),
              child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    checkCredentials();
                    // Navigator.pushNamed(context, "/menu");
                  },
                  color: const Color(0xffff7a40),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Dashiki-Bold'),
                  )),
            ),
          )
        ],
      ),
    );
  }

  imageCard() {
    return Container(
      // color: Color(0xffFFF1D7),
      color: const Color(0xffff7a40),
      height: 360,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: FadeInUp(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                          color: Color(0xfffffbf0),
                          borderRadius: BorderRadius.all(Radius.circular(120.0)),
                        ),
                      ),
                      Positioned(
                        top: 0, // Adjust for vertical centering (modify if needed)
                        left: 5, // Adjust for horizontal centering (modify if needed)
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          'assets/login-logo.png',
                          fit: BoxFit.cover, // Maintains aspect ratio, covering container
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  checkCredentials(){
    print("username is ${username.text}");
    print("password is ${password .text}");
    var key = username.text;
    var value = password.text;
    if(db != null) {
      db.collection("validationKey").where(key,isEqualTo:value).get().then(
        (queryData){
          if (queryData.docs.length == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Invalid Credentials"),
                duration: Duration(seconds: 2),
              ),
            );
          }else{
            p.setString('username', username.text);
            p.setString('password', password.text);
            p.setString('valid', "true");
            // Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false).then((_) => FadeInUp(child: Menu()).show(context));
            Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Menu(p: p, dbobj: db,),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 2.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),(route) => false,);
          }
        }
      );
    }else{
      print("Database is null");
    }
  }
}
