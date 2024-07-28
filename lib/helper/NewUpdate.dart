import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class NewUpdate {
  String _downloadPath = '';

  NewUpdate(){
    setDownloadPath();
  }

  Future<bool> checkIsThereUpdate() async {
    var dio = Dio();
    bool isToUpdate = false;
    var response =await dio.get('https://node-api-vercel.onrender.com/getBuildNo');
      var latestVersionNo = response.data['build_no'];
      var currentPackageInfo = await PackageInfo.fromPlatform();
      print(latestVersionNo);
      print(currentPackageInfo.version);
      if (latestVersionNo != currentPackageInfo.version.toString()) {
        isToUpdate = true;
        print("Inside the if condition, isToUpdate: $isToUpdate");
      }
      return isToUpdate;
  }

  Stream<double> downloadUpdateApk() {
    StreamController<double> streamController = StreamController<double>();
    Stream<double> stream = streamController.stream.asBroadcastStream();
    if(_downloadPath == ''){
      setDownloadPath();
    }
    print('Current download Path while downloading is $_downloadPath');
    var dio = Dio();
    dio.download(
      'https://node-api-vercel.onrender.com/getApk',
      _downloadPath,
      onReceiveProgress: (count, total) {
        double progresValue = count / total;
        streamController.add(progresValue);
        print(progresValue);
      },
    );
    return stream;
  }

  void installApk() {
    InstallPlugin.install(_downloadPath);
  }
  
  Future<void> setDownloadPath() async {
    Directory directoryPath = await getApplicationDocumentsDirectory();
    _downloadPath = '${directoryPath.path}/a.apk';
  }
}


//https://github.com/jainil30/Flutter-UI-Task-Tushar-Jainil/tree/main/furniture_app/lib