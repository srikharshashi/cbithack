import 'dart:io';
import 'package:bloc_custom_firebase/constants.dart';
import 'package:bloc_custom_firebase/logic/authstatus_cubit/authstatus_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/image_cubit/image_cubit_dart_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  Future<File?> pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      File imgtemporary = File(image.path);
      return imgtemporary;
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image Permission")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, register_state) {
            return BlocBuilder<ImageCubitDartCubit, ImageCubitDartState>(
              builder: (context, state) {
                if (state is ImageCubitDartInitial) {
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              pickimage().then((file) {
                                if (file != null) {
                                  String name =
                                      (register_state as RegisterSuccess).name;
                                  context
                                      .read<ImageCubitDartCubit>()
                                      .uploadImage(file, name);
                                }
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Icon(FontAwesomeIcons.plus),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Select an Image")
                        ],
                      ),
                    ),
                  );
                } else if (state is ImageLoad) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.black,
                    ),
                  );
                } else if (state is Imagesuccess) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            child: Image.network(state.photoURL)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Image Uploaded"),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ImageCubitDartCubit>().registerindb(
                                  (register_state as RegisterSuccess).email,
                                  (register_state as RegisterSuccess).name,
                                  state.photoURL);
                            },
                            child: Text("Next"))
                      ],
                    ),
                  );
                } else if (state is RegisterinDBLoad) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.black,
                    ),
                  );
                } else if (state is RegisterDBComplete) {
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Registration complete"),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AuthstatusCubit>()
                                    .auth(state.name, state.email, state.URl);
                                Navigator.pushReplacementNamed(
                                    context, HOME_ROUTE);
                              },
                              child: Text("Next")),
                        ],
                      ),
                    ),
                  );
                } else
                  return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
