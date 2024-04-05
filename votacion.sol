// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter{
    struct Propuesta{
        string nombre;
        uint votos;
    }

    struct Votante{
        address direccionVotante;
        bool haVotado;
    }

    address public administrador;

    Propuesta[] public listaPropuestas;
    Votante[] public listaVotantes;


    constructor (){

        //listaDirecciones.push(msg.sender);
        administrador = msg.sender;
        crearPropuesta("(0) BLANCO");
        crearPropuesta("(1) Yeison");
        crearPropuesta("(2) Camila");
        crearPropuesta("(3) Laura");
        crearPropuesta("(4) Sara");
        crearPropuesta("(5) John G");

        //listaDirecciones.push(0x94d3595B283309b080F4d036BF9239D1fDC606F4);
        /*listaDirecciones.push(0x925BcAe7e1b70d235DF9B6927F0071169708dDf8);
        listaDirecciones.push(0x0255bF566828fB0ecd70C18dC4875021373fBED8);
        listaDirecciones.push(0x60BF6307f6C3261B2863373B0CbC8f2742Ef00f1);
        listaDirecciones.push(0xc3EFc68bf06655C7EfA1f0a4DBa8F14193752458);
        listaDirecciones.push(0x0b01Bb34cE3d64d737A2668eb934C93c420999b1);*/

        Votante memory nuevoVotante0 = Votante({
            direccionVotante: 0x94d3595B283309b080F4d036BF9239D1fDC606F4,
            haVotado: false
        });
        Votante memory nuevoVotante1 = Votante({
            direccionVotante: 0x925BcAe7e1b70d235DF9B6927F0071169708dDf8,
            haVotado: false
        });
        Votante memory nuevoVotante2 = Votante({
            direccionVotante: 0x0255bF566828fB0ecd70C18dC4875021373fBED8,
            haVotado: false
        });
        Votante memory nuevoVotante3 = Votante({
            direccionVotante: 0x60BF6307f6C3261B2863373B0CbC8f2742Ef00f1,
            haVotado: false
        });
        Votante memory nuevoVotante4 = Votante({
            direccionVotante: 0xc3EFc68bf06655C7EfA1f0a4DBa8F14193752458,
            haVotado: false
        });
        Votante memory nuevoVotante5 = Votante({
            direccionVotante: 0x0b01Bb34cE3d64d737A2668eb934C93c420999b1,
            haVotado: false
        });

        listaVotantes.push(nuevoVotante0);
        listaVotantes.push(nuevoVotante1);
        listaVotantes.push(nuevoVotante2);
        listaVotantes.push(nuevoVotante3);
        listaVotantes.push(nuevoVotante4);
        listaVotantes.push(nuevoVotante5);
    }




    function crearPropuesta(string memory nombrePropuesta) public {

        //require(msg.sender == listaVotantes[0].direccionVotante, "Solo el administrador puede agregar propuestas");
        if(msg.sender == administrador){
            Propuesta memory nuevaPropuesta = Propuesta({
                nombre: nombrePropuesta,
                votos: 0
            });
            listaPropuestas.push(nuevaPropuesta);
        }

    }


    event LogDireccion(string texto,address direccion);

    function imprimirDireccion() public {
        emit LogDireccion("direccion22", msg.sender);
    }



    function votar(uint256 posicionPropuesta) public {
        for(uint i = 0; i < listaVotantes.length; i++){
            if(msg.sender == listaVotantes[i].direccionVotante && listaVotantes[i].haVotado == false){
                listaPropuestas[posicionPropuesta].votos = listaPropuestas[posicionPropuesta].votos + 1;
                listaVotantes[i].haVotado = true;
                break;
            }
        }
    }



    function obtenerVotantes() public view returns(Votante[] memory){
        return listaVotantes;
    }
    
    function obtenerPropuestas() public view returns(Propuesta[] memory){
        return listaPropuestas;
    }

}