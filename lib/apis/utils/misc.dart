import 'dart:io';

class MiscUtils {
  static bool isExpired(int expiry) {
    return DateTime.now().toUtc().compareTo(
              DateTime.fromMillisecondsSinceEpoch(
                toMilliseconds(expiry),
              ),
            ) >=
        0;
  }

  static int toMilliseconds(int seconds) {
    return seconds * 1000;
  }

  static int calculateExpiry(int offset) {
    return DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 + offset;
  }

  static String getOS() {
    return <String>[Platform.operatingSystem, Platform.operatingSystemVersion]
        .join('-');
  }

  static String getId() {
    return Platform.environment.values.join(':');
  }

  static String formatUA(
    String protocol,
    String version,
    String sdkVersion,
  ) {
    String os = getOS();
    String id = getId();
    return <String>[
      <String>[protocol, version].join('-'),
      <String>['FLUTTER', sdkVersion].join('-'),
      os,
      id,
    ].join('/');
  }

  static String formatRelayRpcUrl(
    String protocol,
    String version,
    String relayUrl,
    String sdkVersion,
    String auth,
    String projectId,
  ) {
    List<String> splitUrl = relayUrl.split('?');
    String ua = formatUA(
      protocol,
      version,
      sdkVersion,
    );
    String params = splitUrl.length > 1 ? splitUrl[1] : '';
    String queryString = '$params&$auth&$ua&$projectId';
    return '${splitUrl[0]}?$queryString';
  }
}