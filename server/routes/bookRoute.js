const router = require('express').Router();
const booksController = require('../controllers/bookController');

router.get(
    '/many',
    booksController.getManyBooksByISBN
);

router.get(
    '/dynamic',
    booksController.getBookByDynamic
);

router.get(
    '/:isbn',
    booksController.getBookByISBN
);

router.get(
    '/title/:title',
    booksController.getBookByTitle
);

router.get(
    '/author/:author',
    booksController.getBookByAuthor
);

router.get(
    '/publisher/:publisher',
    booksController.getBookByPublisher
);

module.exports = router;