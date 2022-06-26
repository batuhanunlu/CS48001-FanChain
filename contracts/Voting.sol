pragma solidity >=0.4.22 <=0.8.12;

contract Voting {
    function add_racer(string memory racer_name) private {
        // adding racers by using a function named add_racer which takes
        // a parameter of the name of the racer
        racers_count += 1;
        // when a racer is added, increment the count of the racers in order to
        // define their indexes.
        // as can be seen in the line of code, Racer struct takes racers count as the index of the racer
        // racer name in order to display it in the front-end screen and 0 stands for the votes that
        // the racer has collected. At the very beginning, of course racer takes 0 as the vote count.
        // with the voting_process_of_racer function very below, we increment his/her score.
        racers[racers_count] = Racer(racers_count, racer_name, 0);
    }
    constructor() public {
        // adding the racers who race in F1 staticaly to the contract with the help of the constructor
        // Constructor reference: https://www.tutorialspoint.com/solidity/solidity_constructors.htm
        // uint d;
        // constructor(uint _d) public {
        //  data = _d;} 
        // in our case we do not have a specific parameter for constructor so we directly initiliaze the functions
        add_racer("Max Verstappen");
        add_racer("Sergio Perez");
        add_racer("Charles Leclerc");
        add_racer("Carlos Sainz");
        add_racer("Lewis Hamilton");
        add_racer("Pierre Gasly");
        add_racer("Yuki Tsunoda");
        add_racer("Esteban Ocon");
        add_racer("Fernando Alonso");
        add_racer("Lando Norris");
        add_racer("Daniel Ricciardo");
        add_racer("Mick Schumacher");
        add_racer("Kevin Magnussen");
        add_racer("Alex Albon");
        add_racer("Nicholas Latifi");
        add_racer("Sebastian Vettel");
        add_racer("Lance Stroll");
        add_racer("Valtteri Bottas");
        add_racer("Zhou Guanyu");
    }
    struct Racer {
        // Data types reference
        // https://blog.logrocket.com/ultimate-guide-data-types-solidity/
        // uint takes up to 32B by default
        // with 256 we increase this limit and actually this is a convention, a way something is done
        // according to the samples and tutorials that we saw.
        uint256 racer_number;
        string racer_name;
        uint256 racer_vote_count;
    }
    function voting_process_of_racer(uint256 racer_number) public {
        // for error handling, we used require.
        // Reference for require: https://www.bitdegree.org/learn/solidity-require
        // https://www.udemy.com/course/ethereum-and-solidity-the-complete-developers-guide/
        require(!fans[msg.sender]);
        require(racer_number<=racers_count && racer_number>0);
        fans[msg.sender] = true;
        // msg sender is the person who is connecting at the time with the contract
        // from the array that is created with mapping called racers, find the related racer from its index
        // and increase its voting count by 1.
        racers[racer_number].voteCount += 1;
        // just emit the event
        // Event reference: https://docs.soliditylang.org/en/v0.4.24/contracts.html#events
        emit voted_the_racer(racer_number);
    }
    // Mapping is a reference type as arrays and structs. Following is the syntax to declare a mapping type.
    // Reference: https://www.tutorialspoint.com/solidity/solidity_mappings.htm
    mapping(uint256 => Racer) public racers;
    mapping(address => bool) public fans;
    event voted_the_racer(uint256 indexed racer_number);
    uint256 public racers_count;
}
