import 'package:timeago/timeago.dart' as timeago;

mixin TimeAgoMixin {
  String getTimeago(DateTime date) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    String format = timeago.format(date, locale: 'fr');
    return format;
  }
}