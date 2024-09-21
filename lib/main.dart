import 'package:shmart/shmart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(ProductController());
  runApp(const StartupWidget());
}

class StartupWidget extends StatefulWidget {
  const StartupWidget({super.key});

  @override
  State<StartupWidget> createState() => _StartupWidgetState();
}

class _StartupWidgetState extends State<StartupWidget> {
  @override
  Widget build(BuildContext context) {
    String initialRoute = homePage;
    // if (SharedPreferenceHelper().getString(SPKeys.username.toString()) != null) {
    //   initialRoute = homePage;
    // }
    return GetMaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: getRouteObject(context),
      initialRoute: initialRoute,
    );
  }
}
