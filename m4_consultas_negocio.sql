-- Consulta 1 — Resumen ejecutivo mensual
-- Total Facturado
SELECT 
MONTH(Fecha_Venta) AS Mes,
SUM(Precio_Unitario * Cantidad) AS Total_Facturado
FROM Ventas
GROUP BY MONTH(Fecha_Venta);


-- Cantidad de Pedidos
SELECT 
MONTH(Fecha_Venta) AS Mes,
COUNT(ID_Producto) AS Cantidad_Pedidos
FROM Ventas
GROUP BY MONTH(Fecha_Venta);

-- Ticket Promedio
SELECT
MONTH(Fecha_Venta) AS Mes,
AVG(Precio_Unitario) AS Ticket_Promedio
FROM Ventas
GROUP BY MONTH(Fecha_Venta);



-- Consulta 2 — Ranking de productos
--Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) y el total generado.
SELECT TOP 5 
ID_Producto, 
SUM(Cantidad) AS Unidades_Vendidas,
SUM(Precio_Unitario * Cantidad) AS Total_Generado
FROM Ventas
GROUP BY ID_Producto
ORDER BY Total_Generado;

-- Consulta 3 — Clientes recurrentes
-- id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado.
SELECT  
ID_Cliente,
COUNT(ID_Cliente) AS Cantidad_Pedidos,
SUM(Precio_Unitario * Cantidad) AS Total_Gastado
FROM Ventas
GROUP BY ID_Cliente
HAVING COUNT(*) > 1;

-- Consulta 4 — Productos por encima/por debajo del promedio
-- Total facturado por id_producto
-- con una columna adicional que etiquete con CASE WHEN
-- si ese producto quedó 'Por encima' o 'Por debajo' del promedio de facturación por producto

WITH FacturacionProducto AS (
    SELECT
        ID_Producto,
        SUM(Precio_Unitario * Cantidad) AS Total_Facturado
    FROM Ventas
    GROUP BY ID_Producto
)

SELECT
    ID_Producto,
    Total_Facturado,
    CASE
        WHEN Total_Facturado > (
            SELECT AVG(Total_Facturado)
            FROM FacturacionProducto
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS Comparacion_Promedio
FROM FacturacionProducto
ORDER BY Total_Facturado DESC;


--- Profe este ultimo ejercicio lo entendi por la mitad,por eso lo complete con IA
--- Me gustaria si se puede que me lo pueda explicar, Gracias!!