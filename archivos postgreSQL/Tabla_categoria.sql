CREATE TABLE IF NOT EXISTS public.categorias
(
    idcategoria SERIAL PRIMARY KEY, -- Generación automática de ID
    nombre_categoria CHARACTER VARYING(100) NOT NULL,
    estado CHARACTER(1) NOT NULL -- Columna para el estado ('A', 'I', etc.)
);

-- Inserción de datos en categorias
INSERT INTO public.categorias (idcategoria, nombre, estado)
VALUES
    (1, 'Lácteos', 'A'),
    (2, 'Granos', 'A'),
    (3, 'Harinas', 'A'),
    (4, 'Limpieza', 'A');