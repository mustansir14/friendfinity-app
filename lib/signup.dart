import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import 'login.dart';

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

  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FriendFinity"),
      ),
      body: Center(
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
                              width: 225,
                              padding: EdgeInsets.all(16.0),
                              child: TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter First Name';
                                  }
                                  return null;
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
                              width: 225,
                              padding: EdgeInsets.all(16.0),
                              child: TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Last Name';
                                  }
                                  return null;
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
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(70), // Image radius
                            child: Image.asset('assets/no-profile-pic.png',
                                fit: BoxFit.cover),
                          ),
                        )
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Date of Birth
                      Container(
                        width: 200,
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InputDatePickerFormField(
                          // The validator receives the text that the user has entered.
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2010),
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
                          // The validator receives the text that the user has entered.
                          value: gender,
                          items: <String>["Male", "Female"]
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
                    width: 350,
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  // Password
                  Container(
                    width: 350,
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
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
                        width: 150,
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
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
                        width: 200,
                        padding: EdgeInsets.all(16.0),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
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
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          // if (_formKey.currentState!.validate()) {
                          //   // If the form is valid, display a snackbar. In the real world,
                          //   // you'd often call a server or save the information in a database.
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                          final response = await http.get(Uri.parse(
                              "https://friend-finity-backend.herokuapp.com/users"));
                          print(jsonDecode(response.body)[0]['email']);
                        },
                        child: const Text('Sign Up'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                  ),
                  Container(
                    width: 300,
                    height: 80,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text(
                            "Already have an account? Click here to log in."),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
