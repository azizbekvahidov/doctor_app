import 'package:myid/enums.dart';

/// MyID (face-verification) settings, managed from code.
///
/// MVP STATUS: there is no MyID contract yet, so the SDK always runs against
/// MyID's **test** environment and the server cannot verify its result (the API
/// runs with MYID_TEST_MODE=true and trusts the PINFL instead).
///
/// To go live: set [clientId] to the issued production client id, flip
/// [environment] to `MyIdEnvironment.PRODUCTION`, and set MYID_TEST_MODE=false
/// on the API with real MYID_CLIENT_ID/MYID_CLIENT_SECRET.
class MyIdSettings {
  MyIdSettings._();

  /// MyID client id. Put the sandbox id here to run the face check against
  /// MyID's DEBUG environment; the production id goes here when contracted.
  static String clientId = '';

  /// Pinned to the sandbox for the MVP. In DEBUG + [MyIdEntryType.FACE_DETECTION]
  /// the SDK only captures a face and returns the image, so it needs neither
  /// clientHash nor clientHashId (those are IDENTIFICATION-only).
  static MyIdEnvironment environment = MyIdEnvironment.DEBUG;

  /// MVP: let login continue when the face check fails, is cancelled, or MyID
  /// isn't configured yet — the API runs with MYID_TEST_MODE=true and trusts
  /// the PINFL. Set to false once MyID is contracted so a failed face check
  /// blocks login.
  static bool allowLoginWithoutVerification = true;

  /// Whether a client id has been supplied.
  static bool get isConfigured => clientId.isNotEmpty;
}
