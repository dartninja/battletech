import 'dart:core';
import 'package:battletech/src/skills.dart';
import 'package:battletech/src/attributes.dart';
import 'package:battletech/src/origins.dart';

class Character {
  String name = "Test Character";

  Character() {
  }

  int age = defaultStartingAge;

  static const int defaultStartingAge = 21;
  static const int defaultStartingXP = 5000;
  static const int xpPerYear = 100;
  static const int startingAttributeXP = 100;

  int get startingXP => defaultStartingXP+((age-defaultStartingAge)*xpPerYear);


  int get remainingXP {
    return startingXP -consumedXP;
  }

  int get consumedXP {
    // Starting attribute cost and mandatory skill costs
    int output =(startingAttributeXP*8) + 50;




    return output;
  }

  Skill startingSecondaryLanguage = languageEnglish;

  SubAffiliation affiliation = draconisMarch;


  AttributeSet get attributes  {
    AttributeSet output = new AttributeSet();
    for(Attribute attr in allAttributes) {
      output.addXP(attr, 100);
    }
if(affiliation.bonusAttributes!=null) {
  for (Attribute attr in affiliation.bonusAttributes.keys) {
    output.addXP(attr, affiliation.bonusAttributes[attr]);
  }
}


    return output;
  }

  SkillSet get skills {
    SkillSet output = new SkillSet();
    output.addXP(languageEnglish, 20);
    output.addXP(startingSecondaryLanguage, 20);
    output.addXP(perception,10);

    if(affiliation.bonusSkills!=null) {
      for (Skill skill in affiliation.bonusSkills.keys) {
        output.addXP(skill, affiliation.bonusSkills[skill]);
      }
    }


    return output;
  }

  final SkillSet _manualSkills = new SkillSet();

}