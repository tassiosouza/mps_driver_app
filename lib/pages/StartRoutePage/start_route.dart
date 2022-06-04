import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class StartRoutePage extends StatelessWidget {
  const StartRoutePage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Start Route',
      home: StartRouteComponent(),
    );
  }
}

class Client {
  String name='';
  String phone='';
  String address='';

  Client();

  void _getDataFromLine(String line) {
    var endNameIndex = line.indexOf(')') + 1;
    name = line.substring(0, endNameIndex);
    log(name!);
    phone = line.substring(name!.length, name!.length + 13);
    log(phone!);
    address = line.substring(name!.length + phone!.length);
    log(address!);
  }
}

class StartRouteComponent extends StatefulWidget {
  const StartRouteComponent();
  @override
  _StartRouteComponentState createState() => _StartRouteComponentState();
}

class _StartRouteComponentState extends State<StartRouteComponent> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _filePath;
  List<Client> _clientList = [];
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;

    _filePath = _paths != null
        ? _paths!.map((e) => e.path).toList()[0].toString()
        : '...';

    final file = File(_filePath!);

    // Read the file
    Client client;
    await file
        .openRead()
        .map(utf8.decode)
        .transform(new LineSplitter())
        .forEach((l) => {
              client = Client(),
              client._getDataFromLine(l),
              _clientList.add(client),
            });

    log('client name 1: $_clientList');

    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
      _clientList = _clientList;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) => _isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator(),
                        )
                      : _userAborted
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: const Text(
                                'User has aborted the dialog',
                              ),
                            )
                          : _clientList.length > 0
                              ? Container(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  child: ListView(
                                      padding: EdgeInsets.all(8),
                                      children: _clientList
                                          .map((client) => ClientItem(client))
                                          .toList()))
                              : _saveAsFileName != null
                                  ? ListTile(
                                      title: const Text('Save file'),
                                      subtitle: Text(_saveAsFileName!),
                                    )
                                  : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pickFiles(),
        tooltip: 'Add Route',
        label: Row(
          children: [Icon(Icons.flag), Text('Start Route')],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ClientItem extends StatelessWidget {
  Client client;
  ClientItem(this.client, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client.name, style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(client.address),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
