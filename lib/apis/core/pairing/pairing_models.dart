import 'package:event/event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';

part 'pairing_models.g.dart';

@JsonSerializable()
class PairingInfo {
  String topic;
  // Value in seconds
  int expiry;
  Relay relay;
  bool active;
  PairingMetadata? peerMetadata;

  PairingInfo(
    this.topic,
    this.expiry,
    this.relay,
    this.active, {
    this.peerMetadata,
  });

  factory PairingInfo.fromJson(Map<String, dynamic> json) =>
      _$PairingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PairingInfoToJson(this);
}

@JsonSerializable()
class PairingMetadata {
  final String name;
  final String description;
  final String url;
  final List<String> icons;
  final Redirect? redirect;

  PairingMetadata(
    this.name,
    this.description,
    this.url,
    this.icons, {
    this.redirect,
  });

  factory PairingMetadata.fromJson(Map<String, dynamic> json) =>
      _$PairingMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PairingMetadataToJson(this);

  @override
  String toString() {
    return 'Name: $name, Description: $description, Url: $url, Icons: $icons';
  }

  @override
  bool operator ==(Object other) {
    return other is PairingMetadata && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      name.hashCode +
      description.hashCode +
      url.hashCode +
      icons.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      (redirect == null ? 1 : redirect.hashCode);
}

@JsonSerializable()
class Redirect {
  final String? native;
  final String? universal;

  Redirect(
    this.native,
    this.universal,
  );

  factory Redirect.fromJson(Map<String, dynamic> json) =>
      _$RedirectFromJson(json);

  Map<String, dynamic> toJson() => _$RedirectToJson(this);

  @override
  bool operator ==(Object other) {
    return other is Redirect && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      (native == null ? 1 : native!.hashCode) +
      (universal == null ? 1 : universal!.hashCode);
}

class CreateResponse {
  String topic;
  Uri uri;

  CreateResponse(
    this.topic,
    this.uri,
  );
}

class ExpirationEvent extends EventArgs {
  String target;
  int expiry;

  ExpirationEvent(this.target, this.expiry);
}

class HistoryEvent extends EventArgs {
  JsonRpcRecord record;

  HistoryEvent(this.record);
}

class PairingEvent extends EventArgs {
  int? id;
  String? topic;
  JsonRpcError? error;

  PairingEvent({
    this.id,
    this.topic,
    this.error,
  });
}

@JsonSerializable()
class JsonRpcRecord {
  int id;
  String topic;
  String method;
  dynamic params;
  dynamic response;
  String? chainId;

  JsonRpcRecord(
    this.id,
    this.topic,
    this.method,
    this.params, {
    this.chainId,
  });

  factory JsonRpcRecord.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRecordFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRpcRecordToJson(this);
}
