import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/flutter_email_sender.dart';
import 'package:driving_theory/extension/laucher_review.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

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
        Text('Infomation', style: TextStyle(color: Colors.white)),
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
                          'Dear all.\n I am ........ I would love to join in an A2 English Online Class. My availability: ......\nI am looking forward to hearing from you. Thanks and Best Regards',
                          subject: 'Book an A2 English Online Class',
                          recipients: ['kmsoftwareltd@gmail.com'],
                          isHTML: false, attachmentPaths: [],
                        );

                        FlutterEmailSender.send(email);
                      },
                      child: Text(
                        "BOOK YOUR A2 ONLINE CLASS",
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
}