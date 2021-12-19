class Category {
  int id;
  String name;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

final List<Category> categories = [
  Category(
    id: 1,
    name: "Face Care",
    icon: "assets/images/categories/face_care.png",
  ),
  Category(
    id: 2,
    name: "Eye Makeup",
    icon: "assets/images/categories/eye_makeup.png",
  ),
  Category(
    id: 3,
    name: "Face Makeup",
    icon: "assets/images/categories/face_makeup.png",
  ),
  Category(
    id: 4,
    name: "Lips",
    icon: "assets/images/categories/lips.png",
  ),
];
