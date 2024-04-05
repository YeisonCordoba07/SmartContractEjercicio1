// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Votacion{

    //Estructura para las propuestas
    struct Propuesta{
        string nombre;
        uint votos;
    }

    //Estructura para los votantes
    struct Votante{
        address direccionVotante;
        bool haVotado;
    }




    uint public tiempoTotal; //Tiempo disponible para votar
    address public administrador; //Direccion del creador del contrato
    Propuesta[] public listaPropuestas; //Lista de propuestas
    Votante[] public listaVotantes; // Lista de votantes permitidos




    constructor (){

        //Tiempo de votacion
        tiempoTotal = block.timestamp + 259200;

        //Guarda la direccion del creador del contrado
        administrador = msg.sender;

        //Agrega 5 propuestas mas 1 en blanco
        crearPropuesta("(0) BLANCO");
        crearPropuesta("(1) Yeison");
        crearPropuesta("(2) Camila");
        crearPropuesta("(3) Laura");
        crearPropuesta("(4) Sara");
        crearPropuesta("(5) John G");

        //listaDirecciones.push(0x94d3595B283309b080F4d036BF9239D1fDC606F4);

        //Agrega 6 direcciones que podrán votar
        Votante memory nuevoVotante0 = Votante({
            direccionVotante: msg.sender,
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

        //Agrega las direcciones de votantes a la lista de votantes
        listaVotantes.push(nuevoVotante0);
        listaVotantes.push(nuevoVotante1);
        listaVotantes.push(nuevoVotante2);
        listaVotantes.push(nuevoVotante3);
        listaVotantes.push(nuevoVotante4);
        listaVotantes.push(nuevoVotante5);
    }




    //Para confirmar que el tiempo no haya acabado
    modifier hayTiempo(){
        if(block.timestamp > tiempoTotal){
            revert("El tiempo de votacion ha acabado");
        }
        _;
    }




    //Agrega una nueva propuesta y verifica que solo lo pueda hacer el administrador
    function crearPropuesta(string memory nombrePropuesta) public hayTiempo {

        //require(msg.sender == listaVotantes[0].direccionVotante, "Solo el administrador puede agregar propuestas");
        if(msg.sender == administrador){
            Propuesta memory nuevaPropuesta = Propuesta({
                nombre: nombrePropuesta,
                votos: 0
            });
            listaPropuestas.push(nuevaPropuesta);
        }
    }




    //Agrega un voto a la propuesta que esté en la posición que se pasa como parametro
    function votar(uint256 posicionPropuesta) public hayTiempo {

        for(uint i = 0; i < listaVotantes.length; i++){
            
            //Verifica que la direccion que invoca el contrato esté en la lista de votantes
            // y que no haya votando antes
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