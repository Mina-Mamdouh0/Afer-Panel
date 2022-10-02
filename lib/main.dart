
import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/implementation/pure_dart.dart';
import 'package:firebase_dart/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/screen/spalsh_screen.dart';
import 'package:firedart/firedart.dart';
import 'Compoands/widget.dart';

void main()async {
  late var tokenStore = VolatileStore();
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize(projectId);
  FirebaseAuth.initialize(webApiKey, tokenStore);
  FirebaseDart.setup();
  var app=await Firebase.initializeApp(options: const FirebaseOptions(apiKey:"AIzaSyBFjlnI8vYjLFagHcjhUmlSD4aDwM5Jf40",appId: "1:164538397597:web:62889195f6be32e20db574", projectId: 'afeer-2ea3a',messagingSenderId: "164538397597",authDomain: "afeer-2ea3a.firebaseapp.com",storageBucket: "afeer-2ea3a.appspot.com", ));
  FirebaseStorage.instanceFor(app:app );
  DartVLC.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AfeerCuibt())
      ],
      child: MaterialApp(
        title: 'Admin Panel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:  const SplashScreen(),
      ),
    );
  }
}


