import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:panelafer/screen/auth/signup_screen.dart';
import 'package:panelafer/screen/create_barcode.dart';
import 'package:panelafer/screen/group_screen.dart';

import '../Compoands/constant_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirstGroup = true;
  bool isSecondGroup = false;
  bool isThirdGroup = false;
  bool isFourthGroup = false;
  bool createEmail = false;
  bool createBarCode = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt, AfeerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt = AfeerCuibt.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Control Panel Afeer',
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey.shade500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'Asset/Image/AferLogo.png',
                      height: 100,
                      width: 200,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cuibt.selectedYear = years[0];
                            isFirstGroup = true;
                            isSecondGroup = false;
                            isThirdGroup = false;
                            isFourthGroup = false;
                            createBarCode = false;
                          });
                        },
                        child: const Text(
                          'First Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cuibt.selectedYear = years[1];
                            isFirstGroup = false;
                            isSecondGroup = true;
                            isThirdGroup = false;
                            isFourthGroup = false;
                            createEmail = false;
                            createBarCode = false;
                          });
                        },
                        child: const Text(
                          'Second Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cuibt.selectedYear = years[2];
                            isFirstGroup = false;
                            isSecondGroup = false;
                            isThirdGroup = true;
                            isFourthGroup = false;
                            createEmail = false;
                            createBarCode = false;
                          });
                        },
                        child: const Text(
                          'Third Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cuibt.selectedYear = years[3];
                            isFirstGroup = false;
                            isSecondGroup = false;
                            isThirdGroup = false;
                            isFourthGroup = true;
                            createEmail = false;
                            createBarCode = false;
                          });
                        },
                        child: const Text(
                          'Fourth Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    if (cuibt.userModule!.isAdmin!)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isFirstGroup = false;
                              isSecondGroup = false;
                              isThirdGroup = false;
                              isFourthGroup = false;
                              createEmail = true;
                              createBarCode = false;
                            });
                          },
                          child: const Text(
                            'Create email',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cuibt.selectedYear = years[3];
                            isFirstGroup = false;
                            isSecondGroup = false;
                            isThirdGroup = false;
                            isFourthGroup = false;
                            createEmail = false;
                            createBarCode = true;
                          });
                        },
                        child: const Text(
                          'Create BarCode',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Expanded(
                  child: isFirstGroup
                      ? const GroupScreen(groupName: 'First Group')
                      : isSecondGroup
                          ? const GroupScreen(groupName: 'Second Group')
                          : isThirdGroup
                              ? const GroupScreen(groupName: 'Third Group')
                              : isFourthGroup
                                  ? const GroupScreen(groupName: 'Fourth Group')
                                  : createEmail
                                      ? const SignUp():
                                     createBarCode
                                         ? const CreateBarCode()
                                         : const Center())
            ],
          ),
        );
      },
    );
  }
}
