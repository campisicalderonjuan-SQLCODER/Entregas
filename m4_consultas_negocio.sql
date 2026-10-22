-- consulta 1 | Resumen ejecutivo mensual
select MONTH(fecha_venta) as mes_venta, 
sum((cantidad * precio_unitario)) as total_facturado , sum(cantidad) as cantidad_pedidos, avg((cantidad * precio_unitario)) as ticket_promedio
from ventas
group by MONTH(fecha_venta)

--consulta 2 | Ranking de productos
select top 5 sum(cantidad * precio_unitario) as total_facturado, id_producto, sum(cantidad) as unidades_vendidas
from ventas
group by id_producto
order by total_facturado desc

--consultas 3 | Clientes recurrentes
select id_cliente, count(*) as cantidad_pedidos,sum((cantidad * precio_unitario))  as total_gastado
from ventas
group by id_cliente
having count(*) > 1

-- consulta 4 | Meses por encima/por debajo del promedio
select MONTH(fecha_venta) as mes_venta, 
sum(cantidad * precio_unitario) as total_facturado , case when sum(cantidad * precio_unitario)  > avg((cantidad * precio_unitario)) then 'POR ENCIMA'
 when sum(cantidad * precio_unitario)  < avg((cantidad * precio_unitario)) then 'POR DEBAJO'
 else 'IGUAL'
 end as relacion_promedio
from ventas
group by MONTH(fecha_venta)

-- Insights
--#1 - el producto con id nro 2 fue el producto mas vendido 
--#2 - el ticket promedio representa al 10% de las ventas realizas en el mes 3
--#3 - las compras realizadas por los clientes nro 1 y 5 representan a mas del 73% del total facturado en el mes 