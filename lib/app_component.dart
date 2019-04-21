import 'package:angular/angular.dart';
import 'src/character.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';


// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: [materialProviders],
  directives: [MaterialInputComponent, coreDirectives, formDirectives, materialInputDirectives],
)
class AppComponent {
  Character char = new Character();

}

