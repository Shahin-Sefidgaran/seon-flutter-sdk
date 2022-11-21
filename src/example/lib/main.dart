import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:seon_plugin/seon_plugin.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _fingerPrintBase64 = "Fetching fingerprint...";
  var uuid = const Uuid();
  final _seonPlugin = SeonPlugin();

  @override
  void initState() {
    super.initState();
    getFingerPrint(sessionid: uuid.v1());
  }

  Future<void> getFingerPrint({required sessionid}) async {
    String fingerPrintBase64;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      fingerPrintBase64 = await _seonPlugin.getFingerPrintBase64(
              sessionId: sessionid, isLoggingEnabled: true) ??
          'Unknown fingerprint';
    } on PlatformException {
      fingerPrintBase64 = 'Failed to get fingerprint.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _fingerPrintBase64 = fingerPrintBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SEON Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Card(
            color: const Color.fromARGB(222, 222, 222, 222),
            margin: const EdgeInsets.all(15),
            elevation: 10,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(_fingerPrintBase64.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
