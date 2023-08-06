import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/view_models/login_screen_view_model.dart';
import 'package:geekstack/view_models/splash_screen_view_model.dart';
import 'package:geekstack/view_models/upload_movie_view_model.dart';
import 'package:geekstack/views/screens/screen_splash.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GeekStackApp());
}

class GeekStackApp extends StatelessWidget {
  const GeekStackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenViewModel()),
        ChangeNotifierProvider(create: (context) => LoginScreenViewModel()),
        ChangeNotifierProvider(create: (context) => UploadVideoViewModel())
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'Geek Stack',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: primaryColor, background: backgroundColor),
                useMaterial3: true,
                fontFamily: 'Poppins'),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
