import 'package:app_tudo_list/app/modules/register/user/user_repository.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServiceImplements implements UserService{
 final UserRepository _userRepository;
 UserServiceImplements({required UserRepository userRepository}): _userRepository = userRepository;

 @override
  Future<User?> register(String email, String password) => _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) => _userRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) => _userRepository.forgorPassword(email);

  @override
  Future<User?> googleLogin() => _userRepository.googleLogin();

  @override
  Future<void> logout() => _userRepository.logout();


}
