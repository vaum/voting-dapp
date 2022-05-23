// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract Election {
    // Model of a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    event votedEvent (
        uint indexed _candidateId
    );

    // read/write candidates
    mapping(uint => Candidate) public candidates;
    // store accounts that voted
    mapping(address => bool) public voters;

    // Store candidates count
    uint public candidatesCount;

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "Voter voted before!");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Not a valid candidate!");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

    function getCandidateVotes(uint _candidateId) public returns(uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Not a valid candidate!");
        return candidates[_candidateId].voteCount;
    }

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
}