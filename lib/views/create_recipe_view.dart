import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe.dart';

class CreateRecipeView extends StatelessWidget {
  final RecipeController controller = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Resep Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Resep'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Bahan-bahan'),
            ),
            TextField(
              controller: stepsController,
              decoration: InputDecoration(labelText: 'Langkah-langkah'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newRecipe = Recipe(
                  id: '',
                  title: titleController.text,
                  ingredients: ingredientsController.text.split(','),
                  steps: stepsController.text.split(','),
                );

                await controller.addRecipe(newRecipe);
                Get.back(); // Navigate back to the previous page
              },
              child: Text('Simpan Resep'),
            ),
          ],
        ),
      ),
    );
  }
}
