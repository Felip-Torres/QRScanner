import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final _url = scan.valor;
  if (scan.tipus == 'http') {
    final uri = Uri.parse(_url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}