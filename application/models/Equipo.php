<?php

class Equipo extends CI_Model{
    public function CrearEquipo($nombre){
        $data = array(
            'nombre' => $nombre,
            'numPilotos' => 0,
            'numCopilotos' => 0
        );
        $this->db->insert('equipo', $data);
    }
    public function ModificarEquipo($nombre){
        $this->db->set('nombre',$nombre);
        $this->db->update('equipo');
    }
    public function AgregarAutomovil($nombre, $matricula){

    }
    public function EliminarAutomovil($nombre, $matricula){ //¿Se puede?

    }

    //¿Modificar/Eliminar competidor de un equipo/ cambiarlo de equipo?

    public function ObtenerCompetidoresEquipo(){} //3 join creo :D
    public function ObtenerPilotosEquipo(){}
    public function ObtenerCopilotosEquipo(){}
    public function ObtenerAutomoviles(){}
}