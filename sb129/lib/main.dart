import 'package:flutter/material.dart';
import 'package:sb129/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sb129/services/services.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future main() async {
  //await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => HistTempService()),
        ChangeNotifierProvider(
            create: (_) => DoorService()),
        ChangeNotifierProvider(
            create: (_) => HumService()) //servicio de Historial
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SB-129',
        home: LoginScreen()
        // routes: {
        // 'temp': (context) => TempScreen(),
        // 'humedad': (context) => HumidityScreen(),
        // 'graph': (context) => GraphScreen(),
        // 'home': (context) => NavbarScreen(),
        // },
        // initialRoute: 'home'
    );  
  }
}
