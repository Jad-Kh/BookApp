const router = require('express').Router();
const pythonController = require('../controllers/pythonController');

router.get(
    "/:email",
    pythonController.get
)

module.exports = router;