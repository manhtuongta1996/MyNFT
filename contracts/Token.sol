pragma solidity 0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC721, Ownable {
    struct Pet {
        uint8 damage; //0-256
        uint8 magic;
        uint256 lastMeal;
        uint256 endurance;

    }
    uint256 nextId = 0;
    mapping(uint256 => Pet) private _tokenDetail;
    constructor(string memory name, string memory symbol) ERC721(name, symbol){

    }

    function mint(uint8 damage, uint8 magic, uint8 endurance) public onlyOwner{
        _tokenDetail[nextId] =Pet(damage, magic, block.timestamp, endurance);
        _safeMint(msg.sender, nextId );
        nextId++;
    }
    function feed(uint256 tokenId) public {
        Pet storage pet = _tokenDetail[nextId];
        require(pet.lastMeal + pet.endurance > block.timestamp);
        _tokenDetail[nextId].lastMeal = block.timestamp;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        Pet storage pet = _tokenDetail[nextId];
        require(pet.lastMeal + pet.endurance > block.timestamp);

    }
}