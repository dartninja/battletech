import 'dart:core';
import 'dart:convert';
import 'package:battletech/src/skills.dart';
import 'package:battletech/src/attributes.dart';
import 'package:battletech/src/origins.dart';
import 'traits.dart';

class Character {
  String name = "Test Character";

  Character();

  int age = defaultStartingAge;

  static const int defaultStartingAge = 21;
  static const int defaultStartingXP = 5000;
  static const int xpPerYear = 100;
  static const int startingAttributeXP = 100;

  int get startingXP =>
      defaultStartingXP + ((age - defaultStartingAge) * xpPerYear);

  int get remainingXP {
    return startingXP - consumedXP;
  }

  int get consumedXP {
    // Starting attribute cost and mandatory skill costs
    int output = (startingAttributeXP * 8) + 50;

    return output;
  }

  SubSkill<Language> startingSecondaryLanguage;


  List<Package> lifePackages = <Package>[];
  List<PackageOptions> lifePackageOptions = <PackageOptions>[];

  LearningSpeed learningSpeed = LearningSpeed.Normal;

  AttributeSet get attributes {
    AttributeSet output = new AttributeSet();
    for (Attribute attr in allAttributes) {
      output.addXP(attr, 100);
    }
    for(var package in lifePackages) {
      if (package ?.bonusAttributes != null) {
        for (Attribute attr in package .bonusAttributes.keys) {
          output.addXP(attr, package .bonusAttributes[attr]);
        }
      }
    }

    return output;
  }

  SkillSet get skills {
    SkillSet output = new SkillSet();
    output.addXP(languageEnglish, 20);
    if(startingSecondaryLanguage!=null)
      output.addXP(startingSecondaryLanguage, 20);
    output.addXP(perception, 10);

    for(var package in lifePackages) {
      if (package?.bonusSkills != null) {
        for (var skill in package .bonusSkills.keys) {
          if (skill.requiresChoice) {
            if (affiliationOptions.selectedSkills.containsKey(skill)) {
              output.addXP(affiliationOptions.selectedSkills[skill],
                  package .bonusSkills[skill]);
            }
          } else {
            output.addXP(skill, package .bonusSkills[skill]);
          }
        }
      }
    }
    return output;
  }

  final SkillSet _manualSkills = new SkillSet();

  TraitSet get traits{
    TraitSet output = new TraitSet();

    for(var package in lifePackages) {
      if (package ?.bonusTraits != null) {
        for (var trait in package .bonusTraits.keys) {
          if (trait is TraitChoice) {
            if (affiliationOptions.selectedTraits.containsKey(trait)) {
              output.addXP(affiliationOptions.selectedTraits[trait],
                  package .bonusTraits[trait]);
            }
          } else if (trait is Trait) {
            output.addXP(trait, package .bonusTraits[trait]);
          } else {
            throw new Exception(
                "ATrait type not supported: ${trait.runtimeType.toString()}");
          }
        }
      }
    }

    return output;
  }

  final TraitSet _manualTraits = new TraitSet();

  Map<String,dynamic> toJson() => {
    _ageField: age,
    _packagesField: lifePackages,
  };
  static const String _ageField = "age";
  static const String _packagesField = "packages";
}
