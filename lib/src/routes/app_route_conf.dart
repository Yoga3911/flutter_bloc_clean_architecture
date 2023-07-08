import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_route_path.dart';
import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.auth.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (_, __) => const AuthPage(),
        routes: [
          GoRoute(
            path: AppRoute.login.path,
            name: AppRoute.login.name,
            builder: (_, __) => const LoginPage(),
          ),
          GoRoute(
            path: AppRoute.register.path,
            name: AppRoute.register.name,
            builder: (_, __) => const RegisterPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, state) {
          final params = state.pathParameters;
          final user = UserEntity(
            username: params["username"],
            email: params["email"],
            userId: params["user_id"],
          );

          return HomePage(user: user);
        },
      ),
      GoRoute(
        path: AppRoute.createProduct.path,
        name: AppRoute.createProduct.name,
        builder: (_, state) {
          final context = state.extra as BuildContext;

          return CreateProductPage(ctx: context);
        },
      ),
      GoRoute(
        path: AppRoute.updateProduct.path,
        name: AppRoute.updateProduct.name,
        builder: (_, state) {
          final context = state.extra as BuildContext;
          final productId = state.pathParameters["product_id"] ?? "";
          final productName = state.pathParameters["product_name"] ?? "";
          final productPrice = state.pathParameters["product_price"] ?? "";

          return UpdateProductPage(
            ctx: context,
            productId: productId,
            productName: productName,
            productPrice: productPrice,
          );
        },
      ),
    ],
  );
}
