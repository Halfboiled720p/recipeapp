import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe.dart';

class EditRecipeView extends StatelessWidget {
  final RecipeController controller = Get.find();
  final Recipe recipe;

  EditRecipeView({required this.recipe}) {
    titleController.text = recipe.title;
    ingredientsController.text = recipe.ingredients.join(',');
    stepsController.text = recipe.steps.join(',');
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Resep'),
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
              decoration: InputDecoration(labelText: 'Bahan-bahan (pisahkan dengan koma)'),
            ),
            TextField(
              controller: stepsController,
              decoration: InputDecoration(labelText: 'Langkah-langkah (pisahkan dengan koma)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedRecipe = Recipe(
                  id: recipe.id,
                  title: titleController.text,
                  ingredients: ingredientsController.text.split(','),
                  steps: stepsController.text.split(','),
                );

                await controller.updateRecipe(recipe.id, updatedRecipe);
                Get.back(); // Navigate back to the previous page
              },
              child: Text('Update Resep'),
            ),
          ],
        ),
      ),
    );
  }
}
