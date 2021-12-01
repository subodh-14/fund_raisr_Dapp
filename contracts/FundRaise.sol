// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundRaise {
    uint public eventId = 0;
    mapping(uint => FundRaiseEvent) public fundRaises;

    struct FundRaiseEvent{
        string title;
        string description;
        uint goal;
        uint current;
        uint id;
        bool status;
        address creator;
    }

    struct HomeCard{
        string title;
        uint id;
    }

    event EventCreated(uint id);
    event Donated(uint amount);
    event Withdraw(uint id);

    function createEvent(string memory title , string memory description, uint goal ) public {
        uint idForNewEvent = eventId;
        address eventCreator = msg.sender;
        FundRaiseEvent memory newFundRaise = FundRaiseEvent(title,description,goal,0,idForNewEvent,true,eventCreator);

        fundRaises[idForNewEvent] = newFundRaise;

        eventId +=1;

        emit EventCreated(idForNewEvent);
    }

    function donate(uint idForEvent) public payable {
        FundRaiseEvent storage fundRaise = fundRaises[idForEvent];
        uint amount = msg.value;

        fundRaise.current = fundRaise.current + amount;

        emit Donated(amount);
    }

    function withdraw(uint idForEvent) public {
        address payable accountWithdrawing = payable(msg.sender);
        FundRaiseEvent storage fundRaise = fundRaises[idForEvent];

        require(accountWithdrawing == fundRaise.creator);

        accountWithdrawing.transfer(fundRaise.current);

        fundRaise.status = false;

        emit Withdraw(idForEvent);
    }

    function getHomeData() public view returns (HomeCard[] memory){
        HomeCard[] memory cards = new HomeCard[](eventId);

        for(uint i = 0;i<eventId;i++){
            HomeCard memory homeCard = HomeCard(fundRaises[i].title,i);
            cards[i] = homeCard;
        }

        return cards;
    }

}