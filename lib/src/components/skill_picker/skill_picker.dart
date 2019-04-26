import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../skills.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'skill-picker',
  styleUrls: ['skill_picker.css'],
  templateUrl: 'skill_picker.html',
  providers: [materialProviders],
  directives: [
    MaterialInputComponent,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialTabComponent,
    MaterialTabPanelComponent,
    MaterialDropdownSelectComponent,
    MaterialButtonComponent
  ],
)
class SkillPickerComponent {

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
