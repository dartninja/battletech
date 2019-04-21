import 'package:battletech/src/skills.dart';
import 'package:battletech/src/attributes.dart';

class Package {
  final int cost;
  final Map<Attribute, int> bonusAttributes;
  final Map<Skill, int> bonusSkills;

  const Package(this.cost, {this.bonusAttributes, this.bonusSkills});
}

class Affiliation extends Package {
  final String name;
  const Affiliation(this.name, int cost, {Map<Attribute, int> bonusAttributes, Map<Skill, int> bonusSkills}):
        super(cost, bonusAttributes: bonusAttributes, bonusSkills: bonusSkills);
}

class SubAffiliation extends Package {
  final String name;
  final Affiliation affiliation;
  const SubAffiliation(this.name, this.affiliation, {Map<Attribute, int> bonusAttributes, Map<Skill, int> bonusSkills}):
        super(0, bonusAttributes: bonusAttributes, bonusSkills: bonusSkills);
}

const Affiliation davion = const Affiliation("Davion", 150, bonusSkills: {protocolFedSuns: 10});

const SubAffiliation draconisMarch = const SubAffiliation("Draconis March", davion, bonusAttributes: {edge: 25});

const Map<Affiliation, List<SubAffiliation>> allAffiliations = {
  davion: []

};