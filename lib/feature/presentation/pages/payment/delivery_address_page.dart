import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_details_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// String? locations;

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {

  MapController mapController = MapController();
  TextEditingController searchController = TextEditingController();
  List<Marker> markers = [];
  http.Client client = http.Client();
  final _formKey = GlobalKey<FormState>();

  Future<List<double>> getCoordinates(String query) async {
    final url = "https://nominatim.openstreetmap.org/search?q=$query&format=json";
    final response = await client.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    final lat = double.parse(jsonData[0]["lat"]);
    final lon = double.parse(jsonData[0]["lon"]);
    return [lat, lon];
  }

  void _searchLocation() async {
    List<double> coordinates = await getCoordinates(searchController.text);
      setState(() {
        markers = [
          Marker(
            point: LatLng(coordinates[0], coordinates[1]),
            builder: (BuildContext context) {
              return const Icon(Icons.location_pin, size: 30);
            },
          ),
        ];
        mapController.move(LatLng(coordinates[0], coordinates[1]), 12);
      });
  }

  void _submitData(String value) {
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
            key: _formKey,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: LatLng(42.9763800,47.5023600),
                    maxZoom: 18,
                    minZoom: 2,
                  ),

                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(markers: markers),
                  ],

                ),
                KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return isKeyboardVisible ? const SizedBox() : Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {
                              _submitData(searchController.text);
                            },
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                      );
                    }),
                Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
                        child: TextFormField(
                          onSaved: (value) {
                            searchController.text = value!;
                          },
                          validator: (value) {

                            if(value!.isEmpty) {
                              return 'Адрес не найден';
                            }
                            return null;
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Поиск',
                            prefixIcon: const Icon(Icons.search_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _searchLocation();
                            }
                            // String text = searchController.text;
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setString('location', text);
                            // setState(() {
                            //   locations = prefs.getString('location');
                            // });
                          },
                          child: const Text('Найти')
                      ),
                    ]),
              ],
            ),
          ),
    );
  }
}
