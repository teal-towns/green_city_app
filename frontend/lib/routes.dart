import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './modules/home.dart';
import './modules/route_not_found.dart';
import './modules/user_auth/user_email_verify.dart';
import './modules/user_auth/user_login.dart';
import './modules/user_auth/user_logout.dart';
import './modules/user_auth/user_password_reset.dart';
import './modules/user_auth/user_signup.dart';

import './modules/blog/blog_list.dart';
import './modules/blog/blog_save.dart';
import './modules/blog/blog_view.dart';
import './modules/design.dart';
import './modules/lend_library.dart';
import './modules/team.dart';

class Routes {
  static const home = '/home';
  static const notFound = '/route-not-found';
  static const emailVerify = '/email-verify';
  static const login = '/login';
  static const logout = '/logout';
  static const passwordReset = '/password-reset';
  static const signup = '/signup';

  static const blogList = '/blog';
  static const blogSave = '/blog-save';
  static const blogView = '/b/:slug';
  static const design = '/design';
  static const lendLibrary = '/lend-library';
  static const team = '/team';
}

class AppGoRouter {
  GoRouter router = GoRouter(
    initialLocation: Routes.home,
    errorBuilder: (BuildContext context, GoRouterState state) {
      String route = state.location;
      return RouteNotFoundPage(attemptedRoute: route);
    },
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) => HomeComponent(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => UserLoginComponent(),
      ),
      GoRoute(
        path: Routes.logout,
        builder: (context, state) => UserLogoutComponent(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (context, state) => UserSignupComponent(),
      ),
      GoRoute(
        path: Routes.emailVerify,
        builder: (context, state) => UserEmailVerifyComponent(),
      ),
      GoRoute(
        path: Routes.passwordReset,
        builder: (context, state) => UserPasswordResetComponent(),
      ),
      GoRoute(
        path: Routes.notFound,
        builder: (context, state) => RouteNotFoundPage(),
      ),

      GoRoute(
        path: Routes.blogList,
        builder: (BuildContext context, GoRouterState state) => BlogList(),
      ),
      GoRoute(
        path: Routes.blogSave,
        builder: (BuildContext context, GoRouterState state) => BlogSave(),
      ),
      GoRoute(
        path: Routes.blogView,
        builder: (BuildContext context, GoRouterState state) {
          String? slug = state.params["slug"];
          if (slug != null) {
            return BlogView(slug: slug);
          }
          return BlogList();
        }
      ),
      GoRoute(
        path: Routes.design,
        builder: (BuildContext context, GoRouterState state) => Design(),
      ),
      GoRoute(
        path: Routes.lendLibrary,
        builder: (BuildContext context, GoRouterState state) => LendLibrary(),
      ),
      GoRoute(
        path: Routes.team,
        builder: (BuildContext context, GoRouterState state) => Team(),
      ),
    ],
  );
}
