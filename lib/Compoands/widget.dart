import 'package:flutter/material.dart';
const String projectId="afeer-2ea3a";
const String webApiKey="AIzaSyBFjlnI8vYjLFagHcjhUmlSD4aDwM5Jf40";

Widget myContainer({required height,required width,Widget? child}){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color:Colors.teal[800]!,
          width: 3,
        )),
    height:height,
    width:width,
    child: child,
  );
}

Widget myTextField({auto=false,required controller,required String hint,label,prefix,suffix,keyboardType,obscureText=false,validator,onTap,enabled,onChanged,focusNode,onSubmitted,inputFormatters}) {
  return TextFormField(
    inputFormatters: inputFormatters,
    autofocus: auto,
    onFieldSubmitted: onSubmitted,
    obscuringCharacter: "*",
    focusNode: focusNode,

    enabled: enabled,
    onTap: onTap,
    onChanged: onChanged,
    style: const TextStyle(color: Colors.black),
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
        hintText: hint,
        hintStyle:const TextStyle(color: Colors.black),
        label: label!=null?Text("$label"):null,

        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.black,),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.red,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.black,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.black,),)
    ),
    obscureText: obscureText,
    validator: validator,

  );
}

Widget myButton({required height,required width,required text,onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
Future navigator({ page, context, returnPage=false}){
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> page),(Route route)=>returnPage);
}
