const express = require('express');
const router = express.Router();
const mortyController = require('../controllers/mortyController');

router.get('/', mortyController.readMorty);
router.get('/:id', mortyController.readMortyById);


module.exports = router;

