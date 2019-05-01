import 'package:quiver/collection.dart';
import 'attributes.dart';
import 'traits.dart';
import 'shared.dart';

enum SkillActionRating {
  S,C
}
enum SkillTrainingRating {
  B,A
}

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

class SkillSet extends DelegatingList<SkillInstance> {
  final List<SkillInstance> _l = <SkillInstance>[];

  List<SkillInstance> get delegate => _l;

  SkillInstance find(ASkill skill) {
    return this.firstWhere((e)=>e.skill==skill, orElse: () => null);
  }

  void addXP(ASkill skill, int xp) {
    var instance = this.find(skill);

    if (instance==null) {
      instance = new SkillInstance(skill);
      this.add(instance);
    }
    instance.xp += xp;
  }

}

abstract class ASkill {
//  String get fullName;
//  bool get tiered;
  bool get requiresChoice;

  const ASkill();
}

class Skill<T> extends ASkill {
  final String id;
  final String name;
  final SkillActionRating _actionRating;
  final SkillTrainingRating _trainingRating;
  final List<Attribute> _linkedAttributes;
  final List<T> subSkills;
  final bool freeFormSubSkill;


  final int _targetNumber;

  bool get tiered => _advancedTargetNumber!=null;
  bool get requiresChoice => freeFormSubSkill||subSkills.isNotEmpty;

  const Skill(this.id, this.name, this._targetNumber, this._actionRating, this._trainingRating,
      this._linkedAttributes, {this.subSkills, this.freeFormSubSkill = false}):
        _advancedTargetNumber = null,
        _advancedLinkedAttributes = null,
        _advancedActionRating = null;

  final int _advancedTargetNumber;
  final SkillActionRating _advancedActionRating;
  final List<Attribute> _advancedLinkedAttributes;


  const Skill.Tiered(this.id, this.name,
      this._targetNumber, this._actionRating, this._linkedAttributes,
      this._advancedTargetNumber, this._advancedActionRating, this._advancedLinkedAttributes
      , {this.subSkills, this.freeFormSubSkill = false}):
      _trainingRating = SkillTrainingRating.B;


  String get fullName {
    return this.name;
  }

  String toJson() => id;

  static Skill fromJson(String json) {
    return allSkills.firstWhere((e) => e.id == json, orElse: () => null);
  }

  String toString() => this.fullName;

}

class SubSkill<T> extends ASkill {
  final Skill<T> skill;
  final T subSkill;

  bool get requiresChoice => false;


  bool get tiered => skill.tiered;

  String get fullName => skill.fullName + "/" + enumToString(subSkill);

  const SubSkill(this.skill, this.subSkill);

  String toString() => fullName;

  Map toJson() => {skillField: skill, subSkillField: enumToString(subSkill)};

  static const String skillField = "skill";
  static const String subSkillField = "subSkill";
}

class SkillChoice  extends ASkill {
  final String id;
  final List<ASkill> choices;

  bool get requiresChoice => true;

  const SkillChoice(this.id, this.choices);

  String toJson() => this.id;
}

class SkillInstance {
  final ASkill skill;
  final String specialty;

  int xp = 0;

  int getTargetNumber(LearningSpeed learnRate) {
    if(skill is Skill) {
      Skill sk = skill as Skill;
      if (sk.tiered) {
        if (calculateLevel(learnRate) <= 3) {
          return sk._targetNumber;
        } else {
          return sk._advancedTargetNumber;
        }
      } else {
        return sk._targetNumber;
      }
    }
  }

  SkillInstance(this.skill, {this.specialty});

  int calculateLevel(LearningSpeed learnRate) {
    var learningScale;
    switch(learnRate) {
      case LearningSpeed.Normal:
        learningScale = standardSkillLearnRates;
        break;
      default:
        throw new Exception("Learning speed not supported: $learnRate");
    }

    int candidateLevel;
    for (int key in learningScale.keys) {
      if (learningScale[key] <= xp) {
        candidateLevel = key;
      } else {
        break;
      }
    }

    return candidateLevel;
  }

  String toString() {
    if((specialty??"").isEmpty) {
      return skill.toString();
    } else {
      return "${skill.toString()} ($specialty)";
    }
  }

}

class SkillValue {
  final Map<int, int> learnRate;

  int XP = 0;

  SkillValue({this.learnRate = standardSkillLearnRates, this.XP = 0});
}

const Skill<String> arts = const Skill<String>.Tiered("art", "Art",
  8, SkillActionRating.C, [dexterity],
  9, SkillActionRating.C, [dexterity, intelligence], freeFormSubSkill: true);


enum Language {
  English,
  French,
German,
Hindi,
Russian
}

const Skill<Language> language = const Skill<Language>("language", "Language", 8,
    SkillActionRating.S, SkillTrainingRating.A,
    [intelligence, charisma], subSkills: [
      Language.English,
      Language.French,
      Language.German,
      Language.Hindi,
      Language.Russian
    ]);
const SubSkill<Language> languageEnglish = const SubSkill<Language>(language, Language.English);
const SubSkill<Language> languageFrench = const SubSkill<Language>(language, Language.French);
const SubSkill<Language> languageGerman = const SubSkill<Language>(language, Language.German);
const SubSkill<Language> languageHindi = const SubSkill<Language>(language, Language.Hindi);
const SubSkill<Language> languageRussian = const SubSkill<Language>(language, Language.Russian);


const Skill perception = const Skill("perception", "Perception", 7, SkillActionRating.S, SkillTrainingRating.B,
  [intelligence]);

enum Protocol {
  FedSuns
}
const Skill<Protocol> protocol = const Skill<Protocol>("protocol", "Protocol", 9, SkillActionRating.C, SkillTrainingRating.A,
  [willpower, charisma], subSkills: [
    Protocol.FedSuns
  ]);
const SubSkill<Protocol> protocolFedSuns = const SubSkill<Protocol>(protocol, Protocol.FedSuns);


const Skill strategy = const Skill("strategy", "Strategy", 9,SkillActionRating.C, SkillTrainingRating.A,
  [intelligence,willpower]);


const List<Skill> allSkills = const <Skill>[
  language,
  perception,
  protocol,
  strategy,
];