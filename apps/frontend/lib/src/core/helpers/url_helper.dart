import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future launchURL(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    await launchUrl(Uri.parse(url), mode: mode);
  }

  static Future launchEmail(Uri email) async {
    await launchUrl(email);
  }

  static Future launchCaller(Uri callerNumber) async {
    if (await canLaunchUrl(callerNumber)) {
      await launchUrl(callerNumber);
    } else {
      throw 'Could not launchCaller for $callerNumber';
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    var googleUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}