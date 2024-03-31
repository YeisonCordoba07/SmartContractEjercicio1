// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter{
    struct Propuesta{
        string nombre;
        uint votos;
    }

    address[] public listaDirecciones;
    Propuesta[] public listaPropuestas;


    constructor (address _direccion){
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        listaDirecciones.push(_direccion);
        crearPropuesta("1) Yeison");
        crearPropuesta("2) Camila");
        crearPropuesta("3) Laura");
        crearPropuesta("4) Sara");
        crearPropuesta("5) John G");
    }




    function crearPropuesta(string memory nombrePropuesta) public {

        require(listaDirecciones.length > 0 && msg.sender == listaDirecciones[0], "Solo la primera direccion puede agregar propuestas");
        Propuesta memory nuevaPropuesta = Propuesta({
            nombre: nombrePropuesta,
            votos: 0
        });
        listaPropuestas.push(nuevaPropuesta);
    }


    event LogDireccion(address direccion);

    function imprimirDireccion() public {
        emit LogDireccion(msg.sender);
    }



    function votar(uint256 posicionPropuesta) public {
        uint posicionDireccion;
        for(uint i = 0; i < listaDirecciones.length; i++){
            if(msg.sender == listaDirecciones[i]){
                listaPropuestas[posicionPropuesta].votos = listaPropuestas[posicionPropuesta].votos + 1;
                posicionDireccion = i;
            }
        }

        //Elimina la dirección de la lista de direcciones para que no pueda votar mas
        for(uint i = posicionDireccion; i < listaDirecciones.length - 1; i++){
            listaDirecciones[i] = listaDirecciones[i + 1];
        }
        listaDirecciones.pop();
    }




    function obtenerPropuestas() public view returns(Propuesta[] memory){
        return listaPropuestas;
    }

}