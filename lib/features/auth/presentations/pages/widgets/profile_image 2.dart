import 'dart:io';

import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _imageFile != null
          ? Container(
              alignment: Alignment.center,
              child: Circle(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(_imageFile!, fit: BoxFit.cover),
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(AssetFinder.icon('avatar'), height: 80),
            ),
    );
  }
}
