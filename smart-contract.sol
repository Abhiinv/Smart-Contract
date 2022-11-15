// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract myContract{
    struct Item{
        uint itemId;
        string desc;
        uint price;
        address payable seller;
        address payable buyer;
        bool isDelivered;
        bool isOffloaded;
    }
    
    Item[] public items;

    uint cnt = 0;

    function addItem(string memory desc, uint price) public {

        require(price>0, "Price must be more than 0.");
        require(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "Item not added by website.");

        Item memory currItems;
        currItems.itemId = cnt;
        currItems.desc = desc;
        currItems.price = price * (10**18);
        currItems.seller = payable(msg.sender);
        cnt++;
        
        items.push(currItems);
    }

    function buyItem(uint itemId) payable public {
     
        require(items[itemId].seller != msg.sender, "Seller can't be the buyer of the item.");
        require(items[itemId].price == msg.value, "Price and amount paid not matching.");

        items[itemId].isOffloaded = false;
        items[itemId].isDelivered = false;
        items[itemId].buyer = payable(msg.sender);
    }

    function offLoad(uint itemId) public {
        require(items[itemId].buyer != 0x0000000000000000000000000000000000000000,"No one has bought the item yet");
        require(items[itemId].seller == msg.sender, "Offloading not carried out.");
        require(items[itemId].isOffloaded == false, "Item being offloaded more than once.");

        items[itemId].isOffloaded = true;
    }

    function delivery(uint itemId) payable public {
        require(items[itemId].buyer == msg.sender,"Seller cannot confirm delivery");
        require(items[itemId].isOffloaded == true, "Item being delivered before getting offloaded.");
        require(items[itemId].isDelivered == false, "Item being delivered more than once.");

        items[itemId].isDelivered = true;
        items[itemId].seller.transfer(items[itemId].price);
    }

    function nonDelivered(uint itemId) payable public {
        
        require(items[itemId].isOffloaded == true, "Item not yet offloaded.");
        require(items[itemId].isDelivered == false, "Item already delivered, amount can't be refunded.");
        require(items[itemId].buyer == msg.sender, "Amount getting refunded to different user.");
        
        items[itemId].buyer.transfer(items[itemId].price);
    }
}
