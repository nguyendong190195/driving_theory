

import 'dart:convert';
import 'dart:ui';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/extension/gallery_photo_view_wrapper.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {

   static getTitleAnswer(int index) {
    switch (index) {
      case 0:
        return 'A';
        break;
      case 1:
        return 'B';
        break;
      case 2:
        return 'C';
        break;
      case 3:
        return 'D';
        break;
    }
  }

   static void open(BuildContext context, GalleryExampleItem item) {
     Navigator.push(
       context,
       MaterialPageRoute(
         builder: (context) => GalleryPhotoViewWrapper(
           galleryItems: [item],
           backgroundDecoration: const BoxDecoration(
             color: Colors.black,
           ),
           initialIndex: 0,
           scrollDirection: Axis.horizontal,
         ),
       ),
     );
   }

   static TextStyle textStyleQuestionEn =
   TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
   static TextStyle textStyleQuestionVi = TextStyle(
       fontWeight: FontWeight.normal,
       fontSize: 15.0,
       fontStyle: FontStyle.italic);

   static TextStyle textStyleAnswerEn = TextStyle(
     fontWeight: FontWeight.bold,
     fontSize: 15.0,
   );
   static TextStyle textStyleAnswerEnWhite = TextStyle(
     fontWeight: FontWeight.bold,
     fontSize: 15.0,
     color: Colors.white
   );
   static TextStyle textStyleAnswerVi = TextStyle(
       fontWeight: FontWeight.normal,
       fontSize: 14.0,
       fontStyle: FontStyle.italic);

   static TextStyle textStyleAnswerViWhite = TextStyle(
       fontWeight: FontWeight.normal,
       fontSize: 14.0,
       color: Colors.white,
       fontStyle: FontStyle.italic);

   static TextStyle textStyleTitleAnswer = TextStyle(
       fontWeight: FontWeight.normal,
       fontSize: 18.0,
       fontStyle: FontStyle.normal,
       color: Colors.white);

  static Color getColorInSelect (ListQuestion question, int numAnswer) {
     if (!question.isSelected) {
       return HexColor.colorAnswerNormal();
     }else {
       if (question.answers[numAnswer].isSelected && question.answers[numAnswer].correct) {
         return HexColor.colorAnswerCorrect();
       }else if (question.answers[numAnswer].isSelected) {
         return HexColor.colorAnswerSelected();
       }else if (question.answers[numAnswer].correct) {
         return HexColor.colorAnswerCorrect();
       }
     }
     return HexColor.colorAnswerNormal();
   }

   static Color getColorInSelectBackgroundTitle (ListQuestion question, int numAnswer) {
     if (!question.isSelected) {
       return HexColor.mainColor();
     }else {
       if (question.answers[numAnswer].isSelected && question.answers[numAnswer].correct) {
         return Colors.white;
       }else if (question.answers[numAnswer].isSelected) {
         return Colors.white;
       }else if (question.answers[numAnswer].correct) {
         return Colors.white;
       }
     }
     return HexColor.mainColor();
   }

   static Color getColorInSelectTitle (ListQuestion question, int numAnswer) {
     if (!question.isSelected) {
       return Colors.white;
     }else {
       if (question.answers[numAnswer].isSelected && question.answers[numAnswer].correct) {
         return HexColor.mainColor();
       }else if (question.answers[numAnswer].isSelected) {
         return HexColor.mainColor();
       }else if (question.answers[numAnswer].correct) {
         return HexColor.mainColor();
       }
     }
     return Colors.white;
   }

   static Color getColorInSelectBorder (ListQuestion question, int numAnswer, bool isBorder) {
     if (!question.isSelected) {
         return HexColor.mainColor();
     }else {
       if (question.answers[numAnswer].isSelected && question.answers[numAnswer].correct) {
         if (isBorder) {
           return HexColor.colorAnswerCorrect();
         }else {
           return HexColor.mainColor();
         }

       }else if (question.answers[numAnswer].isSelected) {
         return HexColor.colorAnswerSelected();
       }else if (question.answers[numAnswer].correct) {

         if (isBorder) {
           return HexColor.colorAnswerCorrect();
         }else {
           return HexColor.mainColor();
         }
       }
     }
     if (isBorder) {
       return HexColor.colorAnswerNormal();
     }else {
       return HexColor.mainColor();
     }

   }

   static Future<bool> saveDataCacheByTopicName(Data data) async {
     try {
       SharedPreferences prefs= await SharedPreferences.getInstance();

       String dataStr = jsonEncode(data);
       prefs.setString('cacheData', dataStr);
       return true;
     } catch (e) {
       print(e);
       return false;
     }
   }

   static Future<Data> getDataCacheByTopicName() async {
     try {
       SharedPreferences prefs= await SharedPreferences.getInstance();
       String dataString =  prefs.getString('cacheData');
       if (dataString != null) {
        Data data = Data.fromJson(jsonDecode(dataString));
        return data;
       }
     } catch (e) {
       print(e);
     }
     return null;
   }

   static Future<bool> saveDataByName(DataTopic dataTopic) async {
     try {
       SharedPreferences prefs= await SharedPreferences.getInstance();
      dataTopic.title = '';
       String dataStr = jsonEncode(dataTopic);
       prefs.setString('nameTopic', dataStr);
       return true;
     } catch (e) {
       print(e);
       return false;
     }
   }

   static Future<DataTopic> getDataByName() async {
     try {
       SharedPreferences prefs= await SharedPreferences.getInstance();
       String dataString =  prefs.getString('nameTopic');
       if (dataString != null) {
         DataTopic data = DataTopic.fromJson(jsonDecode(dataString));
         return data;
       }
     } catch (e) {
       print(e);
     }
     return null;
   }



}

extension StringExtension on String {
  bool isNullOrEmpty() {
    if (this!= null && !this.isEmpty) {
      return false;
    }
    return true;
  }
}