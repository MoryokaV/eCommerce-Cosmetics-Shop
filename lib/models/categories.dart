class Category {
  int id;
  String name;
  String iconPath;

  Category({
    this.id,
    this.name,
    this.iconPath,
  });
}

final List<Category> categories = [
  Category(
    id: 1,
    name: "Face Care",
    iconPath: "assets/images/categories/face_care.png",
  ),
  Category(
    id: 2,
    name: "Eye Makeup",
    iconPath: "assets/images/categories/eye_makeup.png",
  ),
  Category(
    id: 3,
    name: "Face Makeup",
    iconPath: "assets/images/categories/face_makeup.png",
  ),
  Category(
    id: 4,
    name: "Lips",
    iconPath: "assets/images/categories/lips.png",
  ),
];
