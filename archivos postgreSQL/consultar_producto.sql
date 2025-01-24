CREATE OR REPLACE FUNCTION consultar_producto(_idProd INTEGER)
RETURNS TABLE (
    "idProd" INTEGER,
    nombre CHARACTER VARYING(200),
    stock NUMERIC(5, 0),
    precio NUMERIC(10, 2),
    estado CHARACTER(1),
    idcategoria INTEGER,
    "valorTotal" NUMERIC(10, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT p."idProd", p.nombre, p.stock, p.precio, p.estado, p.idcategoria, p."valorTotal"
    FROM public.productos p
    WHERE p."idProd" = _idProd;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM consultar_producto(1);
