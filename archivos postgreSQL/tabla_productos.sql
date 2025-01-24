CREATE TABLE IF NOT EXISTS public.productos
(
    "idProd" INTEGER NOT NULL DEFAULT nextval('productos_idProd_seq'::regclass),
    nombre CHARACTER VARYING(200) NOT NULL,
    stock NUMERIC(5, 0) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL,
    estado CHARACTER(1) NOT NULL,
    idcategoria INTEGER,
    "valorTotal" NUMERIC(10, 2) NOT NULL,
    CONSTRAINT pk_productos PRIMARY KEY ("idProd"),
    CONSTRAINT fk_idcategoria FOREIGN KEY (idcategoria)
        REFERENCES public.categorias (idcategoria)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Inserción de datos en productos
INSERT INTO public.productos ("idProd", nombre, stock, precio, estado, idcategoria, "valorTotal")
VALUES
    (1, 'Jabón Ariel', 5, 34000.00, 'A', 4, 170000.00),
    (2, 'Escoba', 7, 14900.00, 'A', 4, 104300.00),
    (3, 'Leche', 20, 5390.00, 'A', 1, 98000.00),
    (4, 'Lenteja', 10, 5057.80, 'A', 2, 38000.00),
    (5, 'Frijol', 20, 12644.50, 'A', 2, 190000.00);

CREATE TABLE IF NOT EXISTS public.categorias
(
    idcategoria SERIAL PRIMARY KEY, -- Generación automática de ID
    nombre_categoria CHARACTER VARYING(100) NOT NULL,
    estado CHARACTER(1) NOT NULL -- Columna para el estado ('A', 'I', etc.)
);