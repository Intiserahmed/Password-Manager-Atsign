
// import 'dart:convert';
import 'dart:core';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_server_status/at_server_status.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:at_commons/at_commons.dart';
import '../utils/constants.dart' as conf;

class ClientSdkService {
  static final ClientSdkService _singleton = ClientSdkService._internal();

  ClientSdkService._internal();

  factory ClientSdkService.getInstance() {
    return _singleton;
  }

  AtClientService? atClientServiceInstance;
  AtClientImpl? atClientInstance;
  Map<String?, AtClientService> atClientServiceMap = {};
  String? atsign;

  _reset() {
    atClientServiceInstance = null;
    atClientInstance = null;
    atClientServiceMap = {};
    atsign = null;
  }

  _sync() async {
    await _getAtClientForAtsign()!.getSyncManager()!.sync();
  }

  AtClientImpl? _getAtClientForAtsign({String? atsign}) {
    atsign ??= this.atsign;
    if (atClientServiceMap.containsKey(atsign)) {
      return atClientServiceMap[atsign]!.atClient;
    }
    return null;
  }

  AtClientService _getClientServiceForAtSign(String? atsign) {
    if (atClientServiceMap.containsKey(atsign)) {
      return atClientServiceMap[atsign]!;
    }
    return AtClientService();
  }

  Future<AtClientPreference> getAtClientPreference({String? cramSecret}) async {
    final appDocumentDirectory =
        await path_provider.getApplicationSupportDirectory();
    String path = appDocumentDirectory.path;
    var _atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = path
      ..cramSecret = cramSecret
      ..namespace = conf.MixedConstants.NAMESPACE
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..rootDomain = conf.MixedConstants.ROOT_DOMAIN
      ..hiveStoragePath = path;
    return _atClientPreference;
  }

  _checkAtSignStatus(String atsign) async {
    var atStatusImpl = AtStatusImpl(rootUrl: conf.MixedConstants.ROOT_DOMAIN);
    var status = await atStatusImpl.get(atsign);
    return status.serverStatus;
  }
  

  Future<String> get(AtKey atKey) async {
    var result = await _getAtClientForAtsign()!.get(atKey);
    return result.value;
  }

  Future<bool> put(AtKey atKey, String value) async {
    return await _getAtClientForAtsign()!.put(atKey, value);
  }

  Future<bool> delete(AtKey atKey) async {
    return await _getAtClientForAtsign()!.delete(atKey);
  }

  Future<List<AtKey>> getAtKeys(String regex, {String? sharedBy}) async {
    return await _getAtClientForAtsign()!
        .getAtKeys(regex: conf.MixedConstants.NAMESPACE, sharedBy: sharedBy);
  }

  ///Fetches atsign from device keychain.
  Future<String?> getAtSign() async {
    return await atClientServiceInstance!.getAtSign();
  }

  deleteAtSignFromKeyChain() async {
    // List<String> atSignList = await getAtsignList();
    String atsign = atClientServiceInstance!.atClient!.currentAtSign!;

    await atClientServiceMap[atsign]!.deleteAtSignFromKeychain(atsign);

    _reset();
  }

  Future<bool> notify(
      AtKey atKey, String value, OperationEnum operation) async {
    return await _getAtClientForAtsign()!.notify(atKey, value, operation);
  }
}