const router = require('express').Router();
const listsController = require('../controllers/listController');

router.get(
    "/:id",
    listsController.getList
)

router.get(
    "/user/:email",
    listsController.getUserLists
)

router.post(
    "/new",
    listsController.createList
)

router.put(
    "/:id",
    listsController.updateList
)

router.delete(
    "/:id",
    listsController.deleteList
)

router.put(
    "/add/:title",
    listsController.addBookToList
)

router.put(
    "/remove/:id",
    listsController.removeBookFromList
)

module.exports = router;