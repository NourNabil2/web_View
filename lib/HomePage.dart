import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}
bool isloading = false;
class _WebPageState extends State<WebPage> {
  final webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..enableZoom(false)
    ..loadRequest(Uri.parse('https://ramezps.com/'));
  @override
  void initState() {
    webController.setNavigationDelegate(
        NavigationDelegate(
      onWebResourceError: (error) {
        if (error.errorType == WebResourceErrorType.hostLookup) {
          setState(() {
            isloading = true;
          });
        }
        else
          {
            setState(() {
              isloading = false;
            });
          }
      },
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    webController.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) {
        if (error.errorType == WebResourceErrorType.hostLookup) {
          setState(() {
            isloading = true;
          });
        }
        else
        {
          setState(() {
            isloading = false;
          });
        }
      },
    ));
    return SafeArea(
      child: Scaffold(
        body: isloading ? const Center(child:  CircularProgressIndicator(color: Colors.green,)) : WebViewWidget(controller: webController),
      ),
    );

  }
}
