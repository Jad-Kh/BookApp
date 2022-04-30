exports.filter = (item) => {

    let isbn
    let title
    let publisher
    let date
    let description
    let pages
    let categories
    let ratingaverage
    let ratingnumber
    let thumbnail

    if(item?.volumeInfo.industryIdentifiers) {
        if(item?.volumeInfo.industryIdentifiers[1]?.type == "ISBN_10") {
            isbn = nullCheck(item?.volumeInfo.industryIdentifiers[1]?.identifier)
        } else {
            isbn = nullCheck(item?.volumeInfo.industryIdentifiers[0]?.identifier)
        }   
    } 
    title = nullCheck(item.volumeInfo.title)
    publisher = nullCheck(item.volumeInfo.publisher)
    date = nullCheck(item.volumeInfo.publishedDate)
    description = nullCheck(item.volumeInfo.description)
    pages = nullCheckNum(item.volumeInfo.pageCount)
    categories = nullCheckList(item.volumeInfo.categories)
    ratingaverage = nullCheckDouble(item.volumeInfo.averageRating)
    ratingnumber = nullCheckNum(item.volumeInfo.ratingsCount)
    thumbnail = nullCheck(item.volumeInfo.imageLinks?.thumbnail)

    const book = {
        'isbn': isbn,
        'title': title,
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
        return "none"
    }
}

const nullCheckNum = (field) => {
    if(field) {
        return field
    } else {
        return 0
    }
}

const nullCheckDouble = (field) => {
    if(field) {
        return field
    } else {
        return 0.001
    }
}

const nullCheckList = (field) => {
    if(field) {
        return field
    } else {
        return []
    }
}