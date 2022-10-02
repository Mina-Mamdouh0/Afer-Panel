import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:shimmer/shimmer.dart';

import '../../Compoands/widget.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: Colors.grey,
appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.white,
            child: const Text("Forget Password",
                style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.w700))),
),
      body: Center(
        child: myContainer(
          height: size.height * .8,
          width: size.width * .8,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              LottieBuilder.asset(
                "Asset/Image/ForgetPassword.json",
                animate: true,
                height: size.height * .3,
                width: size.width * .3,
              ),
              SizedBox(
                height: size.height * .05,
              ),
              BlocBuilder<AfeerCuibt, AfeerState>(
                bloc: AfeerCuibt.get(context),
                buildWhen: (previous, current) {
                  if (current is ForgetPasswordSuccessfully) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  return myTextField(
                    controller: emailController,
                    hint: "Enter your email",
                    auto: true,
                    suffix: IconButton(onPressed: ()=>context
                        .read<AfeerCuibt>()
                        .forgetPassword(email: emailController.text,context: context  ), icon: const Icon(Icons.send,color: Colors.teal,)),
                    onSubmitted: (v) => context
                        .read<AfeerCuibt>()
                        .forgetPassword(email: v,context: context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
