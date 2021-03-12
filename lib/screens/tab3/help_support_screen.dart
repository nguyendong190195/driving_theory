import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/flutter_email_sender.dart';
import 'package:driving_theory/extension/laucher_review.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;

class HelpAndSupportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpAndSupportState();
  }

}

class _HelpAndSupportState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'images/ic_logo_app.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        fit: BoxFit.cover); //<- Creates a widget that displays an image.
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Help & Support', style: TextStyle(color: Colors.white)),
        backgroundColor: HexColor.mainColor(),
      ),
      body: Scaffold(
        backgroundColor: HexColor.colorBackGround(),
        body: Container(
          decoration: BoxDecoration(color: HexColor.colorBackGround()),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    child: ClipOval(
                      child: image,
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      color: HexColor.colorButton(),
                      minWidth: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        LaunchReview.launch(
                            androidAppId: "", iOSAppId: "1553850933");
                      },
                      child: Text(
                        "RATE US",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      color: HexColor.colorButton(),
                      textColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        final Email email = Email(
                          body:
                          'Dear all.\n I am ........ I would love to join in a driving theory class. My availability: ......\nI am looking forward to hearing from you. Thanks and Best Regards',
                          subject: 'Book a driving theory online class',
                          recipients: ['kmsoftwareltd@gmail.com'],
                          isHTML: false, attachmentPaths: [],
                        );

                        FlutterEmailSender.send(email);
                      },
                      child: Text(
                        "BOOK YOUR ONLINE CLASS",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                      color: HexColor.colorButton(),
                      textColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        // html.window.open('https://www.gov.uk/book-theory-test', 'name');
                        _makePhoneCall('https://www.gov.uk/book-theory-test');
                      },
                      child: Text(
                        "BOOK YOUR THEORY TESTS",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}