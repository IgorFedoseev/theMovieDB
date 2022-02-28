import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/domain/data_providers/session_data_provider.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/movie_list/movie_list.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/movie_list/movie_list_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 1;
  final movieListModel = MovieListModel();

  void onSelectTub(int index) {
    setState(() {
      if (_selectedTab == index) return;
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Text('Новости'),
          NotifierProvider(
            child: const MovieListWidget(),
            isManagingModel: false,
            create: () => movieListModel,
          ),
          const Text('Сериалы'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: onSelectTub,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV shows',
          ),
        ],
      ),
    );
  }
}
