import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nayiswflut/components/buttons.dart';
import 'dart:io';

import 'package:nayiswflut/components/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;

  // sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Define your pages here
  final List<Widget> _pages = [
    const LoggedInPage(),
    const RealtimeDatabaseInsert(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 217, 217),
        elevation: 1,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Upload Image',
          ),
        ],
      ),
    );
  }
}

class LoggedInPage extends StatelessWidget {
  const LoggedInPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Logged in as ${user.email!}",
            style: const TextStyle(fontSize: 14, fontFamily: 'Monospace'),
          ),
        ),
        // Display user's images in small boxes
        Expanded(
          child: UserImagesList(userUid: user.uid),
        ),
      ],
    );
  }
}

class UserImagesList extends StatelessWidget {
  final String userUid;

  const UserImagesList({Key? key, required this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Image Details")
          .where("UserID", isEqualTo: userUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final documents = snapshot.data!.docs;

        if (documents.isEmpty) {
          return const Text("No images found.");
        }

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final imageUrl = documents[index]["Image"] as String;
            final imageName = documents[index]["Name"] as String;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        imageName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RealtimeDatabaseInsert extends StatefulWidget {
  const RealtimeDatabaseInsert({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseInsertState createState() => _RealtimeDatabaseInsertState();
}

class _RealtimeDatabaseInsertState extends State<RealtimeDatabaseInsert> {
  var nameController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  File? _image;

  List<String> imageUrls = []; // List to store image URLs

  @override
  void initState() {
    super.initState();
    // Fetch and set the user's image URLs when the widget is initialized
    fetchUserImageUrls();
  }

  // Fetch image URLs associated with the current user
  void fetchUserImageUrls() async {
    // Get the current user's UID
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Query Firestore to get image URLs associated with the user's UID
      final querySnapshot = await firestore
          .collection("Image Details")
          .where("UserID", isEqualTo: user.uid)
          .get();

      // Extract image URLs from the query results
      final List<String> urls =
          querySnapshot.docs.map((doc) => doc['Image'] as String).toList();

      // Set the image URLs in the state
      setState(() {
        imageUrls = urls;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Insert Image Details',
              style: TextStyle(fontSize: 28, fontFamily: 'Monospace'),
            ),
            GestureDetector(
              onTap: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: Container(
                height: 350,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Center(
                      child: _image == null
                          ? const Text('No image selected.')
                          : Image.file(_image!),
                    ),
                    Positioned(
                      child: Container(
                        width: 40,
                        height: 80,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldBox(
              controller: nameController,
              hintText: "Image Name",
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonBox(
              text: "Submit details",
              onTap: () async {
                if (nameController.text.isNotEmpty && _image != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                          "Are you sure you want to submit these details?",
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.amber),
                            ),
                            onPressed: () {
                              nameController.clear();
                              _image = null;
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.amber),
                            ),
                            onPressed: () async {
                              // Upload image file to Firebase Storage
                              var imageName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              var storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('user_images/$imageName.jpg');
                              var uploadTask = storageRef.putFile(_image!);
                              var downloadUrl =
                                  await (await uploadTask).ref.getDownloadURL();

                              // Add image data to Firestore with the user's UID
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                firestore.collection("Image Details").add({
                                  "UserID":
                                      user.uid, // Associate image with user
                                  "Name": nameController.text,
                                  "Image": downloadUrl.toString()
                                });
                              }

                              // Close the dialog and reset fields
                              Navigator.of(context).pop();
                              nameController.clear();
                              _image = null;
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            // Display user's images
            Column(
              children: imageUrls.map((url) {
                return Image.network(url);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
