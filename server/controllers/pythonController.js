const KEY = process.env.GOOGLE_BOOKS_API_KEY
const { filter } = require('../filters/bookFilter')
const axios = require('axios')

exports.get = async(request, response) => {
    try {
        const suggestions = await axios.get("http://127.0.0.1:5000/")
        
        return response.status(200).json(suggestions.data)
    } catch(error) {
        return response.status(500).json(error)
    }
}