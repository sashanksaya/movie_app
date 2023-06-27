import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:text_scroll/text_scroll.dart';

import '../utils/get_movies.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const routeName = "/searchPage";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String movieName = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Discover Movies",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                movieName = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 90, 89, 91),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60),
                borderSide: BorderSide.none,
              ),
              hintText: "Enter a movie name...",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          FutureBuilder<List<Movie>>(
              future: getSearchedMovie(movieName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final movieList = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: movieList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: SizedBox(
                          height: 170,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Card(
                                elevation: 5,
                                shadowColor:
                                    const Color.fromARGB(255, 63, 59, 59),
                                color: const Color.fromARGB(255, 63, 59, 59),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      MovieDetailPage.routeName,
                                      arguments: {
                                        'movie': movieList[index],
                                        'category': 'search'
                                      },
                                    );
                                  },
                                  leading: const SizedBox(
                                    width: 90,
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      movieList[index].title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 60,
                                        child: Text(
                                          movieList[index].description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Rating: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${movieList[index].rating.toString()}/10",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    movieList[index].image,
                                    fit: BoxFit.fill,
                                    width: 105,
                                    height: 150,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
