import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../character.dart';
import '../../origins.dart';
import '../skill_picker/skill_picker.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'package-picker',
  styleUrls: [
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
    'package_picker.css'],
  templateUrl: 'package_picker.html',
  providers: [materialProviders],
  directives: [
    MaterialInputComponent,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialDropdownSelectComponent,
    MaterialButtonComponent,
    SkillPickerComponent
  ],
)
class PackagePickerComponent {

  @Input("character")
  Character char;


  Package selectedPackage;

  void addPackage() {
    if(selectedPackage==null)
      return;

    char.lifePackageOptions.add(new PackageOptions());
    char.lifePackages.add(selectedPackage);
    selectedPackage=null;
  }
  void removePackage(int i) {
    char.lifePackages.removeRange(i, char.lifePackages.length);
    char.lifePackageOptions.removeRange(i, char.lifePackageOptions.length);
  }

  List<Package> get availablePackages => new List<Package>.from(
      allPackages.where((e) {
        if(!e.repeatable&&char.lifePackages.contains(e)) {
          return false;
        }
        for(var requirement in e.requiredPackages) {
          if(!char.lifePackages.contains(requirement)) {
            return false;
          }
        }
        return true;
      }));

}
