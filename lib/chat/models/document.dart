class Document {
  String? date;
  String? format;
  String? image;
  String? title;
  String? url;

  Document(
      {this.date,
      required this.format,
      this.image,
      required this.title,
      this.url});

  Document.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    image = json['image'];
    title = json['title'];
    url = json['url'];
  }
}
