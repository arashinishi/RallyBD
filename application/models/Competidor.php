<?php

class Competidor extends CI_Model{
    //Desde su creación se determina su equipo
    public function CrearPiloto($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){

        $data = array(
            'rut' => $rut,
            'nacionalidad' => $nacionalidad,
            'nombres' => $nombres,
            'apPaterno' => $apPaterno,
            'apMaterno' => $apMaterno,
            'nombreEquipo' => $nombreEquipo
        );
        $this->db->insert('competidor', $data);
        $this->db->insert('piloto', array('rutCompetidor' => $rut));
        //Actualizar cantidad de pilotos del equipo

    }
    public function CrearCopiloto($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){
        /*$query = $this->db->query('INSERT INTO competidor VALUES ('.$rut.','.$nacionalidad.','.$nombres.','.$apPaterno.','')');
        $data = array(
            'rut' => $rut,
            'nacionalidad' => $nacionalidad,
            'nombres' => $nombres,
            'apPaterno' => $apPaterno,
            'apMaterno' => $apMaterno,
            'nombreEquipo' => $nombreEquipo
        );
        $this->db->insert('competidor', $data);
        $this->db->insert('copiloto', array('rutCompetidor' => $rut));*/
        //Actualizar cantidad de copilotos del equipo

    }
    public function ModificarCompetidor($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){
        $sql = 'UPDATE competidor SET nacionalidad ='.$nacionalidad.', nombres ='.$nombres.', apPaterno ='.$apPaterno.', apMaterno ='.$apMaterno.', nombreEquipo ='.$nombreEquipo.' WHERE rut ='.$rut;
        $this->db->query($sql);
    }

    public function ObtenerCompetidores(){
        $query = $this->db->query('SELECT * FROM competidor;');
        return $query->result_array();
    }
    public function ObtenerPilotos(){
        $query = $this->db->query('SELECT rut, nacionalidad, nombres, apPaterno, apMaterno, nombreEquipo FROM competidor INNER JOIN piloto ON rut = rutCompetidor;');
        return $query->result_array();
    }
    public function ObtenerCopilotos(){
        $query = $this->db->query('SELECT rut, nacionalidad, nombres, apPaterno, apMaterno, nombreEquipo FROM competidor INNER JOIN copiloto ON rut = rutCompetidor;');
        return $query->result_array();
    }
}