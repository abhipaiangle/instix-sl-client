import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instix_sl_client/constants.dart';

var box;
bool loaded = false;

class NewScreen extends StatefulWidget {
  var body;
  NewScreen({Key? key, required this.body}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  void initialize() async {
    setState(() {
      loaded = false;
    });
    box = await Hive.openBox(AUTH_DATA)
        .then((value) => box = Hive.box(AUTH_DATA));
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    (box as Box).close();
    super.dispose();
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
                "Signed In",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: (loaded)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "${access_token_key} = ${box.get(access_token_key)}}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "${refresh_token_key} = ${box.get(refresh_token_key)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            Container(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
