import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamGalUI extends StatefulWidget {
  const CamGalUI({Key? key}) : super(key: key);

  @override
  _CamGalUIState createState() => _CamGalUIState();
}

class _CamGalUIState extends State<CamGalUI> {
  //สร้างตัวแปรเก็บรูปที่ได้จากการเลือก
  File? imageSelectedUse; //อย่าลืม import dart.io; ข้างบน

  //method คำสั่ง เปิดกล้อง
  Future selectImgFromCamera() async {
    final imageSelect =
        await ImagePicker().pickImage(source: ImageSource.camera);
    //ตรวจสอบว่าได้เลือกรูปหรือไม่
    if (imageSelect == null) {
      return;
    }
    //กรณีเลือกรูป ให้กำหนดรุปให้กับตัวแปรที่สร้างไว้เข้างบนเพื่อเอาไปใช้ในจุดอื่นๆ
    final imageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelectedUse = imageSelectPath;
    });
  }

  //method เปิดแกลลอลี่
  Future selectImgFromGallery() async {
    final imageSelect =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //ตรวจสอบว่าได้เลือกรูปหรือไม่
    if (imageSelect == null) {
      return;
    }
    //กรณีเลือกรูป
    final imageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelectedUse = imageSelectPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'CamGal KM',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    90.0,
                  ),
                  child: 
                  imageSelectedUse == null?
                  Image.asset(
                    'assets/images/logo.png',
                    width: 180.0,
                    height: 180.0,
                    fit: BoxFit.cover,
                  )
                  :
                  Image.file(
                    File (imageSelectedUse!.path),
                    width: 180.0,
                    height: 180.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      selectImgFromCamera();
                    },
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    label: Text(
                      'Camera',
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      selectImgFromGallery();
                    },
                    icon: Icon(
                      Icons.camera,
                    ),
                    label: Text(
                      'Gallery',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
