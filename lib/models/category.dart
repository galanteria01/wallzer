class Category {
  final int id;
  final String title;
  final String endpoint;
  final String imageURL;

  Category({this.id, this.title, this.endpoint, this.imageURL});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'endpoint': endpoint,
      'imageURL': imageURL
    };
  }
}