// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to represent a poll
    struct Poll {
        uint256 id;
        string question;
        mapping(uint256 => uint256) votes; // Option ID => Vote count
        uint256[] optionIds;
    }

    // Array to store polls
    Poll[] public polls;

    // Event for new poll creation
    event PollCreated(uint256 id, string question);

    // Function to create a new poll
    function createPoll(string memory _question, uint256[] memory _optionIds) external {
        uint256 pollId = polls.length;
        polls.push(Poll(pollId, _question, _optionIds));
        emit PollCreated(pollId, _question);
    }

    // Function to vote on a poll
    function vote(uint256 _pollId, uint256 _optionId) external {
        require(_pollId < polls.length, "Poll does not exist");
        polls[_pollId].votes[_optionId]++;
    }

    // Function to get poll details
    function getPoll(uint256 _pollId)
        external
        view
        returns (
            string memory question,
            uint256[] memory optionIds,
            uint256[] memory voteCounts
        )
    {
        require(_pollId < polls.length, "Poll does not exist");
        Poll memory poll = polls[_pollId];
        question = poll.question;
        optionIds = poll.optionIds;
        voteCounts = new uint256[](poll.optionIds.length);
        for (uint256 i = 0; i < poll.optionIds.length; i++) {
            voteCounts[i] = poll.votes[poll.optionIds[i]];
        }
    }
}
