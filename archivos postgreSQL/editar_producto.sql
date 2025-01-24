CREATE OR REPLACE FUNCTION editar_producto(
    _idProd INTEGER,
    _nombre CHARACTER VARYING(200),
    _stock NUMERIC(5, 0),
    _precio NUMERIC(10, 2),
    _estado CHARACTER(1),
    _idcategoria INTEGER,
    _valorTotal NUMERIC(10, 2)
)
RETURNS VOID AS $$
BEGIN
    UPDATE public.productos
    SET nombre = _nombre,
        stock = _stock,
        precio = _precio,
        estado = _estado,
        idcategoria = _idcategoria,
        "valorTotal" = _valorTotal
    WHERE "idProd" = _idProd;
END;
$$ LANGUAGE plpgsql;

SELECT editar_producto(1, 'Producto Editado', 150, 19.99, 'A', 1, 2998.50);

select * from public.productos p ;
