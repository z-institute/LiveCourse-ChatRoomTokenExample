// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ChatRoomV2 {
    string public announcement;
    uint256 public announcementLastPaidVal;
    uint256 public announcementLastPaidValInMyToken;
    ERC20 public myToken;

    mapping(address => string[]) public userToMsgs;

    event newMessage(address user, string message);

    constructor (address myTokenAddr){
        myToken = ERC20(myTokenAddr);
    }

    function newMsg(string memory str) public {
        userToMsgs[msg.sender].push(str);
        emit newMessage(msg.sender, str);
    }
    function showLastestMsg(uint256 len, address user) public view returns (string[] memory) {
        require(len != 0 && user != address(0), "Input not valid");

        uint256 totalLen = userToMsgs[user].length;
        uint256 finalLen = totalLen > len ? len : totalLen;
        string[] memory retMsgs = new string[](finalLen); 
        if(finalLen == 0) return retMsgs;

        uint256 index = totalLen - 1;
        uint256 k = 0;
        while(index >= 0){
            retMsgs[k] = userToMsgs[user][index];
            if(index > 0) index--;
            k++;
            if(k == finalLen) break;
        }
        return retMsgs;
    }
    function newAnnouncement(string memory str) public payable {
        require(msg.value > announcementLastPaidVal, "Not enough fund");
        announcementLastPaidVal = msg.value;
        announcement = str;
    }
    function newAnnouncementMyToken(string memory str, uint256 amount) public {
        require(amount > announcementLastPaidValInMyToken, "Not enough fund");
        myToken.transferFrom(msg.sender, address(this), amount);
        announcementLastPaidValInMyToken = amount;
        announcement = str;
    }
}
