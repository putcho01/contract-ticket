//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Ticket {
    uint256 ticketPrice = 0.01 ether;
    address owner;
    mapping (address => uint256) public ticketHolders;

    constructor() {
        owner = msg.sender;
    }

    function buyTicket(address _user, uint256 _amount) public payable {
        require(msg.value >= ticketPrice * _amount, "Value is large");
        addTicket(_user, _amount);
    }

    function useTicket(address _user, uint256 _amount) public {
        subTicket(_user, _amount);
    }

    function addTicket(address _user, uint256 _amount) internal {
        ticketHolders[_user] += _amount;
    }

    function subTicket(address _user, uint256 _amount) internal {
        require(ticketHolders[_user] >= _amount, "You don't have enouth tickets.");
        ticketHolders[_user] -= _amount;
    }

    function withdraw() public {
        require(msg.sender == owner, "You are not the owner.");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success);
    }
}
