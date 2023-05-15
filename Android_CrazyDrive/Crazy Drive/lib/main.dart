import 'package:flutter/material.dart';
import 'package:crazy_drive/cars.dart';
import 'package:crazy_drive/car_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[700])
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Cars(),
        '/car_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return CarDetails(carId: arguments);
          } else {
            return const CarDetails(carId: 0);
          }
        },
      },
    );
  }
}