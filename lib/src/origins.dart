import 'package:battletech/src/skills.dart';
import 'package:battletech/src/attributes.dart';
import 'traits.dart';
import 'package:quiver/collection.dart';

class Package {
  final int cost;
  final Map<Attribute, int> bonusAttributes;
  final Map<Skill, int> bonusSkills;
  final Map<ATrait, int> bonusTraits;


  const Package(this.cost, {this.bonusAttributes=const{}, this.bonusSkills=const {}, this.bonusTraits = const {}});
}

class Affiliation extends Package {
  final String id;
  final String name;
  final List<Skill> secondaryLanguages;


  const Affiliation(this.id, this.name, this.secondaryLanguages, int cost,
      {Map<Attribute, int> bonusAttributes=const{}, Map<Skill, int> bonusSkills=const{},
      Map<ATrait, int> bonusTraits=const{}})
      : super(cost, bonusAttributes: bonusAttributes, bonusSkills: bonusSkills, bonusTraits: bonusTraits);

  String toJson() => id;

  static Affiliation fromJson(String value) => allAffiliations.keys.firstWhere((e)=>e.id==value,orElse: () => null);
  String toString() => this.name;
}

class SubAffiliation extends Package {
  final String id;
  final String name;
  final Affiliation affiliation;
  const SubAffiliation(this.id, this.name, this.affiliation,
      {Map<Attribute, int> bonusAttributes, Map<Skill, int> bonusSkills,
      Map<ATrait, int> bonusTraits=const{}})
      : super(0, bonusAttributes: bonusAttributes, bonusSkills: bonusSkills, bonusTraits: bonusTraits);

  String get fullName => affiliation.name + "/" + name;
  String toJson() => id;

  static SubAffiliation fromJson(String value) {
    for(var aff in allAffiliations.values) {
      for(var subAff in aff) {
        if(subAff.id==value)
          return subAff;

      }
    }
    return null;
  }
  String toString() => this.name;

}

class AffiliationOptions  {
  final Map<TraitChoice, ATrait> selectedTraits = {};

  AffiliationOptions();

  Map toJson() {
    var output = {};
    output["traits"] = {};
    for(var choice in selectedTraits.keys) {
      ATrait chosen = selectedTraits[choice];
      output["traits"][choice.id] = chosen;
    }

    return output;
  }
}


const Affiliation davion = const Affiliation("davion", "Davion",
    [languageFrench, languageGerman, languageHindi, languageRussian],
    150,
    bonusSkills: {protocolFedSuns: 10},
    bonusTraits: { const TraitChoice("davionAptitude",[
      const TraitParameterInstance<Skill>(naturalAptitude, protocol),
      const TraitParameterInstance<Skill>(naturalAptitude, strategy),
    ]): 100 });

const SubAffiliation draconisMarch = const SubAffiliation(
    "draconisMarch", "Draconis March", davion,
    bonusAttributes: {edge: 25},
    bonusTraits: {connections: 20}
);

const Map<Affiliation, List<SubAffiliation>> allAffiliations = {
  davion: [draconisMarch]
};
