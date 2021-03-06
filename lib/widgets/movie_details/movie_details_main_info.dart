import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/entity/movie_details_credits.dart';
import 'package:lazyload_flutter_course/lessons_examples/draw_radial_percent_widget/radial_percent_widget.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';
import 'package:lazyload_flutter_course/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainWidget extends StatelessWidget {
  const MovieDetailsMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TopPosterWidget(),
        _MovieNameWidget(),
        _RatingWidget(),
        _SummaryWidget(),
        SizedBox(height: 20.0),
        _OverviewHeader(),
        _OverviewText(),
        SizedBox(height: 15),
        _Staff(),
        SizedBox(height: 10),
      ],
    );
  }
}

class _OverviewText extends StatelessWidget {
  const _OverviewText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        overview,
        maxLines: 15,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _OverviewHeader extends StatelessWidget {
  const _OverviewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Описание',
      style: TextStyle(
          fontWeight: FontWeight.w800, fontSize: 24.0, color: Colors.white),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    final backgroundImage = backdropPath != null
        ? Image.network(ApiClient.imageUrl(backdropPath))
        : const Image(image: AppImages.eternalMainTop);
    final posterImage = posterPath != null
        ? Image.network(ApiClient.imageUrl(posterPath))
        : const Image(image: AppImages.eternalSecondaryTop);
    final isFavorite = model?.isFavorite == true ? true : false;
    return Center(
      child: Container(
        child: Stack(
          //fit: StackFit.expand,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 6.0, top: 18.0, bottom: 18.0),
              child: posterImage,
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: IconButton(
                  onPressed: () => model?.toggleFavorite(),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.red,
                    size: 30,
                  )),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage.image),
        ),
        constraints: const BoxConstraints.expand(
          width: 390,
          height: 220,
        ),
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieYear = model?.movieDetails?.releaseDate?.year.toString();
    final year = movieYear != null ? ' ($movieYear)' : '';
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 18.0),
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            TextSpan(text: year),
          ],
        ),
      ),
    );
  }
}

class _RatingWidget extends StatelessWidget {
  const _RatingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final voteAverage = model?.movieDetails?.voteAverage ?? 0;
    final voteAveragePercent = voteAverage / 10;
    final videoResults = model?.movieDetails?.videos.results;
    final trailerVideos = videoResults
        ?.where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey =
        trailerVideos?.isNotEmpty == true ? trailerVideos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  percent: voteAveragePercent,
                  backgroungColor: Colors.black,
                  activeLineColor: Colors.green,
                  restLineColor: Colors.white,
                  lineWidth: 3.0,
                ),
              ),
              const SizedBox(width: 14),
              const Text('Рейтинг'),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: 1.0,
          height: 16.0,
        ),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                      MainNavigationRoutsNames.movieTrailer,
                      arguments: trailerKey,
                    ),
                child: Row(
                  children: const [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 6.0),
                    Text('Смотреть трейлер'),
                  ],
                ))
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];

    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      final country = '(${productionCountries.first.iso})';
      texts.add(country);
    }

    final runtime = model.movieDetails?.runtime ?? 0;
    final durationInMinutes = Duration(minutes: runtime);
    final hours = durationInMinutes.inHours;
    final minutes = durationInMinutes.inMinutes.remainder(60);
    final duration = '$hoursч $minutesмин';
    texts.add(duration);

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = [];
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      final genresString = genresNames.join(', ');
      texts.add(genresString);
    }
    return ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
        child: Text(
          texts.join(' '),
          //'Выход в прокат: 9 марта 2004 \nМелодрама, фантастика, драма \nДлительность: 108 мин. / 01:48',
          maxLines: 3,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

class _Staff extends StatelessWidget {
  const _Staff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Crew>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
      children: crewChunks
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: _StaffRowWidget(
                crew: chunk,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StaffRowWidget extends StatelessWidget {
  final List<Crew> crew;
  const _StaffRowWidget({Key? key, required this.crew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: crew
            .map((unit) => _StaffRowWidgetItem(
                  unit: unit,
                ))
            .toList(),
      ),
    );
  }
}

class _StaffRowWidgetItem extends StatelessWidget {
  final Crew unit;
  const _StaffRowWidgetItem({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const staffNameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    const staffRoleStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(unit.name, style: staffNameStyle),
          Text(unit.job, style: staffRoleStyle),
        ],
      ),
    );
  }
}
