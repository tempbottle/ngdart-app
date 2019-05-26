
import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';
import 'src/feed/feed_component.template.dart' as feed;
import 'src/item/item_detail_component.template.dart' deferred as item_detail;

@Component(
  selector: 'app',
  styleUrls: const ['./app_component.css'],
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  encapsulation: ViewEncapsulation.None
)
class AppComponent implements AfterViewInit {
  static final newsUrl = newsRoutePath.toUrl();
  static final newUrl = newRoutePath.toUrl();
  static final showUrl = showRoutePath.toUrl();
  static final askUrl = askRoutePath.toUrl();
  static final jobsUrl = jobsRoutePath.toUrl();

  AppComponent();

  void ngAfterViewInit() {
    scheduleMicrotask(this._setBootstrapSize);
    window.onResize.listen((event) => this._setBootstrapSize());

    window.onScroll.listen((event) => this._setHeaderFooter());
  }

  void _setHeaderFooter() {
    var y = window.scrollY;
    if (window.innerHeight + window.scrollY >= document.body.clientHeight) {
      //window.console.log("at bottom");
    }
    //window.console.log("y="+y.toString());
    var header = window.document.querySelectorAll("header");
    if (y<3) {
      header.style.display = 'flex';
    } else {
      header.style.display = 'none';
    }
  }

  void _setBootstrapSize() {
     List<Element> eles = window.document.querySelectorAll("nav>a>span");
     //window.console.log(eles);
     var len = eles.length;
     var w = window.innerWidth;
     for (var e in eles){
        e.style.width = (w / len).floor().toString() + "px";
     }
  }

  static final routes = [
    RouteDefinition(
      routePath: newsRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
    RouteDefinition(
      routePath: newRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
    RouteDefinition(
      routePath: showRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
    RouteDefinition(
      routePath: askRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
    RouteDefinition(
      routePath: jobsRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
    RouteDefinition.defer(
      routePath: itemRoutePath,
      loader: () {
        return item_detail.loadLibrary().then((_) {
          return item_detail.ItemDetailComponentNgFactory;
        });
      },
    ),
  ];


}
