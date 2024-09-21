import 'package:shmart/shmart.dart';

class Menu {

  String? menuTitle;
  IconData? menuIcon;
  String? menuRoute;

  Menu({this.menuTitle, this.menuIcon, this.menuRoute});

  Menu.fromJson(Map<String, dynamic> json) {
    menuTitle = json['menuTitle'];
    menuIcon =  json['menuIcon'];
    menuRoute = json['menuRoute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuTitle'] = menuTitle;
    data['menuIcon'] = menuIcon;
    data['menuRoute'] = menuRoute;
    return data;
  }
}
