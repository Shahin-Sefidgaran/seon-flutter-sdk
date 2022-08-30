import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:seon_plugin/seon_plugin.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String? _fingerPrintBase64;
  final _seonPlugin = SeonPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getFingerPrint();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _seonPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getFingerPrint() async {
    String fingerPrintBase64;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      fingerPrintBase64 =
          await _seonPlugin.getFingerPrintBase64('', false) ??
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

  String decodebase64(String? fingerPrint) { //not used
    if (fingerPrint == null) {
      return "";
    }
    String decoded = utf8.decode(base64.decode(fingerPrint.split(";").last));
    return decoded;
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Center(
                child: Text(_fingerPrintBase64.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
