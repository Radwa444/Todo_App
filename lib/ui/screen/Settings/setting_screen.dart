import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/provider/AuthProvider.dart';

import '../../provider/LanganeProvider.dart';

class Settings_screen extends StatefulWidget {
  @override
  State<Settings_screen> createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  List<String> listlanguages = ["english", 'Arabic'];

  String Selected = 'english';

  @override

  Widget build(BuildContext context) {
    var proveter=Provider.of<AuthProvider>(context,);
    return Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'language',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: Selected,
                      items: listlanguages
                          .map((language) => DropdownMenuItem(
                        value: language,
                        child: Text(
                          language,
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                          .toList(),
                      onChanged: ( language) {
                        setState(() {
                          Selected=language!;
                          if(Selected=='english'){
                            proveter.changelanganeEN();
                          }else{
                            proveter.changelanganeAR();
                          }
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

