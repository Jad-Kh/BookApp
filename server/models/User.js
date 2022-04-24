class User {
    constructor(username, password, email, lists, friends, requests, points) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.lists = lists;
        this.friends = friends;
        this.requests = requests;
    }
}

module.exports = User;