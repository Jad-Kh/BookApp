const router = require('express').Router();
const pythonController = require('../controllers/pythonController');

router.get(
    "/",
    pythonController.get
)

module.exports = router;