import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './modules/blog/blog_list.dart';
import './modules/blog/blog_save.dart';
import './modules/blog/blog_view.dart';
import './modules/design.dart';
import './modules/home.dart';
import './modules/lend_library.dart';
import './modules/route_not_found.dart';
import './modules/team.dart';
import './modules/user_auth/user_email_verify.dart';
import './modules/user_auth/user_login.dart';
import './modules/user_auth/user_logout.dart';
import './modules/user_auth/user_password_reset.dart';
import './modules/user_auth/user_signup.dart';

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
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: HomeComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.login,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: UserLoginComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.logout,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: UserLogoutComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.signup,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: UserSignupComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.emailVerify,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: UserEmailVerifyComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.passwordReset,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: UserPasswordResetComponent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.notFound,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: RouteNotFoundPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.blogList,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: BlogList(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.blogSave,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: BlogSave(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.blogView,
          pageBuilder: (BuildContext context, GoRouterState state) {
            String? slug = state.params["slug"];

            if (slug != null) {
              return CustomTransitionPage(
                  child: BlogView(slug: slug),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }
            return CustomTransitionPage(
                child: BlogList(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.design,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: Design(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.lendLibrary,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: LendLibrary(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
      GoRoute(
          path: Routes.team,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
                child: Team(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          }),
    ],
  );
}
