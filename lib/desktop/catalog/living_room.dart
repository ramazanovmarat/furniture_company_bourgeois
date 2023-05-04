import 'dart:math';

import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore_gateway.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/const.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/detail/living_room_detail.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {

  final _client = FirestoreGateway(projectId);

  @override
  void initState() {
    super.initState();
    _loadLivingRoom();
  }

  List<Map<String, dynamic>> _livingRoom = [];

  void _loadLivingRoom() async {
    final collection = CollectionReference(_client, 'livingRoom');
    final documents = await collection.get();
    final livingRoom = documents.map((doc) => doc.map).toList();
    setState(() {
      _livingRoom = livingRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _livingRoom.isNotEmpty ? GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: _livingRoom.length,
          itemBuilder: (context, index) {
            final livingRoom = _livingRoom[index];
            return InkWell(
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LivingRoomDetail(livingRoom: livingRoom)));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FurnitureCacheImage(
                  height: 400,
                  width: 400,
                  imageUrl: livingRoom['image'],
                ),
              ),
            );
          }) : Center(child: CircularProgressIndicator(color: Color(Random().nextInt(0xffffffff)))),
    );
  }
}
