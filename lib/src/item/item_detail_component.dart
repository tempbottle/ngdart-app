import 'package:angular/angular.dart';
import 'package:angular/experimental.dart';
import 'package:angular_router/angular_router.dart';

import 'package:ngdartapp/src/hacker_news_service.dart';
import 'package:ngdartapp/src/comment/comment_component.dart';
import 'package:ngdartapp/src/item/item_component.dart';

final _service = HackerNewsService(defaultBaseUrl);
HackerNewsService getNewsService() => _service;

/// Recursively populates comment count for all comments.
///
/// The number of replies to a comment, including the comment itself, are stored
/// in 'comments_count' for each comment.
int countComments(Map comment) {
  final List replies = comment['comments'];
  var numComments = 1;
  for (final Map reply in replies) {
    numComments += countComments(reply);
  }
  return comment['comments_count'] = numComments;
}

@Component(
  selector: 'item-detail',
  templateUrl: 'item_detail_component.html',
  styleUrls: const ['item_detail_component.css'],
  directives: [
    CommentComponent,
    ItemComponent,
    NgForIdentity,
    NgIf,
  ],
  providers: [FactoryProvider(HackerNewsService, getNewsService),],
  encapsulation: ViewEncapsulation.None
)
class ItemDetailComponent implements OnActivate {
  final HackerNewsService _hackerNewsService;

  Map item;

  ItemDetailComponent(this._hackerNewsService);

  @override
  void onActivate(_, RouterState current) {
    final id = current.parameters['id'];
    _hackerNewsService.getItem(id).then((result) {
      item = result;
      final List comments = item['comments'];
      for (final Map comment in comments) {
        countComments(comment);
      }
    });
  }
}
