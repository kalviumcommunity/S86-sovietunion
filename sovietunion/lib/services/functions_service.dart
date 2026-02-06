import 'package:cloud_functions/cloud_functions.dart';

class FunctionsService {
  FunctionsService._();

  static final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Calls the callable Cloud Function `sayHello` and returns the message.
  static Future<String> sayHello(String name) async {
    final callable = _functions.httpsCallable('sayHello');
    final result = await callable.call(<String, dynamic>{'name': name});
    final data = result.data as Map<String, dynamic>?;
    return data?['message'] as String? ?? '';
  }
}
