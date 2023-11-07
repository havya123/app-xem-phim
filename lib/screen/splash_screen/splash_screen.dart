import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/provider/favourite_provider.dart';
import 'package:baitap08/provider/movie_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fectData();
  }

  void _fectData() async {
    await context.read<MovieProvider>().getMoviesNowPlaying();
    await context.read<MovieProvider>().getMoviesPopular();
    await context.read<MovieProvider>().getMoviesTopRated();
    await context.read<MovieProvider>().getMoviesUpComing();
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.loginRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: getHeight(context, height: 0.5),
          width: getWidth(context, width: 0.5),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/splash/splash_img.png")),
          ),
        ),
      ),
    );
  }
}
