const { firebase } = require("../admin")
const { FieldValue } = require('firebase-admin/firestore');

exports.getUserId = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const user = await usersRef.where("email", "==", request.params.email).get()
        let userId;
        user.docs.map((doc) => {
            userId = doc.id
        })
        return response.status(200).json(userId)
    } catch(error) {
        return response.status(500).json(error)
    }
}

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

exports.sendUserFriendRequest = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const reciever = await usersRef.doc(request.params.id).get()
        if(reciever.data().requests.includes(request.body.id)) {
            return response.status(401).json('request already sent')
        } else {
            await usersRef.doc(request.params.id).update({
                requests: FieldValue.arrayUnion(request.body.id)
            })
        }
        return response.status(200).json('sent request')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.acceptUserFriendRequest = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        await usersRef.doc(request.body.id).update({
            requests: FieldValue.arrayRemove(request.params.id),
            friends: FieldValue.arrayUnion(request.params.id)
        })
        await usersRef.doc(request.params.id).update({
            friends: FieldValue.arrayUnion(request.body.id)
        })
        return response.status(200).json('accepted request')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.declineUserFriendRequest = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        await usersRef.doc(request.body.id).update({
            requests: FieldValue.arrayRemove(request.params.id)
        })
        return response.status(200).json('accepted request')
    } catch(error) {
        return response.status(500).json(error)
    }
}

exports.cancelUserFriendRequest = async(request, response) => {
    const usersRef = firebase.collection('users')
    try {
        const reciever = await usersRef.doc(request.params.id).get()
        if(!reciever.data().requests.includes(request.body.id)) {
            return response.status(401).json('request already canceled')
        } else {
            await usersRef.doc(request.params.id).update({
                requests: FieldValue.arrayRemove(request.body.id)
            })
        }
        return response.status(200).json('sent request')
    } catch(error) {
        return response.status(500).json(error)
    }
}