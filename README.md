# LiveCourse-ChatRoomTokenExample
This is an example in the course :D
Link: https://courses.zinstitute.net/courses/web3frontend

## Steps
1. Deploy `MyToken` contract.
2. Deploy `ChatRoomV2` contract with `MyToken` contract address as the constructor parameter.
3. Mint free tokens from `MyToken` contract.
4. Approve `ChatRoomV2` contract to spend my `MyToken` tokens.
5. Execute `newAnnouncementMyToken()` to set an announcement with `MyToken` tokens as the payment.
6. Check the `announcement` variable to see if the announcement is successful.
