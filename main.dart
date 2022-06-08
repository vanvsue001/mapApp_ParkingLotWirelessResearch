import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Map App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _mapData = [];
    _zoomPanBehavior = MapZoomPanBehavior();
    super.initState();
  }

  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString('assets/uvu.json');
  }

  Future<bool> loadMapData() async {
    final String jsonString = await getJsonFromAssets();
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> feature = jsonResponse['features'];
    for (int i = 0; i < feature.length; i++) {
      _mapData.add(
          MapModel.fromJson(feature[i]['properties'] as Map<String, dynamic>));
      print(feature[i]['properties']);
    }

    _shapeSource = MapShapeSource.asset('assets/uvu.json',
        shapeDataField: 'NAME',
        dataCount: _mapData.length,
        primaryValueMapper: (int index) => _mapData[index].name!,
        dataLabelMapper: (int index) => _mapData[index].name!,
        shapeColorValueMapper: (int index) => _mapData[index].color);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          child: FutureBuilder<bool>(
              future: loadMapData(),
              builder: (context, snapdata) {
                if (snapdata.hasData) {
                  return SfMaps(
                    layers: [
                      MapShapeLayer(
                        source: _shapeSource,
                        zoomPanBehavior: _zoomPanBehavior,
                        showDataLabels: true,
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}

class MapModel {
  // Data type
  String? name;
  Color? color;

  //constructor
  MapModel({this.name, this.color});

  // Method that assigns values to respective datatype variables
  factory MapModel.fromJson(Map<String, dynamic> json) {
    Color modelColor = Colors.black;
    String modelName = json["NAME"];

    /// While fetching the color codes as String from JSON. Use these codes to convert it as Color.
    //String strColor = json['COLOR'] as String;
    //Color hexColor = Color(int.parse(strColor.substring(1, 7), radix: 16) + 0xFF000000);

    if(json["TYPE"] == "Parking Garage"){
      modelColor = Colors.red;
    }
    if(json["TYPE"] == "Student Parking"){
      modelColor = Colors.yellow;
    }
    if(json["TYPE"] == "Inside"){
      modelColor = Colors.white;
    }
    if(json["TYPE"] == "Grass"){
      modelColor = Colors.green;
    }
    if(json["TYPE"] == "Faculty Parking"){
      modelColor = Colors.purple;
    }
    if(json["TYPE"] == "Building"){
      modelColor = Colors.grey;
    }
    if(json["TYPE"] == "Visitor Parking"){
      modelColor = Colors.pinkAccent;
    }
    return MapModel(name: modelName, color: modelColor);
  }
}
