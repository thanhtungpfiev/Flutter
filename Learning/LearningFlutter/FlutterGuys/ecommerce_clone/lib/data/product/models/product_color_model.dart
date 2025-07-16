// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductColorModel {
  final String title;
  final List<int> rgb;

  ProductColorModel({required this.title, required this.rgb});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'rgb': rgb};
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] as String,
      rgb: List<int>.from(map['rgb'].map((e) => e)),
    );
  }
}
