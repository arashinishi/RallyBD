<?php

class Competidor extends CI_Model{
    //Desde su creación se determina su equipo
    public function CrearPiloto($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){
        $sql = "INSERT INTO competidor VALUES ('{$rut}','{$nacionalidad}','{$nombres}','{$apPaterno}','{$apMaterno}','{$nombreEquipo}')";
        $this->db->query($sql);
        $this->db->query("INSERT INTO piloto VALUES ('{$rut}')");
        //Actualizar cantidad de pilotos del equipo
        
    }
    public function CrearCopiloto($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){
        $sql = "INSERT INTO competidor VALUES ('{$rut}','{$nacionalidad}','{$nombres}','{$apPaterno}','{$apMaterno}','{$nombreEquipo}')";
        $this->db->query($sql);
        $this->db->query("INSERT INTO copiloto VALUES ('{$rut}')");
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