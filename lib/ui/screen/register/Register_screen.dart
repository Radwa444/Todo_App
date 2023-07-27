import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/component/textfield.dart';
import 'package:todo/ui/component/dialog.dart';
import 'package:todo/ui/provider/AuthProvider.dart';
import 'package:todo/ui/screen/Login/Login_Screen.dart';
import 'package:todo/ui/database/model/User.dart' as MyUser;
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:todo/ui/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/provider/AuthProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Register_screen extends StatelessWidget {
  static const String routeName = 'register';
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  image: AssetImage('assets/images/SIGN IN – 1.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [Text('Register',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    textfield(
                        title: 'UserName',
                        controller: controllerName,
                        keyboardType: TextInputType.name,
                        validator: (controllerName) {
                          if (controllerName == null ||
                              controllerName.trim().isEmpty) {
                            return 'Enter UserName';
                          }
                          return null;
                        }),
                    textfield(
                        title: 'Email',
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Enter Email';
                          } else if (validateEmail(text) == false) {
                            return 'email is incorrect';
                          }
                          return null;
                        }),
                    textfield(
                        title: 'Password',
                        hideText: true,
                        controller: controllerPassword,
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Enter Password';
                          }
                          if (text.length < 6) {
                            return 'Enter valid password';
                          }
                        }),
                    textfield(
                        title: 'ConfirmPassword',
                        hideText: true,
                        controller: controllerConfirmPassword,
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Enter ConfirmPassword ';
                          }
                          if (controllerPassword.text != text) {
                            return 'Enter valid ConfirmPassword';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() == false) {
                              return;
                            }
                            dialog.dialogAwiat(context, 'loading..');
                            String massgeError =
                                "I succeeded in registering the account";
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                              var myUser=MyUser.User(id: credential.user?.uid,email: controllerEmail.text,name: controllerName.text);
                              MyDatabase.addUser(myUser);

                              var authProvider=Provider.of<AuthProvider>(context,listen: false);
                              authProvider.updateUser(myUser);
                              dialog.hidedialog(context);
                              dialog.showMassage(context, massgeError,
                                  positiveAction: 'ok',postive: (){
                                    Navigator.pushNamed(context, Home_screen.routeName);
                                  });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                dialog.hidedialog(context);
                                massgeError =
                                'The password provided is too weak.';
                                dialog.showMassage(context, massgeError,
                                    negativeAction: 'Try Again', negative: () {
                                      Register_screen();
                                    });
                              } else if (e.code == 'email-already-in-use') {
                                dialog.hidedialog(context);
                                massgeError =
                                'The account already exists for that email.';
                                dialog.showMassage(context, massgeError,
                                    positiveAction: 'ok');
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Text('Register')),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, login_screen.routeName);
                        },
                        child: const Text('sign in',
                            style:
                            TextStyle(fontSize: 16, color: Colors.black54)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}

