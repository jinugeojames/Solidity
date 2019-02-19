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
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
}