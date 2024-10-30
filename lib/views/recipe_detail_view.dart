import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe.dart';
import 'create_recipe_view.dart';
import 'edit_recipe_view.dart';

class HomeView extends StatelessWidget {
  final RecipeController recipeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Log out logic here
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: recipeController.recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipeController.recipes[index];
            return ListTile(
              title: Text(recipe.title),
              onTap: () => Get.to(() => RecipeDetailView(recipe: recipe)), // Navigasi ke detail resep
              trailing: PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'edit') {
                    Get.to(() => EditRecipeView(recipe: recipe));
                  } else if (value == 'delete') {
                    recipeController.deleteRecipe(recipe.id);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit Recipe'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete Recipe'),
                    ),
                  ];
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRecipeDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addRecipeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Recipe'),
          content: CreateRecipeView(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class RecipeDetailView extends StatelessWidget {
  final RecipeController controller = Get.find();
  final Recipe recipe;

  RecipeDetailView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await controller.deleteRecipe(recipe.id);
              Get.back(); // Kembali ke halaman sebelumnya
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Bahan-bahan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: recipe.ingredients.length,
                itemBuilder: (context, index) {
                  return Text('- ${recipe.ingredients[index]}');
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Langkah-langkah:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: recipe.steps.length,
                itemBuilder: (context, index) {
                  return Text('${index + 1}. ${recipe.steps[index]}');
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => EditRecipeView(recipe: recipe));
              },
              child: Text('Edit Resep'),
            ),
          ],
        ),
      ),
    );
  }
}
