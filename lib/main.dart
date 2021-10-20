import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'contact.dart';
import 'dart:math';
import 'contact_list.dart';
import 'add_contact.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
  routes: {
    'add contact': (Context) => AddContact(),
    'home': (Context) => MyApp()
  },
));

 class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   static List <Contact> contacts = [
     Contact("Siti", "0176251436", 2021, 2, 3, 16, 16, 7),
     Contact("Lim Won Yang", "0192020384", 2020, 11, 20, 17, 46, 8),
     Contact("Ding Li Kang", "0162103748", 2021, 8, 7, 4, 14, 56),
     Contact("Muthu", "0192738229", 2021, 5, 15, 8, 6, 45),
     Contact("Hong Yau Wun", "0182738973", 2021, 10, 13, 15, 14, 16),
     Contact("Lim Kim Huat", "0192732638", 2020, 12, 3, 12, 16, 26),
     Contact("Kim Lee Wen", "0172632453", 2021, 7, 6, 4, 57, 59),
     Contact("Ong Kuan Kit", "0162536273", 2020, 11, 3, 11, 45, 52),
     Contact("Chin Kah Lun", "0112382736", 2021, 9, 6, 16, 52, 34),
     Contact("Tan Xin Yi", "0193030446", 2020, 7, 2, 14, 26, 13),
     Contact("Fong Yau Wen", "0133887946", 2020, 11, 2, 22, 6, 22),
     Contact("Peng Shao Lin", "0144879465", 2019, 1, 29, 18, 9, 24),
     Contact("Lai Shi Min", "0127054399", 2021, 7, 5, 14, 56, 7),
     Contact("Lin Shang Yan", "0134657551", 2019, 5, 21, 23, 6, 35),
     Contact("Hong Jin Yi", "0144552136", 2019, 4, 25, 6, 47, 23),
     Contact("Wong Wen Xiong", "0133254512", 2020, 10, 23, 23, 59, 34)
   ];

   static List <Contact> displayingContacts = [
     Contact("Chan Saw Lin", "0152131113", 2021, 10, 20, 10, 20, 7),
     Contact("Lee Saw Loy", "0161231346", 2021, 7, 8, 10, 7, 20),
     Contact("Khaw Tong Lin", "0158398109", 2021, 3, 21, 8, 9, 45),
     Contact("Lim kok Lin", "0168279101", 2021, 5, 30, 23, 7, 9),
     Contact("Low Jun Wei", "0112731912", 2021, 9, 21, 20, 30, 35),
     Contact("Yong Weng Kai", "0172332743", 2021, 4, 1, 16, 48, 50),
     Contact("Jayden Lee", "0191236439", 2021, 1, 2, 15, 6, 37),
     Contact("Kong Kah Yan", "0111931233", 2021, 2, 14, 17, 8, 55),
     Contact("Jasmine Lau", "0162879190", 2021, 9, 17, 19, 27, 49),
     Contact("Chan Saw Lin", "016783239", 2021, 8, 13, 13, 6, 52),
     Contact("Ali", "0182762937", 2021, 9, 18, 23, 28, 12),
     Contact("Chun-Li", "01625147293", 2020, 6, 27, 11, 14, 11),
     Contact("Alexander", "0182736890", 2021, 6, 23, 21, 34, 46),
     Contact("Ang Mee Leng", "0182273910", 2020, 12, 6, 23, 55, 45),
     Contact("Won Wan Ming", "0152413557", 2021, 3, 4, 15, 6, 7),
   ];
   _MyAppState createState() => _MyAppState();

 }
 class _MyAppState extends State<MyApp> {

   List<Contact> contacts = MyApp.contacts;
   List<Contact> displayingContacts = MyApp.displayingContacts;
   ScrollController controller = ScrollController();

   void showToast(String message) {
     Fluttertoast.showToast(
         msg: message,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.white,
         textColor: Colors.black,
         fontSize: 16.0);
   }

   Future loadList() async {
     var random = Random();
     int counter;
     for (counter = 0; counter < 5; counter++) {
       if (contacts.isEmpty) {
         break;
       }
       int index = random.nextInt(contacts.length);
       displayingContacts.add(contacts[index]);
       contacts.remove(contacts[index]);
     }
     if (counter == 0) {
       showToast("No more contact.");
     } else {
       setState(() {
         build(context);
         showToast(counter.toString() + " new contact(s) added.");
       });
     }
   }

   scrollListener() {
     if (controller.offset >= controller.position.maxScrollExtent &&
         !controller.position.outOfRange) {
       showToast("You've reached the bottom.");
     }
   }


   @override
   Widget build(BuildContext context) {
     print(DateTime.now());
     displayingContacts.sort((a, b) => b.time.compareTo(a.time));
     if (displayingContacts.isEmpty) {
       Center(child: CircularProgressIndicator());
     }
     return Scaffold(
       appBar: AppBar(
         title: Text('Contact List'),
         centerTitle: true,
       ),
       body: RefreshIndicator(onRefresh: loadList,
           child:
           ListView.builder(
               controller: controller,
               itemCount: 1,
               itemBuilder: (context, index) {
                 return Column(
                     children: displayingContacts.map((contact) =>
                         ContactList(contact)).toList()
                 );
               }
           )
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute<void>(
             builder: (BuildContext context) => const AddContact(),
           ),
           );
         },
         child: Icon(Icons.add),
       ),
     );
   }


   @override
   void initState() {
     controller = ScrollController();
     controller.addListener(scrollListener);
     super.initState();
   }
 }





