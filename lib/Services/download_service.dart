import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService{
  final url = "https://mundodasfigurinhas.com.br/tabela-copa-2022-download";

  Future<void> getDocument() async {
    await FlutterDownloader.registerCallback(HelpDownloadClass.callback);
    var status = await Permission.storage.request();
    if(status.isGranted){
      final baseStorage = await getExternalStorageDirectory();
      if(baseStorage != null){
        await FlutterDownloader.enqueue(url: url, savedDir: baseStorage.path,
            showNotification: true, openFileFromNotification: true,
            saveInPublicStorage: true);
      }
    }
  }

}

class HelpDownloadClass{
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}