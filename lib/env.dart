import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'NOTIFICATION_API_BASE_URL')
  static final String notificationApiBaseUrl = _Env.notificationApiBaseUrl;
}
