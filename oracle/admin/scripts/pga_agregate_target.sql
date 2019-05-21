/* El total de área de trabajo no puede ser superior a 200 megabytes de 
RAM debido a la configuración predeterminada de _pga_max_size. (200mb) (parametro oculto)*/

/* Ningún tipo de RAM puede utilizar más de un 5% de pga_aggregate_target o _pga_max_size, el que sea menor. 
Esto significa que la tarea no puede utilizar más de 200 megabytes (tamaño _pga_max_size) para ordenar o se suma hash. 
El algoritmo reduce aún más a este (200 / 2) */

/* Estas restricciones se hicieron para asegurar que ningún gran tipo arge sorts o hash joins se une a la zona RAM PGA*/
/* hay algunos secretos para optimizar la PGA*/
