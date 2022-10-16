
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/cuibt/states.dart';

import '../../cuibt/cuibt.dart';

class ShowPhoto extends StatelessWidget {

   ShowPhoto({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt,AfeerState>
      (
      listener: (context,state){},
      builder: (context,state){
        var cuibt= AfeerCuibt.get(context);
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
body: Expanded(
  child: ListView.separated(itemBuilder: (context,i)=>SizedBox(
    height: 500,
    width: 300,
    child: Image.network(cuibt.photos[i].linkPhoto!,fit: BoxFit.fill,),
  ),separatorBuilder: (context,i)=>const SizedBox(height: 20), itemCount: cuibt.photos.length),
)
        );
      },
    );
  }
}
