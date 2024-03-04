import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:human_face_generator/drawing_screen.dart';
import 'package:human_face_generator/src/constants/colors.dart';
import 'package:human_face_generator/src/features/authentication/models/user_model.dart';
import 'package:human_face_generator/src/repository/authentication_repository/authentication_repository.dart';
import 'package:human_face_generator/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  bool isValidEmail(String email) {
    // Regular expression for email validation
    // You can customize this regex as per your requirements
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  Future<String?> registerUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
    return error;
  }

  Future<String?> phoneAuthentication(String phoneNo) async {
    String? error =
        await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    return error;
  }

  Future<void> createUser(UserModel user) async {
    String? error = await registerUser(user.email, user.password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: Duration(seconds: 3),
        backgroundColor: tPrimaryColor,
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
    if (error == null) {
      // String? error2 = await phoneAuthentication(user.phoneNo);
      // if (error2 != null) {
      //   Get.showSnackbar(GetSnackBar(
      //     message: error.toString(),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: tPrimaryColor,
      //     snackPosition: SnackPosition.BOTTOM,
      //   ));
      // }
      // if (error2 == null) {
      //   Get.to(() => const OTPScreen());
      //   await userRepo.createUser(user);
      // }
      //Get.to(() => const DrawingScreen());
      await userRepo.createUser(user);
      Get.to(() => const DrawingScreen());
    }
  }
}
