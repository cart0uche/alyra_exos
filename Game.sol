// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";


contract Game is Ownable {

    string private word;
    string public indice;

    mapping (address => bool) players;
    address public winner;

    function initGame(string calldata _word, string calldata _indice) external onlyOwner {
        word = _word;
        indice = _indice;
    }   

    function guess(string calldata _word) external returns(bool) {
        require(!players[msg.sender], "already played");
        players[msg.sender] = true;

        if (keccak256(abi.encodePacked(_word)) == keccak256(abi.encodePacked(word))){
            winner = msg.sender;
            return true;
        }
        else{
            return false;
        }
    }
}
