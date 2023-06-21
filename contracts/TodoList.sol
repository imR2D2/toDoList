//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract TodoList{
    struct Task{
        uint id;
        string content;
        bool completed;
    }

//Notificar cuando suceda a la blockchain
    event TaskCreated(
        uint id,
        string content,
        bool completed
    );
        
    event TaskCompleted(
        uint id,
        bool completed
    );

//Como queremos que cada billetera tenga su todolist debemos hacer lo siguiente
    mapping (address => mapping(uint => Task)) public tasks;
//Cantidad de tareas que tiene la billetera creadas
    mapping (address => uint) public tasksCount;

//Constructor para cuando se despliegue el contrato
    constructor(){
        createTask("Hello World!");
    }

    //Funcion de crear tareas
    function createTask (string memory _content) public{
        //Obtenemos el id de la tarea
        uint taskCount = tasksCount[msg.sender];
        //El estado de la tarea si recien se crea sera siempre falso
        tasks[msg.sender][taskCount] = Task(taskCount, _content, false);
        //Emitimos el evento
        emit TaskCreated(taskCount, _content, false);
        //Aumentamos el contador del tastCount para esta billetera
        tasksCount[msg.sender]++;
    }

    //Funcion para cambiar el estado de las tareas completadas
    function toggleCompleted(uint _id) public{
        Task memory task = tasks[msg.sender][_id];
        task.completed = !task.completed;
        tasks[msg.sender][_id] = task;
        emit TaskCompleted(_id, task.completed);
    }
}