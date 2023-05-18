// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $nowPlayingRoute,
      $shellRoutes,
    ];

RouteBase get $nowPlayingRoute => GoRouteData.$route(
      path: '/now-playing',
      factory: $NowPlayingRouteExtension._fromState,
    );

extension $NowPlayingRouteExtension on NowPlayingRoute {
  static NowPlayingRoute _fromState(GoRouterState state) => NowPlayingRoute();

  String get location => GoRouteData.$location(
        '/now-playing',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $shellRoutes => ShellRouteData.$route(
      factory: $ShellRoutesExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $HomeScreenRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/library',
          factory: $LibraryRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'albums',
              factory: $AlbumsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'album/:album',
              factory: $ArtistAlbumRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'artists',
              factory: $ArtistsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'artist/:artist',
              factory: $ArtistRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'songs',
              factory: $SongsRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/queue',
          factory: $QueueRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/files',
          factory: $FilesRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/scanner',
          factory: $ScannerRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/search',
          factory: $SearchRouteExtension._fromState,
        ),
      ],
    );

extension $ShellRoutesExtension on ShellRoutes {
  static ShellRoutes _fromState(GoRouterState state) => ShellRoutes();
}

extension $HomeScreenRouteExtension on HomeScreenRoute {
  static HomeScreenRoute _fromState(GoRouterState state) => HomeScreenRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $LibraryRouteExtension on LibraryRoute {
  static LibraryRoute _fromState(GoRouterState state) => LibraryRoute();

  String get location => GoRouteData.$location(
        '/library',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $AlbumsRouteExtension on AlbumsRoute {
  static AlbumsRoute _fromState(GoRouterState state) => AlbumsRoute();

  String get location => GoRouteData.$location(
        '/library/albums',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ArtistAlbumRouteExtension on ArtistAlbumRoute {
  static ArtistAlbumRoute _fromState(GoRouterState state) => ArtistAlbumRoute(
        album: state.pathParameters['album']!,
        artist: state.queryParameters['artist'],
      );

  String get location => GoRouteData.$location(
        '/library/album/${Uri.encodeComponent(album)}',
        queryParams: {
          if (artist != null) 'artist': artist,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ArtistsRouteExtension on ArtistsRoute {
  static ArtistsRoute _fromState(GoRouterState state) => ArtistsRoute();

  String get location => GoRouteData.$location(
        '/library/artists',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ArtistRouteExtension on ArtistRoute {
  static ArtistRoute _fromState(GoRouterState state) => ArtistRoute(
        state.pathParameters['artist']!,
      );

  String get location => GoRouteData.$location(
        '/library/artist/${Uri.encodeComponent(artist)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SongsRouteExtension on SongsRoute {
  static SongsRoute _fromState(GoRouterState state) => SongsRoute();

  String get location => GoRouteData.$location(
        '/library/songs',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $QueueRouteExtension on QueueRoute {
  static QueueRoute _fromState(GoRouterState state) => QueueRoute();

  String get location => GoRouteData.$location(
        '/queue',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $FilesRouteExtension on FilesRoute {
  static FilesRoute _fromState(GoRouterState state) => FilesRoute();

  String get location => GoRouteData.$location(
        '/files',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ScannerRouteExtension on ScannerRoute {
  static ScannerRoute _fromState(GoRouterState state) => ScannerRoute();

  String get location => GoRouteData.$location(
        '/scanner',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
