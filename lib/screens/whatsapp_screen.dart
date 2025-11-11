import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

class WhatsappScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const WhatsappScreen({super.key, this.scaffoldKey});

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  String decryptedResponse = "Fetching data...";
  
  @override
  void initState() {
    super.initState();
    fetchLoginConfig();
  }

  Future<void> fetchLoginConfig() async {
    const url =
        "https://uatebpfapi.vibhutiinsurance.com/api/BCGModule/InsertAllLoginconfigData";

    final body = {"Action": "fetchloginconfig", "CorporateCode": "HOH"};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final encryptedResponse = response.body.replaceAll('"', '');
        final decryptedText = AesEncryption.decryptAES(encryptedResponse);
        setState(() {
          decryptedResponse = decryptedText;
        });
      } else {
        setState(() {
          decryptedResponse = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        decryptedResponse = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Login Config (AES)", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
          icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            decryptedResponse,
            style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
          ),
        ),
      ),
    );
  }
}
