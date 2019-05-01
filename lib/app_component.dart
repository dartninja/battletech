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
    CharacterSheetComponent,
    PackagePickerComponent
  ],
)
class AppComponent {
  Character char = new Character();


  JsonEncoder _encoder = new JsonEncoder.withIndent('   ');
  String get exportData =>  _encoder.convert(char);

  void resetButtonTrigger() {
    char = new Character();
  }
}
