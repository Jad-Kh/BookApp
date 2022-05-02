const KEY = process.env.GOOGLE_BOOKS_API_KEY
const { firebase } = require("../admin")
const { FieldValue } = require('firebase-admin/firestore')
const { filter } = require('../filters/bookFilter')
const axios = require('axios')

exports.getUserLists = async(request, response) => {
    const usersRef = firebase.collection('users')
    const listsRef = firebase.collection('lists')
    try {
        const user = await usersRef.where('email', '==', request.params.email).get()
        let userId;
        user.docs.map((doc) => {
            userId = doc.id
        })
        const lists = await listsRef.where('userId', '==', userId).get()
        const userLists = []
        await Promise.all(
            lists.docs.map(async(list) => {
                const books = []
                await Promise.all(
                    list.data().items.map(async(item) => {
                        const call = await axios.get(`https://www.googleapis.com/books/v1/volumes?q=isbn:${item}&key=${KEY}`)
                        call.data.items.map(async(item) => {
                            books.push(filter(item))
                        })
                    })
                )
                userList = {
                    title: list.title,
                    books: books,
                }
                userLists.push(userList)
            })
        ) 
        return response.status(200).json(userLists)
    } catch(error) {
        console.log(error)
        return response.status(500).json(error)
    }
}

exports.getList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        const list = await listsRef.doc(request.params.id).get()
        return response.status(200).json(list.data())
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.createList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        const newList = {
            title: request.body.title,
            userId: request.body.userId,
            items: []
        }

        await listsRef.doc().set(newList)
        return response.status(200).json(newList)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.updateList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        await listsRef.doc(request.params.id).update(request.body)
        return response.status(200).json('update')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.deleteList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        await listsRef.doc(request.params.id).delete()
        return response.status(200).json('deleted')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.addBookToList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        const list = await listsRef.doc(request.params.id).get()
        if(list.data().items.includes(request.body.isbn)) {
            return response.status(401).json('book is already in list')
        } else {
            await listsRef.doc(request.params.id).update({
                items: FieldValue.arrayUnion(request.body.isbn)
            })
        }
        return response.status(200).json('added book')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.removeBookFromList = async(request, response) => {
    const listsRef = firebase.collection('lists')
    try {
        await listsRef.doc(request.params.id).update({
            items: FieldValue.arrayRemove(request.body.isbn)
        })
        return response.status(200).json('removed book from list')
    } catch(error) {
        return response.status(500).json(error)
    }
}