exports.filter = (item) => {

    let isbn
    let title
    let author
    let publisher
    let date
    let description
    let pages
    let categories
    let ratingaverage
    let ratingnumber
    let thumbnail

    isbn = nullCheck(item?.volumeInfo.industryIdentifiers[1]?.identifier)
    title = nullCheck(item.volumeInfo.title)
    author = nullCheck(item.volumeInfo.author)
    publisher = nullCheck(item.volumeInfo.publisher)
    date = nullCheck(item.volumeInfo.publishedDate)
    description = nullCheck(item.volumeInfo.description)
    pages = nullCheckNum(item.volumeInfo.pageCount)
    categories = nullCheck(item.volumeInfo.categories)
    ratingaverage = nullCheckNum(item.volumeInfo.averageRating)
    ratingnumber = nullCheckNum(item.volumeInfo.ratingsCount)
    thumbnail = nullCheck(item.volumeInfo.imageLinks?.thumbnail)

    const book = {
        'isbn': isbn,
        'title': title,
        'author': author,
        'publisher': publisher,
        'date': date,
        'description': description,
        'pages': pages,
        'categories': categories,
        'ratingaverage': ratingaverage,
        'ratingnumber': ratingnumber,
        'thumbnail': thumbnail
    }

    return book
}

const nullCheck = (field) => {
    if(field) {
        return field
    } else {
        return ""
    }
}

const nullCheckNum = (field) => {
    if(field) {
        return field
    } else {
        return 0
    }
}