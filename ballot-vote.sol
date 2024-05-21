// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

    struct Proposal{
        string name;
        uint voteCount;
    }

    struct Voter{
        uint vote;
        bool voted;
        uint weight;
    }

    Proposal[] public proposals;
    mapping(address => Voter) public voters; //voters get address as a key and Voter as a value
    address public chairperson; //This person can authenticate and deploy contracts

    // Constructor
    constructor(string[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // Adding the proposal names to the smart contract before deployment
        for(uint i=0; i < proposalNames.length ; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Function to give right to vote
    function authenticateVoter(address voter) public {
        require(msg.sender == chairperson, "Only the Chairperson can give access to vote");
        require(!voters[voter].voted, "The voter has already voted");
        require(voters[voter].weight == 0);

        voters[voter].weight = 1;
    }

    // Function for voting
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

   // Function to determine winning proposals
    function winningProposals() public view returns (uint[] memory) {
        uint winningVoteCount = 0;
        uint count = 0;
        
        // Find the highest vote count
        for(uint i; i < proposals.length; i++){
            if(proposals[i].voteCount > winningVoteCount){
                winningVoteCount = proposals[i].voteCount;
            }
        }
        
        // Count the number of proposals with the highest vote count
        for(uint i; i < proposals.length; i++){
            if(proposals[i].voteCount == winningVoteCount){
                count++;
            }
        }
        
        // Create an array to store the indices of winning proposals
        uint[] memory winningPropIndices = new uint[](count);
        uint index = 0;
        
        // Store the indices of winning proposals
        for(uint i = 0; i < proposals.length; i++){
            if(proposals[i].voteCount == winningVoteCount){
                winningPropIndices[index] = i;
                index++;
            }
        }
        
        return winningPropIndices;
    }

    // Function to get the names of the winning proposals
    function getWinningNames() public view returns (string[] memory) {
        uint[] memory winningIndices = winningProposals();
        string[] memory winningNames = new string[](winningIndices.length);
        
        for(uint i = 0; i < winningIndices.length; i++) {
            winningNames[i] = proposals[winningIndices[i]].name;
        }
        
        return winningNames;
    }

}
