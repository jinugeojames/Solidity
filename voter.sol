pragma solidity ^0.4.13;

contract voting {
    struct Voter{
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    struct Proposol{
        bytes32 name;
        uint voteCount;
    }
    address public chairperson;
    mapping (address => Voter)public voters;
    Proposal[] public proposals;

    constructor (bytes32[] proposalNames) public{
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        for(int i = 0;i<proposalNames.length;i++){
            proposals.push(Proposal({
                name:proposalNames[i],
                voteCount:0
            }));
        }
        
    }
}
function giveRightToVote(address voter) public{
    require(msg.sender == chairperson,);
    require(!voters[voter].voted,);
    require(voters[voter].weight == 0);
    voters[voter].weight = 1;
}
function delegate(address to) public {
    Voter storage sender = voters[msg.sender];
    require(!sender.voted,);
    require(to != msg.sender,)
    while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender,);
    }

    sender.voted = true;
    sender.delegate = to;
    Voter storage delegate_ = voters[to];
        if(delegate_.voted){
            proposals[delegate_.vote].votedCount += sender.weight;
        }else{
            delegate_.weight += sender.weight;
        }
}
function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted,);
        sender.voted = true;
        sender.vote = proposal;