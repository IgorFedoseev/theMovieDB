import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/app_images.dart';

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
          SizedBox(
            height: 280,
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 25,
                itemExtent: 160,
                itemBuilder: (BuildContext context, int index) {
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
                          const Image(
                            image: AppImages.eternalSecondaryTop,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Actor name',
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
                                ),
                                SizedBox(height: 3.0),
                                Text('Role', maxLines: 1,),
                                SizedBox(height: 3.0),
                                Text('Rating 5.0', maxLines: 1,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
