///door_close(x,y,length,time,sprite)
//x, y es la posición de la esquina superior izquierda donde empieza la puerta.
//length es la longitud de tiles 16x que tiene y time el tiempo que tarda en cerrarse cada tile (3 por default)
global.door_time = 1
global.door_sprite = argument4
for (i = 0; i < argument2; i++){
    instance_create(argument0 + 16 * i + 8, argument1 + 8, o_door)
    global.door_time += argument3
}//Fin for
