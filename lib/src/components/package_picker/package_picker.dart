import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../skills.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'package-picker',
  styleUrls: ['package_picker.css'],
  templateUrl: 'package_picker.html',
  providers: [materialProviders],
  directives: [
    MaterialInputComponent,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialDropdownSelectComponent,
    MaterialButtonComponent
  ],
)
class PackagePickerComponent {

  @Input()
  ASkill choice;

  SubSkill _subSkill;

  SubSkill get subSkill {
    if(choice is SubSkill) {
      return choice;
    } else {
      return _subSkill;
    }
  }

  set subSkill(SubSkill value) {
    _subSkill = value;
  }

  Skill get skill {
    if(choice is Skill) {
      return choice;
    } else if(choice is SubSkill) {
      return (choice as SubSkill).skill;
    }
    return null;
  }

  bool get showSubSkillDropDown => skill?.subSkills?.isNotEmpty??false;


  @Output()
  SkillInstance selected;



}
