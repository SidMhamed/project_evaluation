class Blog {
  final String title;
  final String auteur;
  final String image;
  final String contenu;

  Blog({
    required this.title,
    required this.auteur,
    required this.image,
    required this.contenu,
  });

  factory Blog.fromMap(Map<String, dynamic> data) => Blog(
        title: data['title'],
        auteur: data['auteur'],
        contenu: data['contenu'],
        image: data['image'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'auteur': auteur,
        'contenu': contenu,
        'image': image,
      };
}
