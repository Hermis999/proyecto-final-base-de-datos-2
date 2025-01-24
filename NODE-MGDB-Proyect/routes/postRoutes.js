const express = require('express');
const router = express.Router();
const postController = require('../controllers/postController');

router.get('/', postController.indexProd);
router.get('/create', postController.create);
router.post('/store', postController.store);
router.get('/edit/:id', postController.edit); 
router.post('/update/:id', postController.update);
router.get('/delete/:id', postController.delete);

module.exports = router;

