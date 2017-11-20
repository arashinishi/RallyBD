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
        $data = array(
            'rut' => $rut,
            'nacionalidad' => $nacionalidad,
            'nombres' => $nombres,
            'apPaterno' => $apPaterno,
            'apMaterno' => $apMaterno,
            'nombreEquipo' => $nombreEquipo
        );
        $this->db->insert('competidor', $data);
        $this->db->insert('copiloto', array('rutCompetidor' => $rut));
        //Actualizar cantidad de copilotos del equipo

    }
    public function ModificarCompetidor($rut, $nacionalidad, $nombres, $apPaterno, $apMaterno, $nombreEquipo){
        $data = array(
            'nacionalidad' => $nacionalidad,
            'nombres' => $nombres,
            'apPaterno' => $apPaterno,
            'apMaterno' => $apMaterno,
            'nombreEquipo' => $nombreEquipo
        );
        $this->db->where('rut', $rut);
        $this->db->update('competidor', $data);
    }

    public function ObtenerCompetidores(){
        $query = $this->db->get('competidor');
        return $query->result_array();
    }
    public function ObtenerPilotos(){
        $this->db->select('rut', 'nacionalidad', 'nombres', 'apPaterno', 'apMaterno', 'nombreEquipo');
        $this->db->from('competidor');
        $this->db->join('piloto', 'piloto.rutCompetidor = competidor.rut', 'inner');
        $query = $this->db->get();
        return $query->result_array();
    }
    public function ObtenerCopilotos(){
        $this->db->select('rut', 'nacionalidad', 'nombres', 'apPaterno', 'apMaterno', 'nombreEquipo');
        $this->db->from('competidor');
        $this->db->join('copiloto', 'copiloto.rutCompetidor = competidor.rut', 'inner');
        $query = $this->db->get();
        return $query->result_array();
    }
}