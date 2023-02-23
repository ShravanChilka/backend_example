import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';

Response onRequest(RequestContext context) {
  final user = User(
    email: 'shravanchilka@gmail.com',
    password: '1234',
  );
  return Response(
    body: user.toJson(),
  );
}
