class NewDetails {
  int id;
  String title;
  String content;
  String imageUrl;
  String url;
  Category category;
  Null author;
  Site site;
  String uploaded;
  List<Comment> comment;

  NewDetails(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.url,
      required this.category,
      required this.author,
      required this.site,
      required this.uploaded,
      required this.comment});

  factory NewDetails.fromJson(dynamic json) {
    // print(json);

    List<Comment> posts = [];
    if (json['results'] != null) {
      posts = (json['results'] as List).map((x) => Post.fromJson(x)).toList();
    }

    return PostResponse(
      posts: posts,
      nextUrl: json['next'],
      prevUrl: json['previous'],
    );
  }

  String postToJson(List<Post> data) {
    final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  NewDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['image_url'];
    url = json['url'];
    category:
    Category.fromJson(json["category"]);

    author = json['author'];
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    uploaded = json['uploaded'];
    if (json['comment'] != null) {
      comment = new List<Null>();
      json['comment'].forEach((v) {
        comment.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['author'] = this.author;
    if (this.site != null) {
      data['site'] = this.site.toJson();
    }
    data['uploaded'] = this.uploaded;
    if (this.comment != null) {
      data['comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String updatedAt;
  String createdAt;

  Category({this.id, this.name, this.updatedAt, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Site {
  String name;
  String logo;

  Site({this.name, this.logo});

  Site.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
