import 'package:quiver/collection.dart';

const int attributeXPCost = 100;

class Attribute {
  final String name;
  const Attribute(this.name);
  String toString() => this.name;
}

class AttributeValue {
  int get score => (XP / attributeXPCost).floor();
  int XP = 0;
}

class AttributeSet extends DelegatingMap<Attribute, AttributeValue> {
  final Map<Attribute, AttributeValue> _l = <Attribute, AttributeValue>{};

  Map<Attribute, AttributeValue> get delegate => _l;

  AttributeSet() {
    for (Attribute atr in allAttributes) {
      this[atr] = new AttributeValue();
    }
  }

  void addXP(Attribute attr, int xp) {
    this[attr].XP += xp;
  }
}

const Attribute strength = const Attribute("STR");
const Attribute body = const Attribute("BOD");
const Attribute reflex = const Attribute("RFL");
const Attribute dexterity = const Attribute("DEX");
const Attribute intelligence = const Attribute("INT");
const Attribute willpower = const Attribute("WIL");
const Attribute charisma = const Attribute("CHA");
const Attribute edge = const Attribute("EDG");

const List<Attribute> allAttributes = <Attribute>[
  strength,
  body,
  reflex,
  dexterity,
  intelligence,
  willpower,
  charisma,
  edge
];
