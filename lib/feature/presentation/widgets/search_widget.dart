import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, right: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 15)
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}