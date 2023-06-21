// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.9;
 
contract Luckydraw {
    address public manager;
    address payable[] public players;
    
    constructor() {
        manager = msg.sender;
    }
    // user can enter the luckydraw with minimum ether
    function enter() public payable {
        require(msg.value > .0009 ether);
        players.push(payable(msg.sender));
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
    
    // picking the winner and clear the initial players array
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address payable[](0);
    }
    // function modifier to restrict some action only to manager
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
} 