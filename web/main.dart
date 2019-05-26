import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ngdartapp/app_component.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector([
  // SPA Router.
  routerProvidersHash,
])
final InjectorFactory hackerNewsApp = self.hackerNewsApp$Injector;



void main() {
  runApp(ng.AppComponentNgFactory, createInjector: hackerNewsApp);
}
