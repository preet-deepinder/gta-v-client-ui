class CharacterDataResModel {
  List<String>? fatherNames;
  List<String>? motherNames;
  List<String>? maleHairs;
  List<String>? femaleHairs;
  List<String>? eyes;

  CharacterDataResModel({
    this.fatherNames,
    this.motherNames,
    this.maleHairs,
    this.femaleHairs,
    this.eyes,
  });

  CharacterDataResModel.fromJson(dynamic json) {
    fatherNames = json['father_names'].cast<String>();
    motherNames = json['mother_names'].cast<String>();
    maleHairs = json['male_hairs'].cast<String>();
    femaleHairs = json['female_hairs'].cast<String>();
    eyes = json['eyes'].cast<String>();
  }
}
