import 'package:heimdall/heimdall.dart';

typedef Middleware = void Function(RequestHandler handler, NextFunction next);

class NextFunction {}
