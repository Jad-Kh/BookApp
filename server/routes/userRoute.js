const router = require('express').Router();
const usersController = require('../controllers/userController');

router.get(
    '/:id',
    usersController.getUser
);

router.put(
    '/:id',
    usersController.updateUser
);

router.delete(
    '/:id',
    usersController.deleteUser
);

router.put(
    '/sendrequest/:id',
    usersController.sendUserFriendRequest
);

router.put(
    '/acceptrequest/:id',
    usersController.acceptUserFriendRequest
);

router.put(
    '/declinerequest/:id',
    usersController.declineUserFriendRequest
);

router.put(
    '/cancelrequest/:id',
    usersController.cancelUserFriendRequest
);

module.exports = router;