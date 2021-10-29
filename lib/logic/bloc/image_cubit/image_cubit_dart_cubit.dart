import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_custom_firebase/services/fb_database.dart';
import 'package:bloc_custom_firebase/services/fb_storage.dart';

part 'image_cubit_dart_state.dart';

class ImageCubitDartCubit extends Cubit<ImageCubitDartState> {
  ImageCubitDartCubit() : super(ImageCubitDartInitial());

  void uploadImage(File file, String name) {
    emit(ImageLoad());
    FB_Storage().uploadFile(file, name).then((photoURL) {
      emit(Imagesuccess(photoURL: photoURL));
    });
  }

  void registerindb(String email, String name, String photoURL) async {
    emit(RegisterinDBLoad());
    bool status = await DatabaseService().adduser(name, email, photoURL);
    if (status) {
      emit(RegisterDBComplete(name: name, email: email, URl: photoURL));
    }
  }
}
