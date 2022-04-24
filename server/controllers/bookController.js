const KEY = process.env.GOOGLE_BOOKS_API_KEY
const { filter } = require('../filters/bookFilter')
const axios = require('axios')

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

