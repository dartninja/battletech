import 'dart:collection';
import 'package:quiver/collection.dart';

const Map<int, int> standardSkillLearnRates = {
  0: 20,
  1: 30,
  2: 50,
  3: 80,
  4: 120,
  5: 170,
  6: 230,
  7: 300,
  8: 380,
  9: 470,
  10: 570
};

class SkillSet extends DelegatingMap<Skill, SkillValue> {
  final Map<Skill, SkillValue> _l = <Skill, SkillValue>{};

  Map<Skill, SkillValue> get delegate => _l;

  void addXP(Skill skill, int xp) {
    SkillValue value;
    if (_l.containsKey(skill)) {
      value = _l[skill];
    } else {
      value = new SkillValue();
      _l[skill] = value;
    }
    value.XP += xp;
  }
}

class Skill {
  final String id;
  final String name;
  final Skill generalSkill;

  const Skill(this.id, this.name, [this.generalSkill = null]);

  String get fullName {
    if (generalSkill != null) return generalSkill.fullName + "/" + this.name;
    return this.name;
  }

  String toJson() => id;

  static Skill fromJson(String json) {
    return allSkills.firstWhere((e) => e.id == json, orElse: () => null);
  }

  String toString() => this.fullName;
}

class SkillValue {
  final Map<int, int> learnRate;

  int get level {
    int candidateLevel;
    for (int key in learnRate.keys) {
      if (learnRate[key] <= XP) {
        candidateLevel = key;
      } else {
        return candidateLevel;
      }
    }
    return null;
  }

  int XP = 0;

  SkillValue({this.learnRate = standardSkillLearnRates, this.XP = 0});
}

const Skill language = const Skill("language", "Language");
const Skill languageEnglish =
const Skill("languageEnglish", "English", language);
const Skill languageFrench =
const Skill("languageFrench", "French", language);
const Skill languageGerman =
const Skill("languageGerman", "German", language);
const Skill languageHindi =
const Skill("languageHindi", "Hindi", language);
const Skill languageRussian =
const Skill("languageRussian", "Russian", language);


const Skill perception = const Skill("perception", "Perception");

const Skill protocol = const Skill("protocol", "Protocol");
const Skill protocolFedSuns =
    const Skill("protocolFedSuns", "Fedsuns", protocol);

const Skill strategy = const Skill("strategy", "Strategy");


const List<Skill> allSkills = const <Skill>[
  languageEnglish,
  languageFrench,
  languageGerman,
  languageHindi,
  languageRussian,
  perception,
  protocolFedSuns
];

Iterable<Skill> get allLanguageSkills => allSkills.where((e)=>e.generalSkill==language);