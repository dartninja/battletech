import 'package:battletech/src/skills.dart';
import 'package:battletech/src/attributes.dart';
import 'traits.dart';
import 'package:quiver/collection.dart';

const int secondaryLanguageBoost = 20;

class Package {
  final String id;
  final String name;

//  final int stage;
  final bool repeatable;

  final int cost;

  final List<Package> requiredPackages;
  final Map<Attribute, int> bonusAttributes;
  final Map<ASkill, int> bonusSkills;
  final Map<ATrait, int> bonusTraits;


  const Package(this.id, this.name, this.cost,
      {this.requiredPackages=const[],
        this.bonusAttributes=const{},
        this.bonusSkills=const {},
        this.bonusTraits = const {},
        this.repeatable = false
      });

  String toString() => this.name;
}


class PackageOptions  {
  final Map<TraitChoice, ATrait> selectedTraits = {};
  final Map<Skill, ASkill> selectedSkills = {};

  PackageOptions();

  Map toJson() {
    var output = {};
    output["traits"] = {};
    for(var choice in selectedTraits.keys) {
      ATrait chosen = selectedTraits[choice];
      output["traits"][choice.id] = chosen;
    }

    output["skills"] = {};
    for(var choice in selectedSkills.keys) {
      ASkill chosen = selectedSkills[choice];
      output["skills"][choice.id] = chosen;
    }

    return output;
  }
}


const Package davionAffiliation = const Package("davionAffiliation", "Davion", 150,
    bonusSkills: const <ASkill,int>{
      protocolFedSuns: 10,
      const SkillChoice("secondaryLanguage", const [languageFrench, languageGerman, languageHindi, languageRussian]): secondaryLanguageBoost
    },
    bonusTraits: const <ATrait,int>{ const TraitChoice("davionAptitude",[
      const TraitParameterInstance<Skill>(naturalAptitude, protocol),
      const TraitParameterInstance<Skill>(naturalAptitude, strategy),
    ]): 100 });

const Package draconisMarch = const Package(
    "draconisMarch", "Draconis March", 0,
    requiredPackages: const [davionAffiliation],
    bonusAttributes: {edge: 25},
    bonusTraits: {
      connections: 20,
      compulsionHatredOfDraconis: -30
    },
  bonusSkills: { arts: 10}
);

const List<Package> allPackages = const <Package>[
  davionAffiliation,
  draconisMarch
];