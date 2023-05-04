import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/upload_image_to_storage.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/profile_cache_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:furniture_company_bourgeois/locator_service.dart' as di;

class EditProfile extends StatefulWidget {
  final UserEntity userEntity;
  const EditProfile({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController? _userNameController;

  @override
  void initState() {
    _userNameController = TextEditingController();
    super.initState();
  }

  bool _isUpdating = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if(pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text('Изменить профиль', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.clear), color: Colors.black),
        actions: [
          IconButton(
              onPressed: (){
                _updateUserProfileData();
              },
              icon: const Icon(Icons.done_rounded, color: Colors.black)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(
              child: Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(imageUrl: widget.userEntity.profileUrl, image: _image),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: selectImage,
                child: const Text(
                  "Изменить фото профиля",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Имя пользователя',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            const SizedBox(height: 15),
            _isUpdating == true ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Пожалйста подождите...", style: TextStyle(color: Colors.black)),
                SizedBox(width: 15),
                CircularProgressIndicator()
              ],
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  _updateUserProfileData() {
    setState(() => _isUpdating = true);
    if(_image == null) {
      _updateUserProfile("");
    } else {
      di.sl<UploadImageToStorageUseCase>().call(_image!, false, "profileImages").then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {
    BlocProvider.of<GetSingleUserCubit>(context).updateUser(
        userEntity: UserEntity(
          uid: widget.userEntity.uid,
          name: _userNameController!.text,
          profileUrl: profileUrl
        ),
    ).then((value) {
      _clear();
    });
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _userNameController!.clear();
    });
    Navigator.pop(context);
  }

}

