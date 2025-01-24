CREATE TABLE IF NOT EXISTS public.auditoria_productos
(  id SERIAL Primary key,
   idProd INT NOT NULL,  -- guardar el id del usuario que se afecto
   operacion VARCHAR(10) NOT NULL, -- UPDATE, DELETE, INSERT
   fecha TIMESTAMP DEFAULT now(),
   datos JSONB 
);

CREATE OR REPLACE FUNCTION auditar_productos()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si hubo cambios en stock, precio o ambos
    IF NEW.stock IS DISTINCT FROM OLD.stock OR NEW.precio IS DISTINCT FROM OLD.precio THEN
        INSERT INTO public.auditoria_productos (idProd, operacion, datos)
        VALUES (
            NEW."idProd", 
            'UPDATE', 
            json_build_object(
                'old', json_build_object('stock', OLD.stock, 'precio', OLD.precio),
                'new', json_build_object('stock', NEW.stock, 'precio', NEW.precio)
            )
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER trigger_auditar_productos
AFTER UPDATE ON public.productos
FOR EACH ROW
EXECUTE FUNCTION auditar_productos();


