import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/http_queries_model.dart';

class HttpQueriesExample extends StatefulWidget {
  const HttpQueriesExample({Key? key}) : super(key: key);

  @override
  State<HttpQueriesExample> createState() => _HttpQueriesExampleState();
}

class _HttpQueriesExampleState extends State<HttpQueriesExample> {
  final model = HttpExampleWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HttpExampleModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ReloadButton(),
              _CreateButton(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _PostsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          HttpExampleModelProvider.read(context)?.model.reloadPosts(),
      child: Text('обновить посты'),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          HttpExampleModelProvider.read(context)?.model.createPosts(),
      child: Text('создать пост'),
    );
  }
}

class _PostsWidget extends StatelessWidget {
  const _PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          HttpExampleModelProvider.watch(context)?.model.posts.length ?? 0,
      itemBuilder: (BuildContext context, int index) =>
          _PostsRowWidget(index: index),
    );
  }
}

class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = HttpExampleModelProvider.read(context)!.model.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(height: 10),
        Text(post.title),
        const SizedBox(height: 10),
        Text(post.body),
        const SizedBox(height: 40),
      ],
    );
  }
}
