CREATE OR REPLACE FUNCTION insertar_producto(
    _nombre CHARACTER VARYING(200),
    _stock NUMERIC(5, 0),
    _precio NUMERIC(10, 2),
    _estado CHARACTER(1),
    _idcategoria INTEGER,
    _valorTotal NUMERIC(10, 2)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO public.productos (nombre, stock, precio, estado, idcategoria, "valorTotal")
    VALUES (_nombre, _stock, _precio, _estado, _idcategoria, _valorTotal);
END;
$$ LANGUAGE plpgsql;

SELECT setval('productos_idProd_seq', (SELECT MAX("idProd") FROM productos)); Esto ajusta la secuencia productos_idProd_seq al valor máximo actual de idProd en la tabla productos.


SELECT insertar_producto('Producto Test', 100, 9.99, 'A', 1, 999.00);

select * from public.productos;
