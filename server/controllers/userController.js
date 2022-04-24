const { firebase } = require("../admin")

exports.getUser = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const user = await usersRef.doc(request.params.id).get()
        return response.status(200).json(user.data())
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.updateUser = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        await usersRef.doc(request.params.id).update(request.body)
        return response.status(200).json('update')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.deleteUser = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        await usersRef.doc(request.params.id).delete()
        return response.status(200).json('deleted')
    } catch(error) {
        return response.status(500).json(error)
    }
}