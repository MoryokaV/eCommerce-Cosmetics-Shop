class Product {
  int id;
  String name;
  int categoryID;
  String manufacter;
  double price;
  String imagePath;
  String shortDescription;
  String longDescription;

  Product({
    this.id,
    this.name,
    this.categoryID,
    this.manufacter,
    this.price,
    this.imagePath,
    this.shortDescription,
    this.longDescription,
  });
}

final List<Product> products = [
  Product(
    id: 1,
    name: "Gerovital H3",
    categoryID: 1,
    manufacter: "Gerovital",
    price: 50.00,
    imagePath: "assets/images/products/gerovitalH3.png",
    shortDescription: "Face care cream to protect your beautiful skin.",
    longDescription:
        "Prin formula grasă, onctuasă, bogată în uleiuri, ceruri şi grăsimi naturale cu mare putere de reconstrucţie şi prin complexul anti-age, crema previne şi atenuează semnele îmbătrînirii tenului înainte și după menopauză.Crema este dedicată tenului matur, uscat sau ridat.",
  ),
  Product(
    id: 2,
    name: "Kiss Hexa-Eyes",
    categoryID: 2,
    manufacter: "Kiss",
    price: 42.00,
    imagePath: "assets/images/products/kissHexaEyes.png",
    shortDescription: "Pigmented texture in a single application!",
    longDescription:
        "Nuantele din interior sunt perfect alese si formeaza un degrade cromatic. Nuantele deschise le poti aplica in interiorul pleoapei sau pe arcada, cele din mijloc sunt de tranzitie pentru a face trecerea intre culori sau pentru a estompa machiajul in pliu si exterior.",
  ),
  Product(
    id: 3,
    name: "Mascara Kiss Dead",
    categoryID: 2,
    manufacter: "Mascara",
    price: 38.00,
    imagePath: "assets/images/products/mascaraKissDead.png",
    shortDescription:
        "You can have the lashes you always wanted, in record time!",
    longDescription:
        "This mascara with 2 brushes gives you a greater depth of look and unlimited possibilities. Both brushes are fixed and help you polish the lashes from the base to the tips. Use the large toothbrush for the upper lashes and the thin one for the lower ones.",
  ),
  Product(    
    id: 4,
    name: "Techniques Blush",
    categoryID: 3,
    manufacter: "realTechniques",
    price: 51.00,
    imagePath: "assets/images/products/techniquesBlush.png",
    shortDescription:
        "Contours and defines the cheekbones for an HD result, perfectly blurred. The oval shape of the brush allows perfect sculpting of the face, but also a light application of the powder.",
    longDescription:
        "-Creates a perfect look even in the worst light.-Synthetic taklon threads are handmade, thus creating incredibly soft brushes, 100% cruelty free.-The construction of the brushes allows their positioning standing on any flat surface.-The aluminum handle is very light and thus allows easy use.",
  ),
  Product(
    id: 5,
    name: "Secret Key",
    categoryID: 1,
    manufacter: "Snail",
    price: 71.00,
    imagePath: "assets/images/products/snailSecretKey.png",
    shortDescription:
        "Cremă gel pentru fată cu o cantitate semnificativă de extract de de melc, ce oferă tenului tău un efect luminos.",
    longDescription:
        "Este un produs ideal și pentru pielea matură,  armonizează și hrănește pielea, hidratează și reglează procesele de apărare, făcând-o mai fermă și flexibilă în același timp.",
  ),
  Product(
    id: 6,
    name: "Sleek Lip Shot",
    categoryID: 4,
    manufacter: "Sleek",
    price: 51.00,
    imagePath: "assets/images/products/sleekLipShot.png",
    shortDescription: "################",
    longDescription:
        "This product is highly pigmented and offers maximum coverage in a single application. Its ingredients intensely moisturize the lips. Lip Shot Gloss is easy to wear, non-sticky and looks like a mirror. Enjoy the creamy explosion and the rich pigments that give a perfect definition to your lips.",
  ),
];
