// ignore_for_file: avoid_unnecessary_containers
import 'package:cinemax/screens/about.dart';
import 'package:flutter/material.dart';
import 'screens/movie_detail.dart';
import 'screens/widgets.dart';
import 'api/endpoints.dart';
import 'modals/movie.dart';
import 'screens/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Cinemax',
      theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Poppins',
              ),
          //primaryColor: const Color(0xFFF57C00),
          iconTheme: const IconThemeData(color: Color(0xFFF57C00)),
          //backgroundColor: Colors.black,
          colorScheme: const ColorScheme(
              primary: Color(0xFFF57C00),
              primaryVariant: Color(0xFF8f4700),
              secondary: Color(0xFF202124),
              secondaryVariant: Color(0xFF141517),
              surface: Color(0xFFF57C00),
              background: Color(0xFF202124),
              error: Color(0xFFFF0000),
              onPrimary: Color(0xFF202124),
              onSecondary: Color(0xFF141517),
              onSurface: Color(0xFF141517),
              onBackground: Color(0xFFF57C00),
              onError: Color(0xFFFFFFFF),
              brightness: Brightness.dark)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Image.asset('assets/images/logo.png'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutPage();
                }));
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1f1f1e),
      appBar: AppBar(
        title: const Text(
          'Cinemax',
          style: TextStyle(fontFamily: 'PoppinsSB'),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final Movie? result = await showSearch<Movie?>(
                    context: context, delegate: MovieSearch());
                if (result != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                              movie: result, heroId: '${result.id}search')));
                }
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            const DiscoverMovies(),
            ScrollingMovies(
              title: 'Top Rated',
              api: Endpoints.topRatedUrl(1),
              discoverType: 'top_rated',
            ),
            ScrollingMovies(
              title: 'Popular',
              api: Endpoints.popularMoviesUrl(1),
              discoverType: 'popular',
            ),
            ScrollingMovies(
              title: 'Now playing',
              api: Endpoints.nowPlayingMoviesUrl(1),
              discoverType: 'now_playing',
            ),
            ScrollingMovies(
              title: 'Upcoming',
              api: Endpoints.upcomingMoviesUrl(1),
              discoverType: 'upcoming',
            ),
            ScrollingMovies(
              title: 'Popular on Apple TV+',
              api: Endpoints.watchProvidersMovies(),
              watchProviderId: '350',
            ),
          ],
        ),
      ),
    );
  }
}
