import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:convert';
import 'login.dart';
import 'screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String firstName = "";
  String lastName = "";
  DateTime dob = DateTime(2000);
  String gender = "Male";
  String email = "";
  String password = "";
  String city = "";
  String country = "";
  String imageFileString = "";

  late File chosenImageFile; //variable for choosed file
  Image profileImage =
      Image.asset('assets/no-profile-pic.png', fit: BoxFit.cover);

  Future<void> chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      chosenImageFile = File(choosedimage!.path);
      profileImage = Image.file(chosenImageFile, fit: BoxFit.cover);
      final bytes = chosenImageFile.readAsBytesSync();
      imageFileString = "data:image/jpeg;base64," + base64Encode(bytes);
    });
  }

  // Future<void> uploadImage() async {
  //   //show your own loading or progressing code here

  //   String uploadurl = "http://192.168.0.112/test/image_upload.php";
  //   //dont use http://localhost , because emulator don't get that address
  //   //insted use your local IP address or use live URL
  //   //hit "ipconfig" in windows or "ip a" in linux to get you local IP

  //   try {
  //     List<int> imageBytes = uploadimage.readAsBytesSync();
  //     String baseimage = base64Encode(imageBytes);
  //     //convert file image to Base64 encoding
  //     var response = await http.post(uploadurl, body: {
  //       'image': baseimage,
  //     });
  //     if (response.statusCode == 200) {
  //       var jsondata = json.decode(response.body); //decode json data
  //       if (jsondata["error"]) {
  //         //check error sent from server
  //         print(jsondata["msg"]);
  //         //if error return from server, show message from server
  //       } else {
  //         print("Upload successful");
  //       }
  //     } else {
  //       print("Error during connection to server");
  //       //there is error during connecting to server,
  //       //status code might be 404 = url not found
  //     }
  //   } catch (e) {
  //     print("Error during converting to Base64");
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }

  String getGenderLetter(String gender) {
    if (gender == "Male") return "m";
    if (gender == "Female") return "f";
    return "o";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FriendFinity"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              // First Name
                              Container(
                                width: screenWidth * 0.6,
                                padding: EdgeInsets.all(16.0),
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  key: Key('fname'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter First Name';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      firstName = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              // Last Name
                              Container(
                                width: screenWidth * 0.6,
                                padding: EdgeInsets.all(16.0),
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  key: Key('lname'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Last Name';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      lastName = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Profile Pic
                          GestureDetector(
                            onTap: chooseImage,
                            child: ClipOval(
                                child: SizedBox.fromSize(
                              size: const Size.fromRadius(70), // Image radius
                              child: profileImage,
                            )),
                          )
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Date of Birth
                        Container(
                          width: screenWidth * 0.52,
                          margin: const EdgeInsets.all(16.0),
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InputDatePickerFormField(
                            key: Key('dob'),
                            // The validator receives the text that the user has entered.
                            initialDate: dob,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2010),
                            fieldLabelText: "Date of Birth",
                            onDateSubmitted: (date) {
                              setState(() {
                                dob = date;
                              });
                            },
                            onDateSaved: (date) {
                              setState(() {
                                dob = date;
                              });
                            },
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        // Gender
                        Container(
                          width: 100,
                          margin: const EdgeInsets.all(16.0),
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButton(
                            key: Key('gender'),
                            // The validator receives the text that the user has entered.
                            value: gender,
                            items: <String>["Male", "Female", "Other"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                gender = newValue!;
                              });
                            },
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                      ],
                    ),
                    // Email
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: Key('email'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    // Password
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: Key('password'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            return "Password length should be greater than or equal to 8";
                          } else if (isAlpha(value) || isNumeric(value)) {
                            return "Password should contain both letters and numbers";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // City
                        Container(
                          width: screenWidth * 0.4,
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            key: Key('city'),
                            // The validator receives the text that the user has entered.
                            onChanged: (value) {
                              setState(() {
                                city = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "City",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.6,
                          padding: EdgeInsets.all(16.0),
                          child: TextFormField(
                            key: Key('country'),
                            // The validator receives the text that the user has entered.
                            onChanged: (value) {
                              setState(() {
                                country = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Country",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      margin: EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                          key: Key('submit'),
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              final response = await http.post(
                                Uri.parse(
                                    "https://friend-finity-backend.herokuapp.com/users/"),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'firstName': firstName,
                                  'lastName': lastName,
                                  'email': email.trim(),
                                  'password': password,
                                  'gender': getGenderLetter(gender),
                                  'dateOfBirth': dob.toString(),
                                  'city': city,
                                  'country': country,
                                  'profilePicURL': imageFileString
                                }),
                              );
                              if (response.statusCode == 201) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var userID =
                                    jsonDecode(response.body)['user']["_id"];
                                prefs.setString("userID", userID);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Sign up Success")),
                                );
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(userID: userID)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Sign up Error")),
                                );
                              }
                            }
                            // final response = await http.get(Uri.parse(
                            //     "https://friend-finity-backend.herokuapp.com/users"));
                            // print(jsonDecode(response.body)[0]['email']);
                          },
                          child: const Text('Sign Up'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))),
                    ),
                    Container(
                      width: 300,
                      height: 80,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          child: const Text(
                              "Already have an account? Click here to log in."),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
