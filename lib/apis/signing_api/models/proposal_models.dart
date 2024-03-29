import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/generic_models.dart';

part 'proposal_models.g.dart';

@JsonSerializable()
class BaseRequiredNamespace {
  final List<String> chains;
  final List<String> methods;
  final List<String> events;

  BaseRequiredNamespace({
    required this.chains,
    required this.methods,
    required this.events,
  });

  factory BaseRequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$BaseRequiredNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequiredNamespaceToJson(this);

  @override
  bool operator ==(Object other) {
    return other is BaseRequiredNamespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      chains.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      methods.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      events.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      );
}

@JsonSerializable()
class RequiredNamespace extends BaseRequiredNamespace {
  final List<BaseRequiredNamespace> extension;

  RequiredNamespace({
    required List<String> chains,
    required List<String> methods,
    List<String> events = const [],
    this.extension = const [],
  }) : super(
          chains: chains,
          methods: methods,
          events: events,
        );

  factory RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$RequiredNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredNamespaceToJson(this);

  @override
  bool operator ==(Object other) {
    return other is RequiredNamespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      super.hashCode +
      extension.fold<int>(
        0,
        (previousValue, element) => previousValue + element.hashCode,
      );
}

@JsonSerializable()
class ProposalData {
  final int id;
  final int expiry;
  final List<Relay> relays;
  final ConnectionMetadata proposer;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final String? pairingTopic;

  ProposalData({
    required this.id,
    required this.expiry,
    required this.relays,
    required this.proposer,
    required this.requiredNamespaces,
    required this.pairingTopic,
  });

  factory ProposalData.fromJson(Map<String, dynamic> json) =>
      _$ProposalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalDataToJson(this);
}
