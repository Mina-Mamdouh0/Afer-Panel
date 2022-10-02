
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:uuid/uuid.dart';

class CreateBarCode extends StatefulWidget {
  const CreateBarCode({Key? key}) : super(key: key);

  @override
  _CreateBarCodeState createState() => _CreateBarCodeState();
}

class _CreateBarCodeState extends State<CreateBarCode> {

  bool isShowBarCode=false;
  var controller=TextEditingController();
  String uID='';
  @override
  Widget build(BuildContext context) {
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
                style:  TextStyle(
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
                    controller: controller,
                    hint: 'Add Price',
                    onTap: () {},
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),

                myButton(
                    text: 'Create',
                    width: 600.0,
                    height: 50.0,
                    onPressed: () {
                      setState(() {
                        isShowBarCode=true;
                        uID=const Uuid().v4();

                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                isShowBarCode?
                BarcodeWidget(
                  data:'$uID${controller.text}',
                  barcode: Barcode.qrCode(),
                  color: Colors.black,
                  height: 250,
                  width: 250,
                )
                    :Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
