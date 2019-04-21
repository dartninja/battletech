import 'package:quiver/collection.dart';
import 'skills.dart';
import 'shared.dart';

const int traitXPCost = 100;

abstract class ATrait {
  const ATrait();
}

class Trait extends ATrait {
  final String id;
  final String name;
  final bool freeForm;
  const Trait(this.id, this.name, {this.freeForm= false});

  String toString() => name;

  String toJson() => this.id;
}

class TraitChoice extends ATrait {
  final String id;
  final List<ATrait> choices;

  const TraitChoice(this.id, this.choices);

  String toJson() => this.id;
}

class TraitOptionChoice<T> extends ATrait {
  final ATrait trait;
  final List<T> traitOptions;

  const TraitOptionChoice(this.trait, {this.traitOptions= const[]});
}

class TraitWithParameter<T> extends Trait {
  final List<T> options;

  const TraitWithParameter(String id, String name, this.options, {bool freeForm= false}): super(id,name, freeForm: freeForm);
}

class TraitParameterInstance<T> extends ATrait {
  final TraitWithParameter<T> trait;
  final T parameter;
  const TraitParameterInstance(this.trait, this.parameter);

  String toString() => "$trait/$parameter";

  Map toJson() => {"trait": trait, "parameter": parameter };
}


class TraitOptions<T>{
  int get TP => (XP / traitXPCost).floor();
  int XP = 0;
}

class TraitSet extends DelegatingMap<ATrait, TraitOptions> {
  final Map<ATrait, TraitOptions> _l = <ATrait, TraitOptions>{};

  Map<ATrait, TraitOptions> get delegate => _l;

  void addXP(ATrait t, int xp) {
    ATrait key = this.keys.firstWhere((e) {
      if(e==t)
        return true;
      return false;
    },orElse: () => null);

    if(key==null) {
      if(t is TraitOptionChoice) {
        throw new Exception("Cannot add TraitOptionChoice");
      } else if(t is TraitWithParameter) {
        throw new Exception("Cannot add TraitWithParameter");
      } else if(t is TraitParameterInstance || t is Trait) {
        key =t;
        this[t] = new TraitOptions();
      } else {
        throw new Exception("Unssupported Arait type");
      }
    }

    this[key].XP += xp;
  }
}

const Trait connections = const Trait("connections","Connections");
const Trait compulsions = const Trait("compulsions","Compulsions");
const Trait naturalAptitude = const TraitWithParameter<Skill>("naturalAptitude"," Natural Aptitude", allSkills);


const List<Trait> allTraits = <Trait>[connections, compulsions, naturalAptitude];
