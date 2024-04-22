// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'blackScreen.dart';
import 'login_page.dart';
//import 'sputum.dart';
class SignupPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    try {
      String username = usernameController.text;
      String password = passwordController.text;

      // Create the user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username, // Use the email as the username
        password: password,
      );

      // User registration successful, navigate to the login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      // Handle errors here (e.g., email already in use)
      print("Error during registration: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 240, 249),
        title: Text(
          'Sign Up Page',
          style: TextStyle(
      color: Color.fromARGB(255, 8, 80, 82), // Change the color to your desired text color
    ),),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/background.png', // Change this to your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 8, 80, 82)),
                   
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    //labelText: 'Username (Email)',
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Username(Email)',
                      hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
            ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    //labelText: 'Password',
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    signUpWithEmailAndPassword(context); // Call signup function
                  },
                  style: ButtonStyle(
              // Increase the minimum size of the button
              minimumSize: MaterialStateProperty.all(Size(160, 60)),
              // You can customize other styles like background color, text color, etc.
              
            ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18.0),),

                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: 
                    Text(
                      'Already have an account? Click here to login',
                      style: TextStyle(fontSize: 15),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
