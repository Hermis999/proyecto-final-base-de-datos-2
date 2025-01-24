const conexP = require('../config/dbPostgre');

// función para listar los productos
exports.indexProd = async (req, res) => {
    try {
        const consulta = `SELECT * FROM consultar_producto($1);`;

        const resultado = await conexP.query(consulta);
        
        resultado.rows.forEach(producto => {
            producto.valor = producto.precio * producto.stock;
        });

        res.render('post/productos', { productos: resultado.rows });
    } catch (error) {
        console.error('Error al obtener todos los productos:', error);
        res.status(500).json({
            message: 'Hubo un error al obtener los productos',
            error: error.message
        });
    }
};

// Funcion para mostrar el formulario de crear un nuevo producto
exports.create = async (req, res) => {
    try {
        // Consulta para obtener las categorías
        const consultaCategorias = `SELECT idcategoria, nombre FROM categorias;`;
        const categorias = await conexP.query(consultaCategorias);

        // Renderiza la vista y pasa las categorías como variable
        res.render('post/create', { categorias: categorias.rows });
    } catch (error) {
        console.error('Error al cargar las categorías:', error);
        res.status(500).json({
            message: 'Hubo un error al cargar las categorías',
            error: error.message
        });
    }
};

// función para registrar un nuevo producto
exports.store = async (req, res) => {
    const { nombre, stock, precio, estado, idcategoria } = req.body;

    const valorTotal = stock * precio;

    try {
        const consulta = `SELECT insertar_producto($1, $2, $3, $4, $5, $6);`;
        const values = [nombre, stock, precio, estado, idcategoria, valorTotal];

        const resultado = await conexP.query(consulta, values);
        res.redirect('/post');
    } catch (error) {
        console.error('Error al registrar el producto:', error);
        res.status(500).json({
            message: 'Hubo un error al registrar el producto',
            error: error.message
        });
    }
};

// Función para mostrar el formulario de edición del producto
exports.edit = async (req, res) => {
    const { id } = req.params;

    try {
        const consulta = `SELECT p."idProd", p.nombre, p.stock, p.precio, p.estado, p.idcategoria, c.nombre AS categoria
                        FROM productos p
                        JOIN categorias c ON p.idcategoria = c.idcategoria
                        WHERE p."idProd" = $1;`;

        const resultado = await conexP.query(consulta, [id]);

        if (resultado.rows.length === 0) {
            return res.status(404).json({ message: 'Producto no encontrado' });
        }

        const consultaCategorias = `SELECT idcategoria, nombre FROM categorias;`;
        const categorias = await conexP.query(consultaCategorias);

        res.render('post/edit', { 
            producto: resultado.rows[0],
            categorias: categorias.rows 
        });

    } catch (error) {
        console.error('Error al obtener el producto:', error);
        res.status(500).json({
            message: 'Hubo un error al obtener el producto.',
            error: error.message
        });
    }
};

// Función para actualizar un producto
exports.update = async (req, res) => {
    const { id } = req.params;
    const { nombre, stock, precio, estado, idcategoria } = req.body;

    const valorTotal = stock * precio;

    try {
        const consulta = `SELECT editar_producto($1, $2, $3, $4, $5, $6, $7);`;
        const values = [id, nombre, stock, precio, estado, idcategoria, valorTotal];

        const resultado = await conexP.query(consulta, values);

        if (resultado.rows.length === 0) {
            return res.status(404).json({ message: 'Producto no encontrado' });
        }

        // Redirigir a la lista de productos
        res.redirect('/post');
    } catch (error) {
        console.error('Error al actualizar el producto:', error);
        res.status(500).json({
            message: 'Hubo un error al actualizar el producto.',
            error: error.message
        });
    }
};

// Eliminar un producto
exports.delete = async (req, res) => {
    const { id } = req.params;

    try {
        const consulta = `SELECT eliminar_producto($1);`;
        const values = [id];

        const resultado = await conexP.query(consulta, values);

        if (resultado.rows.length === 0) {
            return res.status(404).json({ message: 'Producto no encontrado' });
        }

        res.redirect('/post');

    } catch (error) {
        console.error('Error al eliminar el producto:', error);
        res.status(500).json({
            message: 'Hubo un error al eliminar el producto.',
            error: error.message
        });
    }
};