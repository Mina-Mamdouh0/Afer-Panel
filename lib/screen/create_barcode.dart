import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/cuibt/states.dart';

import '../cuibt/cuibt.dart';

class CreateBarCode extends StatefulWidget {
  const CreateBarCode({Key? key}) : super(key: key);

  @override
  _CreateBarCodeState createState() => _CreateBarCodeState();
}

class _CreateBarCodeState extends State<CreateBarCode> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt, AfeerState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'BARCODE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                myTextField(
                    controller: AfeerCuibt.get(context).controller,
                    hint: 'Add Price',
                    onTap: () {},
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),

             Row(
               children: [
                 Expanded(
                   child: myButton(
                              text: 'Create',
                              width: 600.0,
                              height: 50.0,
                              onPressed: () {
                                AfeerCuibt.get(context).createNewBarCode();
                              }),
                 ),
                  const SizedBox(
                    width: 10,
                  ),
                 Expanded(
                   child: myButton(
                       text: 'Create premium qr',
                       width: 600.0,
                       height: 50.0,
                       onPressed: () {
                         AfeerCuibt.get(context).createPremiumCode();
                       }),
                 ),
               ],
             ),

                const SizedBox(
                  height: 20,
                ),
        AfeerCuibt.get(context).isShowBarCode?
                BarcodeWidget(
                  data: '${AfeerCuibt.get(context).uID} ${AfeerCuibt.get(context).controller.text}',
                  barcode: Barcode.qrCode(),
                  color: Colors.black,
                  height: 250,
                  width: 250,
                )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  },
);
  }
}
