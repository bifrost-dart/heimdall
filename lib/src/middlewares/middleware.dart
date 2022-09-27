import 'package:heimdall/core.dart';

typedef Middleware = void Function(RequestHandler handler, dynamic next);
