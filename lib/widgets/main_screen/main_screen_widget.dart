import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/movie_list/movie_list.dart';


class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  static const List<Widget> _pagesList = <Widget>[
    Text('Новости'),
    MovieListWidget(),
    Text('Сериалы'),
  ];

  void onSelectTub(int index) {
    setState(() {
      if(_selectedTab == index) return;
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      body: Center(
        child: _pagesList[_selectedTab],
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
