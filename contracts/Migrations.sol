pragma solidity >=0.4.22 <=0.8.12;

contract Migrations {
    // https://docs.soliditylang.org/en/latest/contracts.html#creating-contracts
    uint256 public last_completed_migration;
    address public owner_of_the_contract = msg.sender;
    modifier restricted() { require(msg.sender == owner_of_the_contract, "The contract owner cannot make anything right now"); _;}
    function set_completed(uint256 ok) public restricted { last_completed_migration = ok; }
}