import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialog returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup, //call function on back button press
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make Scaffold background transparent
        body: Stack(
          children: [
            // Background image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/music-wallpapers.jpg'), // Use your image asset path here
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // App content
            Scaffold(
              appBar: AppBar(
                leading: const BackButton(
                  onPressed: null,
                ),
                title: const Text("Playing Now",
                    style: TextStyle(color: Colors.white60)),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 82, 163, 255)
                    .withOpacity(0.0), // Make AppBar transparent
                iconTheme: const IconThemeData(
                  color: Colors
                      .white60, // Change this to match the title text color
                ),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      // Handle the selected option
                      print(value);
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Option 1', 'Option 2', 'Option 3'}
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              backgroundColor: Colors
                  .transparent, // Make inner Scaffold background transparent
            ),
          ],
        ),
      ),
    );
  }
}
