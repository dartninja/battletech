import 'package:quiver/collection.dart';

const int traitXPCost = 100;

class Trait {
  final String name;
  const Trait(this.name);
}
class TraitValue{
  int get score => (XP/traitXPCost).floor();
  int XP = 0;
}

class AttributeSet extends DelegatingMap<Trait,TraitValue> {
  final Map<Trait, TraitValue> _l = <Trait, TraitValue>{};

  Map<Trait, TraitValue> get delegate => _l;

  AttributeSet() {
    for(Trait t in allAttributes) {
      this[t] = new TraitValue();
    }
  }

  void addXP(Trait t, int xp){
    this[t].XP += xp;
  }

}


const Trait connections = const Trait("Connections");

const Trait compulsions = const Trait("Compulsions");

const List<Trait> allAttributes = <Trait>[
  connections,
  compulsions
];