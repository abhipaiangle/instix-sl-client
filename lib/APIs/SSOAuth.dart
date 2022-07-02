import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SSO extends StatefulWidget {
  const SSO({Key? key}) : super(key: key);

  @override
  State<SSO> createState() => _SSOState();
}

class _SSOState extends State<SSO> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0150b9),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: AUTH_URL,
              navigationDelegate: (navReq) {
                if (navReq.url.startsWith("https://smartlaundry.iitb/")) {
                  print("URLLL = " + navReq.url.toString());
                  Navigator.pop(context, navReq.url);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              // ------- 8< -------
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pop(context, "CANCELLED");
                    },
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        borderRadius,
                      ),
                    ),
                    fillColor: Colors.red,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
