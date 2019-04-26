import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../character.dart';


// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'character-sheet',
  styleUrls: ['character_sheet.css'],
  templateUrl: 'character_sheet.html',
  providers: [materialProviders],
  directives: [
    coreDirectives,
  ],
)
class CharacterSheetComponent {

  @Input("character")
  Character char;

}
