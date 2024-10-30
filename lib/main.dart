import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recipe_controller.dart';
import 'views/home_view.dart'; // Pastikan path ini sesuai dengan struktur proyek Anda

void main() async {
  // Pastikan binding widget sudah terinisialisasi sebelum memanggil Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Inisialisasi RecipeController sekali saja
  Get.put(RecipeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Mengatur tema aplikasi
      ),
      home: HomeView(), // Ganti dengan halaman utama aplikasi Anda
    );
  }
}
