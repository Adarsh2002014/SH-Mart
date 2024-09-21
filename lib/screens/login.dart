import 'package:shmart/shmart.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    try {
      // if(p.getString('username')!=null){
      //   username.text = p.getString('username');
      //   password.text = p.getString('password');
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              const ImageContainer(),
              Container(
                margin: const EdgeInsets.only(top: 320),
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  // color: Color(0xffFFF1D7),
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
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
                              applicationName,
                              style: TextStyle(
                                  color: mainSeedColor,
                                  fontSize: 38,
                                  fontFamily: 'Dashiki-Bold'),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        delay: const Duration(milliseconds: 700),
                        child: CusTextfield(
                          controller: username,
                          hintText: enterUsername,
                          prefixIcon: const Icon(Icons.person_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        delay: const Duration(milliseconds: 700),
                        child: CusTextfield(
                          controller: password,
                          hintText: enterYourPassword,
                          prefixIcon: const Icon(Icons.key_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        delay: const Duration(milliseconds: 700),
                        child: ElevatedButton(
                            onPressed: () {
                              checkCredentials();
                              // Navigator.pushNamed(context, "/menu");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainSeedColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 70),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            // color: const Color(0xffff7a40),
                            child: const Text(
                              login,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Dashiki-Bold'),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  checkCredentials() {
    //   print("username is ${username.text}");
    //   print("password is ${password .text}");
    //   var key = username.text;
    //   var value = password.text;
    //   if(db != null) {
    //     db.collection("validationKey").where(key,isEqualTo:value).get().then(
    //       (queryData){
    //         if (queryData.docs.length == 0) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(
    //               content: Text("Invalid Credentials"),
    //               duration: Duration(seconds: 2),
    //             ),
    //           );
    //         }else{
    //           p.setString('username', username.text);
    //           p.setString('password', password.text);
    //           p.setString('valid', "true");
    //           // Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false).then((_) => FadeInUp(child: Menu()).show(context));
    //           Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
    //             pageBuilder: (context, animation, secondaryAnimation) => Menu(p: p, dbobj: db,),
    //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //               const begin = Offset(0.0, 2.0);
    //               const end = Offset.zero;
    //               const curve = Curves.ease;
    //               var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    //               return SlideTransition(
    //                 position: animation.drive(tween),
    //                 child: child,
    //               );
    //             },
    //           ),(route) => false,);
    //         }
    //       }
    //     );
    //   }else{
    //     print("Database is null");
    //   }
  }
}
