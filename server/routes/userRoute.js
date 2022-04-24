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

module.exports = router;