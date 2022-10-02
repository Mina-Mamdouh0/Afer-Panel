
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/cuibt/states.dart';

import '../../cuibt/cuibt.dart';

class ShowPhoto extends StatelessWidget {
  String url;

   ShowPhoto({Key? key,required this.url }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt,AfeerState>
      (
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.grey,size: 30,shadows: [Shadow(color: Colors.black,offset: Offset(1,1),blurRadius: 1)],),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
          ),
body: SizedBox(
  height: double.maxFinite,
  width: double.maxFinite,
  child: Image.network(url,fit: BoxFit.cover,),
),
        );
      },
    );
  }
}
