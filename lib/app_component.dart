import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'src/character.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'src/origins.dart';
import 'src/skills.dart';
import 'src/traits.dart';
import 'src/components/components.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: [materialProviders],
  directives: [
    MaterialInputComponent,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialTabComponent,
    MaterialTabPanelComponent,
    MaterialDropdownSelectComponent,
    MaterialButtonComponent,
    SkillPickerComponent,
    CharacterSheetComponent
  ],
)
class AppComponent {
  Character char = new Character();

  List<Affiliation> get affiliations =>
      new List<Affiliation>.from(allAffiliations.keys);

  List<TraitChoice> get affiliationTraitChoices =>
      new List.from(selectedAffiliation?.bonusTraits?.keys
          ?.where((e) => e is TraitChoice)??
      []);



  bool get showSubAffiliation => selectedAffiliation != null;
  List<SubAffiliation> get subAffiliations =>
      allAffiliations[selectedAffiliation];

  bool get showSecondaryLanguage =>selectedAffiliation != null;
  List<ASkill> get languages => new List()
    ..addAll(selectedAffiliation.secondaryLanguages)
    ..add(languageEnglish);

  Affiliation _selectedAffiliation;
  Affiliation get selectedAffiliation =>
      char.subAffiliation?.affiliation ?? _selectedAffiliation;
  set selectedAffiliation(Affiliation aff) {
    _selectedAffiliation = aff;
    char.subAffiliation = null;
  }

  JsonEncoder _encoder = new JsonEncoder.withIndent('   ');
  String get exportData =>  _encoder.convert(char);

  void resetButtonTrigger() {
    _selectedAffiliation = null;
    char = new Character();
  }
}
