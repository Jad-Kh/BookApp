const router = require('express').Router();
const mapController = require('../controllers/mapController');

router.get(
    "/:lat/:lng",
    mapController.getStores
)

module.exports = router;