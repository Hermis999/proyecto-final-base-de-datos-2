CREATE OR REPLACE FUNCTION eliminar_producto(_idProd INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM public.productos
    WHERE "idProd" = _idProd;
END;
$$ LANGUAGE plpgsql;

SELECT eliminar_producto(1);

select * from public.productos p ;
