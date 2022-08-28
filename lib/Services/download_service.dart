import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService{
  final url = "https://mundodasfigurinhas.com.br/tabela-copa-2022-download";

  Future<void> getDocument() async {
    var status = await Permission.storage.request();
    if(status.isGranted){
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.initialize(debug: true);
      await FlutterDownloader.enqueue(url: url, savedDir: baseStorage!.path,
          showNotification: true, openFileFromNotification: true);
    }
  }

}