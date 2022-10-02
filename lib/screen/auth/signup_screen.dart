import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:shimmer/shimmer.dart';

import '../../Compoands/constant_strings.dart';
import '../../Compoands/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    AfeerCuibt.get(context).getAllSubject(
        academicYear: AfeerCuibt.get(context).selectedYear,
        semester: AfeerCuibt.get(context).selectedSubjectSemester);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt, AfeerState>(
        listener: (context, state) {},
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;
          var cuibt = AfeerCuibt.get(context);
          return Scaffold(
            backgroundColor: Colors.grey,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  child: const Text("sign up",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700))),
            ),
            body: Center(
              child: myContainer(
                  height: size.height * .9,
                  width: size.width * .9,
                  child: Form(
                    key: cuibt.signUpFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.15,
                          width: size.width * 0.9,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) => categoryAvatar(
                                years[i], size, cuibt.selectedYear, cuibt),
                            separatorBuilder: (context, _) => SizedBox(
                              width: size.width * .2,
                            ),
                            itemCount: 4,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        myTextField(
                          controller: cuibt.nameControllerSignUp,
                          hint: "name",
                          auto: true,
                          prefix: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          label: "user name",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        myTextField(
                          controller: cuibt.emailControllerSignUp,
                          hint: "Email",
                          auto: true,
                          prefix: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          label: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        myTextField(
                          controller: cuibt.passwordControllerSignUp,
                          hint: "password",
                          label: "Password",
                          obscureText: true,
                          prefix: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffix: const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, i) => myCheckBox(
                                    name: cuibt.subjects[i].name,
                                    value: cuibt.checkAccess(cuibt.subjects[i].name!),
                                    index: i,
                                    cuibt: cuibt),
                                separatorBuilder: (context, _) =>
                                    const SizedBox(height: 5),
                                itemCount: cuibt.subjects.length)),
                        const SizedBox(
                          height: 15,
                        ),
                        myButton(
                          height: size.height * .06,
                          width: size.width * .06,
                          text: "Sign up",
                          onPressed: () => cuibt.createNewUser(context),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget myCheckBox({index, value, name, required AfeerCuibt cuibt}) {
    return CheckboxListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: value,
      onChanged: (access) => cuibt.setAccess(index, value, name),
      checkColor: Colors.black,
      activeColor: Colors.grey,
      checkboxShape: const StadiumBorder(
        side: BorderSide(color: Colors.black, width: 2),
      ),
    );
  }

  Column categoryAvatar(title, Size size, values, AfeerCuibt cuibt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            cuibt.selectedYear = title;
            cuibt.getAllSubject(
                academicYear: title, semester: cuibt.selectedSubjectSemester);
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: title == cuibt.selectedYear
                    ? Colors.teal
                    : Colors.redAccent.shade700,
                foregroundColor: Colors.white,
                child: CircleAvatar(
                  foregroundColor: Colors.white,
                  radius: 38.0,
                  backgroundColor: Colors.white,
                  child: Text(
                    "$title",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
