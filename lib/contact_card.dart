import 'package:flutter/material.dart';
import 'contact.dart';
import 'package:share/share.dart';

class ContactCard extends StatelessWidget {

  Contact contact;
  static bool timeFormat = true;
  ContactCard(this.contact);

  //this function is used to show "1 hour(s) ago" etc.
  String getTextDisplay() {

    DateTime checkin = contact.time;
    DateTime now = DateTime.now(); //current time
    String textDisplay;     //text display on contact list
    int numberDisplay = 0;
    String unitDisplay = "";    //string after number (e.g "day(s) ago")
    int yearDifference = now.year - checkin.year;
    int monthDifference = now.month - checkin.month;
    int dayDifference = now.day - checkin.day;
    int hourDifference = now.hour - checkin.hour;
    int minuteDifference = now.minute - checkin.minute;
    List <int> monthWith30Days = [4,6,9,11];
    List <int> monthWith31Days = [1,3,5,7,8,10,12];

    if (yearDifference == 0 && monthDifference == 0 && dayDifference == 0){
      if(hourDifference <= 1 && minuteDifference < 0) {
        print("minute called");
        numberDisplay = minuteDifference;
        unitDisplay = " minute(s) ago";
        if(minuteDifference < 0){
          numberDisplay = minuteDifference + 60;
        }
        if(numberDisplay == 0){
          numberDisplay += 1;
        }
      }else{
        numberDisplay = hourDifference;
        unitDisplay = " hour(s) ago";
        if(minuteDifference < 0){
          numberDisplay -= 1;
        }
      }
    }
    else if ((yearDifference == 1 && monthDifference == -11) || (monthDifference == 1 && dayDifference < 0) || (monthDifference == 0 && dayDifference > 0)){
      numberDisplay = dayDifference;
      unitDisplay = " day(s) ago";
      if(numberDisplay < 0 && monthWith31Days.contains(checkin.month)){
        numberDisplay += 31;
      }else if(numberDisplay < 0 && monthWith30Days.contains(checkin.month)){
        numberDisplay += 30;
      }else if(numberDisplay < 0 && checkin.month == 2){
        if(now.year % 4 == 0){
          numberDisplay += 29;
        }else{
          numberDisplay += 28;
        }
      }
      if(numberDisplay == 1){
        numberDisplay = 0;
        unitDisplay = "Yesterday";
      }
    }
    else if ((yearDifference == 1 && monthDifference < 0) || (yearDifference == 0 && monthDifference >= 1)) {
      numberDisplay = monthDifference;
      unitDisplay = " month(s) ago";
      if(monthDifference < 0){
        numberDisplay += 12;
      }if(dayDifference < 0){
        numberDisplay -= 1;
      }
    }
    else if (yearDifference >= 1){
      numberDisplay = yearDifference;
      if (monthDifference < 0) {
        numberDisplay -= 1;
      }
      unitDisplay = " year(s) ago";
    }

    if(numberDisplay == 0){
      textDisplay = unitDisplay;
    }else {
      textDisplay = numberDisplay.toString() + unitDisplay;
    }
    return textDisplay;
  }

  Widget buildCard(BuildContext context){
    String timeDisplayStyle;
    if(timeFormat){
      timeDisplayStyle = contact.time.toString();
    }else{
      timeDisplayStyle = getTextDisplay();
    }
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
              contact.name,
              style: TextStyle(
                  fontSize: 18
              )
          ),
          SizedBox(height:6),
          Row(
              children: <Widget>[
                Text(
                    contact.number,
                    style: TextStyle(
                        fontSize: 15
                    )
                ),
                SizedBox(width: 15),
                Text(
                    timeDisplayStyle,
                    style:TextStyle(
                        fontSize: 15
                    )
                ),
                SizedBox(width:10),
                TextButton(
                    onPressed:contact.toString().isEmpty
                        ? null
                        : () => onShareData(context),
                    child: Text('share'))
              ]
          )
        ],
      ),
    );
  }

  onShareData(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    {
      await Share.share(contact.toString(),
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildCard(context);
  }
}