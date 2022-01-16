import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemExtent: 163, // высота одной карточки списка
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      color:
                          Colors.black.withOpacity(0.3), //цвет и прозрачность
                      blurRadius: 8.0, //размытие тени
                      offset: const Offset(0, 2), // смещение тени из-под карты
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge, // чтобы картинка скруглялась тоже
                child: Row(
                  children: [
                    const Image(
                      image: AppImages.imageEternal,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 20.0),
                          Text(
                            'Вечное сияние чистого разума',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1, // макс кол-во строк
                            overflow:
                                TextOverflow.ellipsis, // многоточие после
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '9 марта 2004',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                            maxLines: 1, // макс кол-во строк
                            overflow:
                                TextOverflow.ellipsis, // многоточие после
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Застенчивый и меланхоличный Джоэл живёт ничем не примечательной серой и унылой жизнью. Но однажды вместо привычного рабочего маршрута молодой человек вдруг садится на электричку в другом направлении и устремляется к морю. На песчаном берегу Джоэл замечает девушку с ярко-синими волосами. На обратном пути они знакомятся в вагоне электрички и парень понимает, что у них с Клементиной очень много общего, как будто он уже знает эту девушку. Совсем скоро Джоэл поймёт, что действительно был знаком с ней, более того - они были парой.',
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
                  onTap: () => print('1'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
