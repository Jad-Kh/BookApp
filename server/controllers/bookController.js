const KEY = process.env.GOOGLE_BOOKS_API_KEY
const { filter } = require('../filters/bookFilter')
const axios = require('axios')

exports.getManyBooksByISBN = async(request, response) => {
    console.log("Hello")
    try {
        const books = []
        await Promise.all(
            request.body.isbns.map(async(isbn) => {
                const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=isbn:${isbn}&key=${KEY}`)
                call.data.items.map(async(item) => {
                    books.push(filter(item))
                })
            })
        )
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.getBookByDynamic = async(request, response) => {
    let search = ""
    JSON.parse(JSON.stringify(request.body), (key, value) => {
        if(key != "") {
            search += `in${key}:${value}&`
        }
    })
    try {
        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=${search}key=${KEY}`)
        const books = []
        call.data.items.map(async(item) => {
            books.push(filter(item))
        })
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.getBookByISBN = async(request, response) => {
    try {
        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=isbn:${request.params.isbn}&key=${KEY}`)
        const books = []
        call.data.items.map(async(item) => {
            books.push(filter(item))
        })
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.getBookByTitle = async(request, response) => {
    try {
        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=intitle:${request.params.title}&key=${KEY}`)
        const books = []
        call.data.items.map(async(item) => {
            books.push(filter(item))
        })
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.getBookByAuthor = async(request, response) => {
    try {
        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=inauthor:${request.params.author}&key=${KEY}`)
        const books = []
        call.data.items.map(async(item) => {
            books.push(filter(item))
        })
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.getBookByPublisher = async(request, response) => {
    try {
        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=insubject:${request.params.subject}&key=${KEY}`)
        const books = []
        call.data.items.map(async(item) => {
            books.push(filter(item))
        })
        return response.status(200).json(books)
    } catch(error) {
        return response.status(500).json(error)
    }
}