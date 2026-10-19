class DiseaseInfo {
  final String id;
  final String name;
  final String nameSwahili;
  final String nameAmharic;
  final String description;
  final String descriptionSwahili;
  final String descriptionAmharic;
  final String causes;
  final String symptoms;
  final String treatment;
  final String prevention;
  final String imageUrl;

  const DiseaseInfo({
    required this.id,
    required this.name,
    required this.nameSwahili,
    required this.nameAmharic,
    required this.description,
    required this.descriptionSwahili,
    required this.descriptionAmharic,
    required this.causes,
    required this.symptoms,
    required this.treatment,
    required this.prevention,
    required this.imageUrl,
  });

  String localizedName(String languageCode) {
    switch (languageCode) {
      case 'sw':
        return nameSwahili;
      case 'am':
        return nameAmharic;
      default:
        return name;
    }
  }

  String localizedDescription(String languageCode) {
    switch (languageCode) {
      case 'sw':
        return descriptionSwahili;
      case 'am':
        return descriptionAmharic;
      default:
        return description;
    }
  }

  factory DiseaseInfo.fromJson(Map<String, dynamic> json) => DiseaseInfo(
        id: json['id'],
        name: json['name'],
        nameSwahili: json['nameSwahili'] ?? json['name'],
        nameAmharic: json['nameAmharic'] ?? json['name'],
        description: json['description'],
        descriptionSwahili: json['descriptionSwahili'] ?? json['description'],
        descriptionAmharic: json['descriptionAmharic'] ?? json['description'],
        causes: json['causes'],
        symptoms: json['symptoms'],
        treatment: json['treatment'],
        prevention: json['prevention'],
        imageUrl: json['imageUrl'] ?? '',
      );
}
