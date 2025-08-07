class Recipe {
  final String title;
  final String imageUrl;
  final String summary;
  final List<String> instructions;
  final String spoonacularSourceUrl; // 👈 Add this

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.instructions,
    required this.spoonacularSourceUrl, // 👈 Add this
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'],
      imageUrl: map['image'],
      summary: map['summary'],
      instructions: (map['analyzedInstructions'] as List).isNotEmpty
          ? (map['analyzedInstructions'][0]['steps'] as List)
                .map<String>((step) => step['step'].toString())
                .toList()
          : [],
      spoonacularSourceUrl: map['spoonacularSourceUrl'] ?? '', // 👈 Add this
    );
  }
}
