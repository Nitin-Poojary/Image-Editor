class SavedImages {
  String? savedImagePath;

  SavedImages({required this.savedImagePath});

  Map toJson() => {
        "savedImagePath": savedImagePath,
      };

  SavedImages.fromJson(Map json) {
    savedImagePath = json['savedImagePath'];
  }
}
