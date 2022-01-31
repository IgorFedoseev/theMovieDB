
import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';
import 'package:lazyload_flutter_course/lessons_examples/draw_radial_percent_widget/radial_percent_widget.dart';

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
        SizedBox(height: 25),
        _Staff(),
        SizedBox(height: 20.0),
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
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white),
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
    return Center(
      child: Container(
        child: Stack(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 6.0, top: 18.0, bottom: 18.0),
              child: Image(image: AppImages.eternalSecondaryTop),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AppImages.eternalMainTop,
            fit: BoxFit.cover,
          ),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 16.0),
          children: [
            TextSpan(
              text: 'Eternal Sunshine of the Spotless Mind ',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
              ),
            ),
            TextSpan(text: '(2004)'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              SizedBox(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  percent: 0.758,
                  backgroungColor: Colors.black,
                  activeLineColor: Colors.green,
                  restLineColor: Colors.white,
                  lineWidth: 3.0,
                ),
              ),
               SizedBox(width: 14),
               Text('Рейтинг'),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: 1.0,
          height: 16.0,
        ),
        TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.play_arrow),
                SizedBox(width: 6.0),
                Text('Смотреть трейлер'),
              ],
            )),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 66.0),
        child: Text(
          'Выход в прокат: 9 марта 2004 \nМелодрама, фантастика, драма \nДлительность: 108 мин. / 01:48',
          maxLines: 3,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

class _Staff extends StatelessWidget {
  const _Staff({Key? key}) : super(key: key);

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Мишель Гондри',
                  style: staffNameStyle,
                ),
                Text(
                  'Режиссер',
                  style: staffRoleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Чарли Кауфман',
                  style: staffNameStyle,
                ),
                Text(
                  'Сценарий',
                  style: staffRoleStyle,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Джим Керри',
                  style: staffNameStyle,
                ),
                Text(
                  'В главных ролях',
                  style: staffRoleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Кейт Уинслет',
                  style: staffNameStyle,
                ),
                Text(
                  'В главных ролях',
                  style: staffRoleStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
