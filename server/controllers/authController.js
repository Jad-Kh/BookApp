const bcrypt = require("bcrypt")
const { firebase } = require("../admin")

exports.createUser = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const check = await usersRef.where('email', '==', request.body.email).get()
        if (!check.empty) {
            return response.status(403).json("email already exists")
        }    

        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(request.body.password, salt)

        const user = {
            username: request.body.username,
            email: request.body.email,
            password: hashedPassword,
            lists: [],
            friends: [],
            requests: []
        }

        await usersRef.doc().set(user)
        return response.status(200).json(user)
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.logInUser = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const user = await usersRef.where('email', '==', request.body.email).get()
        if (user.empty) {
            return response.status(404).json("user not found")
        }    

        user.forEach(async(doc) => {
            await bcrypt.compare(request.body.password, doc.data().password).then((valid) => {
                if(!valid) {
                    return response.status(404).json("wrong password")
                } else {
                    return response.status(200).json('logged in')
                }
            })
        })
    } catch(error) {
        return response.status(500).json(error)
    }
}