const KEY = process.env.GOOGLE_BOOKS_API_KEY
const { firebase } = require("../admin")
const { filter } = require('../filters/bookFilter')
const axios = require('axios')

exports.get = async(request, response) => {
    const usersRef = firebase.collection('users')
    const listsRef = firebase.collection('lists')
    try {
        const user = await usersRef.where('email', '==', request.params.email).get()
        let userId;
        user.docs.map((doc) => {
            userId = doc.id
        })
        const lists = await listsRef.where('userId', '==', userId).get()
        const userList = []
        await Promise.all(
            lists.docs.map(async(list) => {
                await Promise.all(
                    list.data().items.map(async(item) => {
                        const suggestions = await axios.get("http://127.0.0.1:5000/" + item)
                        if(suggestions.data == "book not found") {

                        } else {
                            await Promise.all(
                                Object.keys(suggestions.data).map(async(key) => {
                                    if(!userList.includes(key)) {
                                        var isbn = key
                                        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=isbn:${isbn}&key=${KEY}`)
                                        call.data?.items?.map(async(item) => {
                                            userList.push(filter(item))
                                        })
                                    }
                                })
                            )
                        }
                    })
                )
            }) 
        )    
        return response.status(200).json(userList)
    } catch(error) {
        return response.status(500).json(error)
    }
}