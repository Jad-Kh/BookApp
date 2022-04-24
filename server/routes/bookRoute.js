const router = require('express').Router();
const booksController = require('../controllers/bookController');

router.get(
    '/:title',
    booksController.getBookByTitle
);

module.exports = router;