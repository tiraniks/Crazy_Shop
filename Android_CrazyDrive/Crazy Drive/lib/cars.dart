import 'package:flutter/material.dart';

extension CustomColor on Color {
  static Color mainColor = const Color.fromRGBO(102, 103, 102, 1);
  static Color backgroundColor = const Color.fromRGBO(34, 34, 34, 1);
}

class Car {
  final int id;
  String name;
  String cost;
  String description;

  Car({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
  });
}

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  List<Car> cars() {
    return _CarsState().cars();
  }

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final _cars = [
    Car(
      id: 1,
      name: 'BMW',
      cost: '10000',
      description:
          '2012 3.0d   +380663486575',
    ),
    Car(
      id: 2,
      name: 'Audi',
      cost: '8000',
      description:
          '2009 year 3.0   +380503421769',
    ),
    Car(
      id: 3,
      name: 'Volvo',
      cost: '3500',
      description:
          '2006 year 1.5   +380662486754',
    ),
    Car(
      id: 4,
      name: 'Audi',
      cost: '5300',
      description:
          '1998 year 2.2   +380998529646',
    ),
    Car(
      id: 5,
      name: 'Opel',
      cost: '6000',
      description:
          '2003 year 2.0TDI   +380504334326',
    ),
  ];

  List<Car> cars() {
    return _cars;
  }

  var _filteredCars = <Car>[];

  final _searchController = TextEditingController();

  void _searchCars() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredCars = _cars.where((Car car) {
        return car.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredCars = _cars;
    }
    setState(() {});
  }

  void addCar(String name, String cost, String description) {
    _cars.add(Car(
     id: _cars.length + 1,
      name: name,
      cost: cost,
      description: description
    ));
  }

  void deleteCar(int index) {
    _cars.removeAt(index);
  }

  @override
  void initState () {
    super.initState();

    _filteredCars = _cars;
    _searchController.addListener(_searchCars);
  }

  void _onCarTap(int index) {
    final id = _cars[index].id;
    Navigator.of(context).pushNamed('/car_details', arguments: id);
  }

  final nameController = TextEditingController();
  final costController = TextEditingController();
  final descriptionController = TextEditingController();

  final editNameController = TextEditingController();
  final editCostController = TextEditingController();
  final editDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: const Text("Crazy Drive", style: TextStyle(
          fontSize: 27,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filteredCars.length,
            itemExtent: 190,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final car = _filteredCars[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(children: [
                  DecoratedBox(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.car_rental,
                              size: 45, color: Colors.white),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    car.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${car.cost} USD",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    car.description,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _onCarTap(index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.black, backgroundColor: Colors.grey[800]
                                        ),
                                        child: const Icon(Icons.brightness_5_outlined, color: Colors.white,),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          editNameController.text = car.name;
                                          editCostController.text = car.cost;
                                          editDescriptionController.text = car.description;
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (_) {
                                              return Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height * 0.7,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[800],
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(10),
                                                          topRight: Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const SizedBox(height: 20,),
                                                          Text("Edit ${car.name}", style: TextStyle(color: CustomColor.mainColor, fontWeight: FontWeight.bold, fontSize: 20),),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                                            child: TextField(
                                                              controller: editNameController,
                                                              style: const TextStyle(color: Colors.white),
                                                              decoration: InputDecoration(
                                                                hintText: "Name",
                                                                hintStyle: const TextStyle(color: Colors.white54),
                                                                border: const UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.white),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: CustomColor.mainColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                                            child: TextField(
                                                              controller: editCostController,
                                                              style: const TextStyle(color: Colors.white),
                                                              decoration: InputDecoration(
                                                                hintText: "Cost",
                                                                hintStyle: const TextStyle(color: Colors.white54),
                                                                border: const UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.white),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: CustomColor.mainColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                                            child: TextField(
                                                              controller: editDescriptionController,
                                                              style: const TextStyle(color: Colors.white),
                                                              decoration: InputDecoration(
                                                                hintText: "Description",
                                                                hintStyle: const TextStyle(color: Colors.white54),
                                                                border: const UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.white),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: CustomColor.mainColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _cars[index].name = editNameController.text;
                                                                _cars[index].cost = editCostController.text;
                                                                _cars[index].description = editDescriptionController.text;

                                                                Navigator.of(context).pop();

                                                                editNameController.clear();
                                                                editCostController.clear();
                                                                editDescriptionController.clear();
                                                              });
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: CustomColor.backgroundColor,
                                                            ),
                                                            child: Text('Save', style: TextStyle(color: CustomColor.mainColor)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black, backgroundColor: Colors.grey[800]
                                        ),
                                        child: const Icon(Icons.create_outlined, color: Colors.white,),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteCar(index);
                                          setState(() {
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black, backgroundColor: Colors.grey[800]
                                        ),
                                        child: const Icon(Icons.delete, color: Colors.red,),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 20,),
                                Text("Add New Car", style: TextStyle(color: CustomColor.mainColor, fontWeight: FontWeight.bold, fontSize: 20, ),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: TextField(
                                    controller: nameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: const TextStyle(color: Colors.white54),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: TextField(
                                    controller: costController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Cost",
                                      hintStyle: const TextStyle(color: Colors.white54),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: TextField(
                                    controller: descriptionController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: const TextStyle(color: Colors.white54),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: CustomColor.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (nameController.text != '' && costController.text != '' && descriptionController.text != '') {
                                        addCar(nameController.text, costController.text, descriptionController.text);
                                      }
                                      Navigator.of(context).pop();

                                      nameController.clear();
                                      costController.clear();
                                      descriptionController.clear();

                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColor.backgroundColor,
                                  ),
                                  child: Text('Add', style: TextStyle(color: CustomColor.mainColor)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                elevation: 0.0,
                foregroundColor: Colors.black,
                minimumSize: const Size(360, 59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.black)
                ),
              ),
              child: const Text('Add Car', style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
}