import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/res/photo_manger.dart';
import 'package:panelafer/screen/auth/forget_passwprd.dart';
import 'package:shimmer/shimmer.dart';

import '../../cuibt/cuibt.dart';
import '../../cuibt/states.dart';

class Login extends StatelessWidget {
  const Login({super.key});
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
                child: const Text("Login",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w700))),
          ),
          body: Center(
            child: myContainer(
                height: size.height * .8,
                width: size.width * .8,
                child: Row(
                  children: [
                    //Lift Container
                    SizedBox(
                      height: size.height * .8,
                      width: size.width * .35,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            PhotoManger.illustrationsLogin,
                            height: size.height * .7,
                            width: size.width * .2,
                            fit: BoxFit.scaleDown,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * .8,
                      width: 3,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    //Right Container
                    Expanded(
                      child: Form(
                        key: cuibt.loginFormKey,
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(PhotoManger.aferLogo),
                            ),
                            SizedBox(
                              height: size.height * .06,
                            ),
                            myTextField(
                              controller: cuibt.emailControllerLogin,
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
                            SizedBox(
                              height: size.height * .06,
                            ),
                            myTextField(
                              controller: cuibt.passwordControllerLogin,
                              hint: "password",
                              label: "Password",
                              obscureText: cuibt.isObscure,
                              prefix: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffix: IconButton(
                                  onPressed: () =>
                                      cuibt.togglePasswordVisibility(),
                                  icon: cuibt.isObscure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * .06,
                            ),
                            myButton(
                              height: size.height * .06,
                              width: size.width * .06,
                              text: "Login",
                              onPressed: () => cuibt.loginUser(context),
                            ),
                            const SizedBox(height: 15),
                            TextButton(
                                onPressed: () {navigator(context: context,returnPage: true,page:  ForgetPassword());},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
