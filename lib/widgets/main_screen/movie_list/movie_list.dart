import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class Movie {
  final int id;
  final AssetImage image;
  final String title;
  final String releaseDate;
  final String description;

  Movie({
    required this.id,
    required this.image,
    required this.title,
    required this.releaseDate,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      image: AppImages.eternal,
      title: 'Вечное сияние чистого разума',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 2,
      image: AppImages.eternal,
      title: 'Революция',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 3,
      image: AppImages.eternal,
      title: 'Герои',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 4,
      image: AppImages.eternal,
      title: 'Сталкер',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 5,
      image: AppImages.eternal,
      title: 'Брат',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 6,
      image: AppImages.eternal,
      title: 'Таракан',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 7,
      image: AppImages.eternal,
      title: 'Мир и война',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 8,
      image: AppImages.eternal,
      title: 'Мыши',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 9,
      image: AppImages.eternal,
      title: 'Все пидоры говорят нет',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
    Movie(
      id: 10,
      image: AppImages.eternal,
      title: 'Бород Гога',
      releaseDate: '9 марта 2004',
      description:
          'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
    ),
  ];

  final _searchController = TextEditingController();

  List _filteredMovies = <Movie>[];

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutsNames.movieDetails,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163, // высота одной карточки списка
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      border: Border.all(
                        color: Colors.black.withOpacity(0.25),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      boxShadow: [
                        // делаем тень
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), //цвет и прозрачность
                          blurRadius: 8.0, //размытие тени
                          offset:
                              const Offset(0, 2), // смещение тени из-под карты
                        ),
                      ],
                    ),
                    clipBehavior:
                        Clip.hardEdge, // чтобы картинка скруглялась тоже
                    child: Row(
                      children: [
                        Image(
                          image: movie.image,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1, // макс кол-во строк
                                overflow:
                                    TextOverflow.ellipsis, // многоточие после
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                movie.releaseDate,
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                maxLines: 1, // макс кол-во строк
                                overflow:
                                    TextOverflow.ellipsis, // многоточие после
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                movie.description,
                                maxLines: 3, // макс кол-во строк
                                overflow:
                                    TextOverflow.ellipsis, // многоточие после
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white70.withAlpha(215),
            ),
          ),
        ),
      ],
    );
  }
}
