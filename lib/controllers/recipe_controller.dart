import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/recipe.dart';

class RecipeController extends GetxController {
  final recipes = <Recipe>[].obs;
  final firebaseFirestore = FirebaseFirestore.instance;

  // Fetch all recipes
  Future<void> fetchRecipes() async {
    try {
      final snapshot = await firebaseFirestore.collection('crud_resep').get();
      recipes.value = snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList();

      // Log untuk melihat data di konsol
      for (var recipe in recipes) {
        print("Recipe Title: ${recipe.title}");
        print("Ingredients: ${recipe.ingredients}");
        print("Steps: ${recipe.steps}");
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch recipes: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Add a new recipe
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await firebaseFirestore.collection('crud_resep').add(recipe.toMap());
      await fetchRecipes(); // Refresh data after adding
      Get.snackbar('Success', 'Recipe added successfully', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add recipe: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Update an existing recipe
  Future<void> updateRecipe(String id, Recipe updatedRecipe) async {
    try {
      await firebaseFirestore.collection('crud_resep').doc(id).update(updatedRecipe.toMap());
      await fetchRecipes(); // Refresh data after updating
      Get.snackbar('Success', 'Recipe updated successfully!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update recipe: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Delete a recipe
  Future<void> deleteRecipe(String id) async {
    try {
      await firebaseFirestore.collection('crud_resep').doc(id).delete();
      await fetchRecipes(); // Refresh data after deleting
      Get.snackbar('Success', 'Recipe deleted successfully!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete recipe: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecipes(); // Fetch recipes when controller is initialized
  }
}
