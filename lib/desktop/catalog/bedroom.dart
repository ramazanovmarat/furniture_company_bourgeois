import 'dart:math';

import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore_gateway.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/const.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/detail/bed_room_detail.dart';
import 'package:furniture_company_bourgeois/desktop/home.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';

class Bedroom extends StatefulWidget {
  const Bedroom({Key? key}) : super(key: key);

  @override
  State<Bedroom> createState() => _BedroomState();
}

class _BedroomState extends State<Bedroom> {

  final _client = FirestoreGateway(projectId);

  @override
  void initState() {
    super.initState();
    _loadBedRoom();
  }

  List<Map<String, dynamic>> _bedRoom = [];

  void _loadBedRoom() async {
    final collection = CollectionReference(_client, 'bedroom');
    final documents = await collection.get();
    final bedRoom = documents.map((doc) => doc.map).toList();
    setState(() {
      _bedRoom = bedRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bedRoom.isNotEmpty ? GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: _bedRoom.length,
          itemBuilder: (context, index) {
            final bedRoom = _bedRoom[index];
            return InkWell(
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => BedRoomDetail(bedRoom: bedRoom)));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FurnitureCacheImage(
                  height: 400,
                  width: 400,
                  imageUrl: bedRoom['image'],
                ),
              ),
            );
          }) : Center(child: CircularProgressIndicator(color: Color(Random().nextInt(0xffffffff)))),
    );
  }
}
