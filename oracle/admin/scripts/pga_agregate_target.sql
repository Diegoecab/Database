/* El total de �rea de trabajo no puede ser superior a 200 megabytes de 
RAM debido a la configuraci�n predeterminada de _pga_max_size. (200mb) (parametro oculto)*/

/* Ning�n tipo de RAM puede utilizar m�s de un 5% de pga_aggregate_target o _pga_max_size, el que sea menor. 
Esto significa que la tarea no puede utilizar m�s de 200 megabytes (tama�o _pga_max_size) para ordenar o se suma hash. 
El algoritmo reduce a�n m�s a este (200 / 2) */

/* Estas restricciones se hicieron para asegurar que ning�n gran tipo arge sorts o hash joins se une a la zona RAM PGA*/
/* hay algunos secretos para optimizar la PGA*/
