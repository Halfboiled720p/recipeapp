import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import 'create_recipe_view.dart';
import 'edit_recipe_view.dart'; // Import the EditRecipeView

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
              // Navigate to login or registration page if needed
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
              trailing: PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'edit') {
                    // Navigate to the EditRecipeView with the selected recipe
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
    // Implement dialog to add a new recipe
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Recipe'),
          content: CreateRecipeView(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
