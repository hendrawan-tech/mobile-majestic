import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:majestic/config.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<PlatformFile>? _files;
  File? image;
  bool isLoading = false;

  void _openFileExporer() async {
    _files = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      allowedExtensions: null,
    ))!
        .files;
    setState(() {
      image = File(_files!.first.path.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthModel? user = authProvider.user;
    if (_nameController.text == "") {
      _nameController.text = user!.name!;
    }
    if (_phoneController.text == "") {
      if (user!.phoneNumber != null) {
        _phoneController.text = user.phoneNumber!;
      }
    }
    _emailController.text = user!.email!;

    handleUpdate() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.update(
        file: _files?.first.path,
        id: user.id.toString(),
        name: _nameController.text,
        phoneNumber: _phoneController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Update Berhasil!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/update-profile');
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Gagal update!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email Address",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  controller: _emailController,
                  enabled: false,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your email address",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget username() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter Username",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneNumber() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phone Number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter phone number",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonUpdate() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xFF73C993),
            borderRadius: BorderRadius.circular(10)),
        height: 48,
        width: double.infinity,
        child: TextButton(
          onPressed: handleUpdate,
          child: const Text(
            'Update',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    Widget buttonUpdateLoading() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xFF73C993),
            borderRadius: BorderRadius.circular(10)),
        height: 48,
        width: double.infinity,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Loading . . .',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xFF73C993),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  color: const Color(0xFF73C993),
                ),
                image == null
                    ? Positioned(
                        bottom: -50,
                        child: Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    user.profilePhotoPath == null
                                        ? user.profile.toString()
                                        : Config.url +
                                            '/' +
                                            user.profilePhotoPath.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Positioned(
                        bottom: -50,
                        child: Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF9FA3A2),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: _openFileExporer,
                  child: const Text(
                    'Pilih Foto',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  username(),
                  emailInput(),
                  phoneNumber(),
                  isLoading ? buttonUpdateLoading() : buttonUpdate(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
