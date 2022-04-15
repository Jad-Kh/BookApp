class Book {
  int id;
  String title;
  String publisher;
  String date;
  String description;
  int pages;
  List<String> categories;
  int ratingaverage;
  int ratingnumber;
  String thumbnail;
  String bigthumbnail;

  Book({
    required this.id,
    required this.title,
    required this.publisher,
    required this.date,
    required this.description,
    required this.pages,
    required this.categories,
    required this.ratingaverage,
    required this.ratingnumber,
    required this.thumbnail,
    required this.bigthumbnail,
  });
}

List<Book> books_carousel = [
  Book(
    id: 1,
    title: "Other Words for Home",
    publisher: "Jasmine Warga",
    date: "2005-11-09",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    pages: 315,
    categories: [
      "Adventure",
      "Romance"
    ],
    ratingaverage: 4,
    ratingnumber: 1781,
    thumbnail: 'assets/images/other_words_for_home.jpg',
    bigthumbnail: 'assets/images/other_words_for_home.jpg',
  ),
  Book(
    id: 2,
    title: "The Metropolist",
    publisher: "Seth Fried",
    date: "2007-03-06",
    description: "description goes here",
    pages: 367,
    categories: [
      "Science Fiction",
      "Pulb Fiction"
    ],
    ratingaverage: 3,
    ratingnumber: 1239,
    thumbnail: 'assets/images/the_metropolist.jpg',
    bigthumbnail: 'assets/images/the_metropolist.jpg',
  ),
  Book(
    id: 3,
    title: "The Tiny Dragon",
    publisher: "Rupert Carter",
    date: "2013-01-02",
    description: "description goes here",
    pages: 160,
    categories: [
      "Adventure",
      "Sketchbook"
    ],
    ratingaverage: 4,
    ratingnumber: 437,
    thumbnail: 'assets/images/the_tiny_dragon.jpg',
    bigthumbnail: 'assets/images/the_tiny_dragon.jpg',
  ),
];

List<Book> books_list = [
  Book(
    id: 1,
    title: "The Tiny Dragon",
    publisher: "Rupert Carter",
    date: "2013-01-02",
    description: "description goes here",
    pages: 160,
    categories: [
      "Adventure",
      "Sketchbook"
    ],
    ratingaverage: 4,
    ratingnumber: 437,
    thumbnail: 'assets/images/the_tiny_dragon.jpg',
    bigthumbnail: 'assets/images/the_tiny_dragon.jpg',
  ),
  Book(
    id: 2,
    title: "Underland",
    publisher: "Robert Macfarlane",
    date: "2015-04-04",
    description: "description goes here",
    pages: 899,
    categories: [
      "Adventure",
      "Mistery"
    ],
    ratingaverage: 4,
    ratingnumber: 1567,
    thumbnail: 'assets/images/underland.jpg',
    bigthumbnail: 'assets/images/underland.jpg',
  ),
  Book(
    id: 3,
    title: "Other Words for Home",
    publisher: "Jasmine Warga",
    date: "2005-11-09",
    description: "description goes here",
    pages: 315,
    categories: [
      "Adventure",
      "Romance"
    ],
    ratingaverage: 4,
    ratingnumber: 1781,
    thumbnail: 'assets/images/other_words_for_home.jpg',
    bigthumbnail: 'assets/images/other_words_for_home.jpg',
  ),
  Book(
    id: 4,
    title: "The Metropolist",
    publisher: "Seth Fried",
    date: "2007-03-06",
    description: "description goes here",
    pages: 367,
    categories: [
      "Science Fiction",
      "Pulb Fiction"
    ],
    ratingaverage: 3,
    ratingnumber: 1239,
    thumbnail: 'assets/images/the_metropolist.jpg',
    bigthumbnail: 'assets/images/the_metropolist.jpg',
  ),
];