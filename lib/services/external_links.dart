import 'package:url_launcher/url_launcher.dart';

const allPs2BiosUri = 'https://allps2bios.com/';

Future<bool> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}
