import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/component/textfield.dart';
import 'package:todo/ui/component/dialog.dart';
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:todo/ui/screen/register/Register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/AuthProvider.dart';
import '../home/home_screen.dart';

class login_screen extends StatelessWidget {
  static const String routeName = 'login';

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [Text(AppLocalizations.of(context)!.login,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
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
                  const SizedBox(
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
                          String massage='You have successfully logged in';
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: controllerEmail.text,
                                    password: controllerPassword.text);

                          var UserId= await MyDatabase.readUser(credential.user?.uid??"");
                            var authProvider=Provider.of<AuthProvider>(context,listen: false);
                            authProvider.updateUser(UserId!);
                            print('----------------------------$UserId');
                            dialog.hidedialog(context);
                            dialog.showMassage(context,massage,
                                positiveAction: 'ok',postive: (){
                                  Navigator.pushNamed(context, Home_screen.routeName);
                                });

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              dialog.hidedialog(context);
                              massage = 'No user found for that email.';
                              dialog.showMassage(context, massage,
                                  positiveAction: 'ok',
                                  negativeAction: 'Try Again', negative: () {
                                login_screen();
                              });
                            } else if (e.code == 'wrong-password') {
                              dialog.hidedialog(context);
                              massage =
                                  'Wrong password provided for that user.';
                              dialog.showMassage(context, massage,
                                  positiveAction: 'ok');
                            }
                          }
                        },
                        child: Text('Login')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Register_screen.routeName);
                      },
                      child: const Text(
                        'I work account',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ))
                ],
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
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
