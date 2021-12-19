class Product {
  int id;
  String name;
  int categoryID;
  String manufacter;
  double price;
  String image;
  String shortDescription;
  String longDescription;

  Product({
    required this.id,
    required this.name,
    required this.categoryID,
    required this.manufacter,
    required this.price,
    required this.image,
    required this.shortDescription,
    required this.longDescription,
  });
}

final List<Product> products = [
  Product(
    id: 1,
    name: "Gerovital H3",
    categoryID: 1,
    manufacter: "Gerovital",
    price: 50.00,
    image: "assets/images/products/gerovitalH3.png",
    shortDescription: "Crema de fata menita sa iti protejeze tenul.",
    longDescription:
        "Crema este recomandata pentru îngrijirea pe timpul noptii, moment in care procesele de regenerare si nutrire sunt amplificate.  Are efect anti-age imediat si de durata, conţine ingredienti biomimetici (uleiuri, grasimi, ceruri naturale) cu mare putere de reconstrucţie a tenului matur.",
  ),
  Product(
    id: 2,
    name: "Kiss Hexa-Eyes",
    categoryID: 2,
    manufacter: "Kiss",
    price: 42.00,
    image: "assets/images/products/kissHexaEyes.png",
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
    image: "assets/images/products/mascaraKissDead.png",
    shortDescription:
        "Ofera genelor tale cu 95% mai multa alungire si curbare!",
    longDescription:
        "Are o periuta flexibila, din silicon, ce te ajuta sa rimelezi fiecare geana. Se aplica foarte usor, nu incarca inutil, iar rezistenta este de lunga durata. Cu varful periutei poti aplica mai multa cantitate pe gene, dupa care cu intreaga periuta separi si alungesti cu miscari in Zig-Zag. Intensitatea negrului este maxima si efectul oferit este inegalabil cu orice alt produs. Daca ai genele scurte si rare, acest rimel este perfect pentru tine.",
  ),
  Product(
    id: 4,
    name: "Techniques Blush",
    categoryID: 3,
    manufacter: "realTechniques",
    price: 51.00,
    image: "assets/images/products/techniquesBlush.png",
    shortDescription:
        "Pensula pentru fard de obraz.",
    longDescription:
        "Creaza un aspect perfect chiar si în cea mai slaba lumina. Firele sintetice de taklon sunt realizate manual, creand astfel perii incredibil de moi, 100% fara cruzime. Construcția periilor permite pozitionarea lor pe orice suprafata plana. Manerul din aluminiu este foarte usoara si astfel permite o utilizare usoara.",
  ),
  Product(
    id: 5,
    name: "Secret Key",
    categoryID: 1,
    manufacter: "Snail",
    price: 71.00,
    image: "assets/images/products/snailSecretKey.png",
    shortDescription:
        "Crema gel pentru fata cu o cantitate semnificativa de extract de de melc, ce ofera tenului tau un efect luminos.",
    longDescription:
        "Este un produs ideal si pentru pielea matura,  armonizeaza si hraneste pielea, hidrateaza si regleaza procesele de aparare, facand-o mai ferma si flexibila în acelasi timp.",
  ),
  Product(
    id: 6,
    name: "Sleek Lip Shot",
    categoryID: 4,
    manufacter: "Sleek",
    price: 51.00,
    image: "assets/images/products/sleekLipShot.png",
    shortDescription:
        "Bucura-te de explozia de culoare cremoasa si de pigmentii bogati care redau o definire perfecta buzelor tale.",
    longDescription:
        "Acest produs este foarte pigmentat si ofera o acoperire maxima dintr-o singura aplicare. Ingredientele sale hidrateaza intens buzele. Gloss-ul Lip Shot este usor de purtat, nu este lipicios si prezinta un aspect de oglinda.",
  ),
];
