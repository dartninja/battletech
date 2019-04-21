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

  Skill startingSecondaryLanguage;


  Affiliation get affiliation => subAffiliation?.affiliation;
  AffiliationOptions affiliationOptions = new AffiliationOptions();
  SubAffiliation subAffiliation;
  AffiliationOptions subAffiliationOptions = new AffiliationOptions();


  AttributeSet get attributes {
    AttributeSet output = new AttributeSet();
    for (Attribute attr in allAttributes) {
      output.addXP(attr, 100);
    }
    if (subAffiliation?.bonusAttributes != null) {
      for (Attribute attr in subAffiliation.bonusAttributes.keys) {
        output.addXP(attr, subAffiliation.bonusAttributes[attr]);
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

    if (subAffiliation?.bonusSkills != null) {
      for (Skill skill in subAffiliation.bonusSkills.keys) {
        output.addXP(skill, subAffiliation.bonusSkills[skill]);
      }
    }

    return output;
  }

  final SkillSet _manualSkills = new SkillSet();

  TraitSet get traits{
    TraitSet output = new TraitSet();

    if(affiliation?.bonusTraits!=null) {
      for(var trait in affiliation.bonusTraits.keys) {

        if(trait is TraitChoice) {
          if(affiliationOptions.selectedTraits.containsKey(trait)) {
            output.addXP(affiliationOptions.selectedTraits[trait], affiliation.bonusTraits[trait]);
          }
        } else if(trait is Trait) {
          output.addXP(trait, affiliation.bonusTraits[trait]);
        } else {
          throw new Exception("ATrait type not supported: ${trait.runtimeType.toString()}");
        }

      }
    }

    if (subAffiliation?.bonusTraits!= null) {
      for (var trait in subAffiliation.bonusTraits.keys) {
        if(trait is TraitChoice) {
          if(subAffiliationOptions.selectedTraits.containsKey(trait)) {
            output.addXP(subAffiliationOptions.selectedTraits[trait], subAffiliation.bonusTraits[trait]);
          }
        } else if(trait is Trait) {
          output.addXP(trait, subAffiliation.bonusTraits[trait]);
        } else {
          throw new Exception("ATrait type not supported: ${trait.runtimeType.toString()}");
        }
      }
    }

    return output;
  }

  final TraitSet _manualTraits = new TraitSet();

  Map<String,dynamic> toJson() => {
    _ageField: age,
    _startingSecondaryLanguageField: startingSecondaryLanguage,
    _affiliationOptionsField: affiliationOptions,
    _subAffiliationField: subAffiliation

  };
  static const String _ageField = "age";
  static const String _startingSecondaryLanguageField = "startingSecondaryLanguage";
  static const String _affiliationField = "affiliation";
  static const String _affiliationOptionsField = "affiliationOptions";
  static const String _subAffiliationField = "subAffiliation";
}
