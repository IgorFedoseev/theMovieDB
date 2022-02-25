import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/movie_list/movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.movies.length,
          itemExtent: 163, // высота одной карточки списка
          itemBuilder: (BuildContext context, int index) {
            model.showedMovieAtIndex(index);
            final movie = model.movies[index];
            final posterPath = movie.posterPath;
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
                        posterPath != null
                            ? Image.network(
                                ApiClient.imageUrl(posterPath),
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox.shrink(),
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
                                model.stringFromDate(movie.releaseDate),
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                maxLines: 1, // макс кол-во строк
                                overflow:
                                    TextOverflow.ellipsis, // многоточие после
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                movie.overview,
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
                      onTap: () => model.onMovieTap(context, index),
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
