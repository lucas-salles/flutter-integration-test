import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionDisplay extends StatefulWidget {
  const VersionDisplay({super.key});

  @override
  State<VersionDisplay> createState() => _VersionDisplayState();
}

class _VersionDisplayState extends State<VersionDisplay> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.buildNumber.isNotEmpty
          ? '${packageInfo.version}+${packageInfo.buildNumber}'
          : packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('App Version: $_appVersion', textAlign: TextAlign.center);
  }
}
