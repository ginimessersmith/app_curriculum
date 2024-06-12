import 'package:curriculum/features/campaign/presentation/screens/campaign_screen.dart';
import 'package:curriculum/features/campaign/presentation/screens/screens.dart';
import 'package:curriculum/features/perfil/perfil.dart';
import 'package:go_router/go_router.dart';
import 'package:curriculum/features/auth/auth.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/campaign',
      builder: (context, state) => const Campaign(),
    ),
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const Perfil(),
    ),
    GoRoute(
      path: '/send-curriculum',
      builder: (context, state) {
        final id = state.extra as String;
        return SendCurriculumScreen(campaignId: id);
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const Perfil(),
    ),
  ],

  ///! TODO: Bloquear si no se está autenticado de alguna manera
);
