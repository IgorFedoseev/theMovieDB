import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/widgets/movie_details/movie_details_model.dart';

class MovieDetailsCastScreenWidget extends StatelessWidget {
  const MovieDetailsCastScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Актерский состав',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 325,
            child: Scrollbar(
              child: _CastListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('В фильме также снимались'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CastListWidget extends StatelessWidget {
  const _CastListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cast.length,
      itemExtent: 160,
      itemBuilder: (BuildContext context, int index) {
        return _CastUnitWidget(actorIndex: index);
      },
    );
  }
}

class _CastUnitWidget extends StatelessWidget {
  final int actorIndex;
  const _CastUnitWidget({
    Key? key,
    required this.actorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final actor = model!.movieDetails!.credits.cast[actorIndex];
    final photo = actor.profilePath;
    final actorPhoto = photo != null
        ? Image.network(ApiClient.imageUrl(photo))
        : const Image(image: AppImages.eternalSecondaryTop);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.0,
              offset: const Offset(3, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Image(
              image: actorPhoto.image,
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15.0),
                      ),
                      Text(
                        actor.character,
                        maxLines: 2,
                      ),
                      Text(
                        'rating: ${actor.popularity.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.blueGrey),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
