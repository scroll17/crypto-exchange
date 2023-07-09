// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Exchange {
    address public owner;

    address[] public userAddresses;
    mapping (address => bool) public hasVoted;
    mapping (address => uint256) public balances;

    event UserVoted (
        address indexed _user
    );

    event UserTransferedMoney(
        address indexed _user,
        uint amount
    );

    constructor() {
        owner = msg.sender;
    }

    function vote() public {
        hasVoted[msg.sender] = true;
        balances[msg.sender] += 100 wei;

        emit UserVoted(msg.sender);
    }

    function transer(address payable _to) public payable  {
        (bool sent, ) = _to.call{ value: msg.value }("");
        require(sent, "Operation failed");

        emit UserTransferedMoney(msg.sender, msg.value);
    } 

    function getBalance() public view returns(uint256) {
        return balances[msg.sender];
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getBlockInfo() public view returns(uint, uint, uint) {
        return (
            block.number,
            block.timestamp,
            block.chainid
        );
    }
}