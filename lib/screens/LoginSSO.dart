import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/APIs/SSOAuth.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/screens/HomePage.dart';
import 'package:instix_sl_client/screens/NewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool validEmail = true;
bool validPass = true;
var _sub;
var sharedPreferences;

class LoginSSO extends StatefulWidget {
  const LoginSSO({Key? key}) : super(key: key);

  @override
  State<LoginSSO> createState() => _LoginSSOState();
}

class _LoginSSOState extends State<LoginSSO> {
  void checkLogin() async {
    bool _boxExists = await Hive.boxExists(AUTH_DATA);
  }

  @override
  void initState() {
    Hive.initFlutter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                SIGNIN,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      LOGIN_SSO_CONTINUE,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: RawMaterialButton(
                onPressed: () async {
                  var box = await Hive.openBox(AUTH_DATA);
                  var url = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SSO(),
                    ),
                  );
                  String code = Uri.parse(url).queryParameters["code"]!;
                  String AUTH_TOKEN =
                      "SEIzdGdlNXRuWUg1MXg2ZjhQRVh0WWNYQTdmM2hUNG9BbHlSajJZcDo0NW1ua0hPTUJoSWZFdG5UYnhsNzEwOTRYbGl3OERtZHRiZVRjdnVOQzl2dU9MckZRTzFiVHRlSkkwYjY0ckRxd2w1NWE4dzFHOHNCekFEaUZUa3Q0SDNkcVJWTnBaQ2VuUGp6aVlVNzZ0WXNuaE41dno4N3A3ZGxKUzlCSDVGcg==";
                  Response response = await post(
                    Uri.parse(GET_TOKEN_URL),
                    headers: {
                      "Authorization": "Basic ${AUTH_TOKEN}",
                      "Content-Type":
                          "application/x-www-form-urlencoded; charset=UTF-8",
                    },
                    body:
                        "code=${code}&redirect_uri=https://smartlaundry.iitb&grant_type=authorization_code",
                  );
                  print(response.body);
                  var response_map = json.decode(response.body);

                  await box.put(access_token_key, response_map["access_token"]);
                  await box.put(
                      refresh_token_key, response_map["refresh_token"]);
                  await box.close();
                  box = await Hive.openBox(AUTH_DATA);
                  Response profileRes = await get(
                    Uri.parse(RESOURCES_URL),
                    headers: {
                      "Authorization": "Bearer ${box.get(access_token_key)}"
                    },
                  );
                  await box.close();
                  print("RESPONSE LIST = ${profileRes.body}");
                  var jsonRes = json.decode(profileRes.body);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                ),
                fillColor: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    LOGIN_SSO,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
