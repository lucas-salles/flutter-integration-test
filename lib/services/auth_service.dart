/// Fake auth service (substitua pela sua implementação real)
class AuthService {
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Credenciais inválidas');
    }
  }

  static Future<void> signup({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.length < 5 || password.length < 6) {
      throw Exception('Verifique email e senha');
    }
  }
}
