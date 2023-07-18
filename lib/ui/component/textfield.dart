import 'package:flutter/material.dart';
typedef MyValidator= String? Function(String?);
class textfield extends StatelessWidget {
String title;
TextEditingController controller=TextEditingController();
bool hideText;
TextInputType keyboardType;
MyValidator validator;

textfield({required this.title,this.hideText=false,required this.controller,required this.keyboardType,required this.validator,});

  @override
  Widget build(BuildContext context) {
    return
        TextFormField(controller: controller,
          obscureText: hideText,
          keyboardType:keyboardType ,
          validator: validator,
          decoration: InputDecoration(
          labelText: title,

        ),
    );
  }
}
