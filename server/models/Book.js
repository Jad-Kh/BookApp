class Book {
    constructor(isbn, title, publisher, date, description, pages, categories, ratingaverage, ratingnumber, thumbnail, bigthumbnail) {
        this.isbn = isbn;
        this.title = title;
        this.publisher = publisher;
        this.date = date;
        this.description = description;
        this.pages = pages;
        this.categories = categories;
        this.ratingaverage = ratingaverage;
        this.ratingnumber = ratingnumber;
        this.thumbnail = thumbnail;
        this.bigthumbnail = bigthumbnail;
    }
}

module.exports = Book;