CREATE TABLE IF NOT EXISTS public.auditoria_cambios_productos
(  id SERIAL Primary key,
   idProd INT NOT NULL,  -- guardar el id del usuario que se afecto
   operacion VARCHAR(10) NOT NULL, -- UPDATE, DELETE, INSERT
   fecha TIMESTAMP DEFAULT now(),
   datos JSONB 
);

CREATE OR REPLACE FUNCTION auditoria_cambios_productos()
RETURNS TRIGGER 
AS
$$
BEGIN
	IF (TG_OP = 'DELETE')THEN
		INSERT INTO public.auditoria_cambios_productos (idProd, operacion, datos) VALUES (OLD."idProd",'DELETE', row_to_json(OLD)); 
			
	ELSEIF (TG_OP = 'UPDATE') THEN
	    INSERT INTO public.auditoria_cambios_productos (idProd, operacion, datos) 
		VALUES (NEW."idProd",'UPDATE', row_to_json('old',row_to_json(OLD),'new',row_to_json(NEW)));
	ELSEIF (TG_OP = 'INSERT') THEN
		 INSERT INTO public.auditoria_cambios_productos (idProd, operacion, datos) VALUES (NEW."idProd",'INSERT', row_to_json(NEW));
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER trigger_auditoria_cambios_productos
AFTER INSERT OR UPDATE OR DELETE
ON productos
FOR EACH ROW
EXECUTE FUNCTION auditoria_cambios_productos();
