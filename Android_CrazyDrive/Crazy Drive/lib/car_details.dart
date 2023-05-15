import 'package:flutter/material.dart';
import 'package:crazy_drive/cars.dart';

extension CustomColor on Color {
  static Color mainColor = const Color.fromRGBO(102, 103, 102, 1);
  static Color backgroundColor = const Color.fromRGBO(34, 34, 34, 1);
}

class CarDetails extends StatefulWidget {
  final int carId;
  const CarDetails({Key? key, required this.carId}) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  List<Car> cars = const Cars().cars();
  late int _carId;
  late final Car _car = cars[_carId-1];

  @override
  void initState() {
    super.initState();
    setState(() {
      _carId = widget.carId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_car.name, style: const TextStyle(
          fontSize: 22,
          color: Colors.grey,
          fontWeight: FontWeight.w800,
        ),),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 125, vertical: 40),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: CustomColor.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.car_rental,
                        size: 65, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: CustomColor.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Text("Cost: ${_car.cost} USD",
                        style:
                        const TextStyle(fontSize: 15, color: Colors.grey)),
                    const SizedBox(height: 20,),
                    Text("Description: ${_car.description}",
                        style:
                        const TextStyle(fontSize: 15, color: Colors.grey)),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[700],
    );
  }
}