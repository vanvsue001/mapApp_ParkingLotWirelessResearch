import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'dart:convert';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

 // List _items = [];

  // Fetch content from the json file
  //Future<void> readJson() async {
    //final String response = await rootBundle.loadString('assets/sample.json');
    //final data = await json.decode(response);
    //setState(() {
      //_items = data["items"];
    //});
  //}

  @override
  void initState() {
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset('assets/uvu_map_updated.json',
        shapeDataField: 'NAME',
        dataCount: _mapData.length,
        primaryValueMapper: (int index) => _mapData[index].name,
        dataLabelMapper: (int index) => _mapData[index].buildingName,
        shapeColorValueMapper: (int index) => _mapData[index].color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: _shapeSource,
              showDataLabels: true,
              legend: const MapLegend(MapElement.shape),
              shapeTooltipBuilder: (BuildContext context, int index) {
              return Padding(
              padding: const EdgeInsets.all(7),
              child: Text(_mapData[index].buildingName,
              style: const TextStyle(color: Colors.white)));
              },
              tooltipSettings: MapTooltipSettings(color: Colors.blue[900]),
            )
          ],
        ),
      ),
    );
  }


  static List<MapModel> _getMapData() {
    return <MapModel>[
      MapModel('L10', 'L10', Colors.amber),
      MapModel('L9', 'L9', Colors.cyan),
      MapModel('N/A', 'N/A', Colors.pinkAccent),
      MapModel('UCAS Gym', 'UCAS Gym', Colors.red),
      MapModel('Melisa Nellesen Center for Autism', 'Melisa Nellesen Center for Autism', Colors.purple),
      MapModel('McKay Education', 'McKay Education', Colors.lightGreenAccent),
      MapModel('Utah County Academy of Science', 'Utah County Academy of Science', Colors.indigo),
      MapModel('Wolverine Service Center', 'Wolverine Service Center', Colors.lightBlue),
      MapModel('Hal Wing Track & Field', 'Hal Wing Track & Field', Colors.deepOrange),
      MapModel('L8', 'L8', Colors.purpleAccent),
      MapModel('L5', 'L5', Colors.greenAccent), MapModel('Northern Territory', 'Northern\nTerritory', Colors.lightGreen),
      MapModel('Victoria', 'Victoria', Colors.redAccent),
      MapModel('South Australia', 'South Australia', Colors.yellow),
      MapModel('Western Australia', 'Western Australia', Colors.indigoAccent),
      MapModel('Tasmania', 'Tasmania', Colors.blueGrey)
    ];
  }
}

class MapModel {
  MapModel(this.name, this.buildingName, this.color);

  String name;
  String buildingName;
  Color color;
  }

