const router = require('express').Router();
const pythonController = require('../controllers/pythonController');

router.get(
    "/:title",
    pythonController.get
)

module.exports = router;