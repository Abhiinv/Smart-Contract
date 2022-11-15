# Smart-Contract

## Struct - Item

Struct `Item` defines a product that is available for sale on the website. The attributes of an `item` object are: 
- itemId: Item ID of the product
- desc: Description of the item
- price: Selling price of the item
- seller: Seller ID of the seller of the item
- buyer: Buyer ID of the buyer
- isOffloaded: Flag to mark if the item is offloaded
- isDelivered: Flag to mark if the item is delivered

![struct-item-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/struct-item.jpg)

## Global Variables

### items

`items` is a list of the type `Item`, which contains all the products that are available on the webiste for sale.

### cnt

`cnt` is a global variable which keeps the count of the number of products on the website.

![var-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/var.jpg)

## Functions

### addItem

This function is called by the seller when a new item has to be added to the pool of available items on the website. The parameters to be passed to the function are `desc` and `price`. The conditions are that `price` should be more than 0, and only the seller is allowed to add items on the website. Upon execution of the function, a new `Item` object is created and the attributes are set. The global variable `cnt` is incremented, and the object is added to the list `items` of all the available items.

![function-addItem-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/function-addItem.jpg)

### buyItem

This function is called by a buyer who wishes to buy a certain item. The parameter passed is the `itemId` of the item to be bought. The conditions are that the seller can't be the buyer of the item, and the amount to be paid should be equal to the price of the item. Upon execution of the function, `isOffloaded` and `isDelivered` are set to false, and the `buyer` attribute of the item is set equal to the ID of the buyer.

![function-buyItem-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/function-buyItem.jpg)

### offLoad

This function is called by the seller when the offloading process has to be started. The condition is that `isOffloaded` should not be already `true`, as it would mean that item is already being offloaded. Upon execution of the function, `isOffloaded` is set to `true`.

![function-offload-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/function-offLoad.jpg)

### delivery

This function is called by the buyer once the delivery is completed. The condition is that `isOffloaded` should be `true`, i.e., the product should have been offloaded earlier, and `isDelivered` should be `false` meaning that the product has not yet been delivered. Upon execution of the function, `isDelivered` is set to `true`, and the amount equal to the price of the item is transferred to the seller.

![function-delivery-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/function-delivery.jpg)

### nonDelivered

This function is called by the buyer if the product is not delivered by the seller, after it has been offloaded. The conditions are that `isOffloaded` should be `ture` and `isDelivered` should be `false`. Upon execution of the function, the the amount equal to the price of the item is refunded to the buyer.

![function-nonDelivered-image](https://github.com/Abhiinv/Smart-Contract/blob/main/screenshots/function-nonDelivered.jpg)
