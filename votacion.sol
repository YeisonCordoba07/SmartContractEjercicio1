// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter{
    struct Propuesta{
        string nombre;
        uint votos;
    }

    address public administrador;

    address[] public listaDirecciones;
    Propuesta[] public listaPropuestas;


    constructor (address _direccion){
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        listaDirecciones.push(_direccion);
        crearPropuesta("(0) BLANCO");
        crearPropuesta("(1) Yeison");
        crearPropuesta("(2) Camila");
        crearPropuesta("(3) Laura");
        crearPropuesta("(4) Sara");
        crearPropuesta("(5) John G");

        administrador = 0x94d3595B283309b080F4d036BF9239D1fDC606F4;

        listaDirecciones.push(0x94d3595B283309b080F4d036BF9239D1fDC606F4);
        listaDirecciones.push(0x925BcAe7e1b70d235DF9B6927F0071169708dDf8);
        listaDirecciones.push(0x0255bF566828fB0ecd70C18dC4875021373fBED8);
        listaDirecciones.push(0x60BF6307f6C3261B2863373B0CbC8f2742Ef00f1);
        listaDirecciones.push(0xc3EFc68bf06655C7EfA1f0a4DBa8F14193752458);
        listaDirecciones.push(0x0b01Bb34cE3d64d737A2668eb934C93c420999b1);


    }




    function crearPropuesta(string memory nombrePropuesta) public {

        require(msg.sender == administrador, "Solo el administrador puede agregar propuestas");
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
        uint posicionDireccion = 0;
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



    function obtenerDirecciones() public view returns(address[] memory){
        return listaDirecciones;
    }
    
    function obtenerPropuestas() public view returns(Propuesta[] memory){
        return listaPropuestas;
    }

}