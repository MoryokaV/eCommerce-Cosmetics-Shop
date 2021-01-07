class Category {
  String name;
  String iconPath;

  Category({
    this.name,
    this.iconPath,
  });
}

final List<Category> categories = [
  Category(
    name: "Face Care",
    iconPath: "assets/images/categories/face_care.png",
  ),
  Category(
    name: "Eye Makeup",
    iconPath: "assets/images/categories/eye_makeup.png",
  ),
  Category(
    name: "Face Makeup",
    iconPath: "assets/images/categories/face_makeup.png",
  ),
  Category(
    name: "Lips",
    iconPath: "assets/images/categories/lips.png",
  ),
];
