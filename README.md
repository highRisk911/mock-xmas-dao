# Solidity starting guide for beginners


Starter kit for learning Solidity:
1. [Node JS with Chocolatey](https://nodejs.org/)
2. IDE with Solidity plugin(in my case i use Intelij Idea)
3. **Solidity compiler**

	`npm install solc` 

4. **Truffle** - tool for testing and deploying your contracts to blockchain

	`npm install -g truffle`

5. **[Ganache](https://trufflesuite.com/ganache/)** - local blockchain for testing
6. Truffle plugins for testing & deploying:

	6.1 **HD Wallet**-enabled Web3 provider. Use it to sign transactions for addresses derived from a 12 or 24 
	word 		             mnemonic. It's a built-in eth wallet into testing environment.
	
	`npm install @truffle/hdwallet-provider` 
	
	6.2 **Open Zeppelin** - it's a framework which help you with creating tokens.
	
	`npm install @openzeppelin`
			
	6.3 **Truffle-assertions** - very important tool for testing contracts
	
	`npm install truffle-assertions`
			
	6.4 **Chai** - libary for more smart using assertion.
	
	`npm install chai`
			
	6.5 **JS Big Decimal libary** - in Solidity very often used uint256, and for supporting 32 byte value in JS - you 
				need BN libary.
				
	`npm install js-big-decimal`
				
	6.6 After deploying to blockchain you need to verify contract, with this can help **Truffle verify plugin**,
	
	and do this without flattening. 
		  
	`npm install -D truffle-plugin-verify`  
	6.7 Truffle-upgradable
	This package adds functions to your Truffle migrations and tests so you can deploy and upgrade proxies for your contracts
	
	`npm install --save-dev @openzeppelin/truffle-upgrades`

**[Solidity docs](https://docs.soliditylang.org/en/v0.8.11/)** - all what you need for Solidity developing

**[Open Zeppelin docs](https://docs.openzeppelin.com/contracts/4.x/)** - guides how to create your own tokens with OZ-framework. 

# ERC-20

## Santa
Santa inherit ERC-20
Contract: [0xC31d1eb415f7D10fD089Fa90761e172C5c45271C](https://rinkeby.etherscan.io/address/0xC31d1eb415f7D10fD089Fa90761e172C5c45271C#code)

## RSnowball
RSnowball implement interface IERC20
Contract: [0x104ccdB477D0A0c4B051161462C1d1CE2F689014](https://rinkeby.etherscan.io/address/0x104ccdB477D0A0c4B051161462C1d1CE2F689014#code)
# ERC-721
## TestNFT 
TestNFT inherit ERC721 by inheriting ERC721URIStorage
Contract: [0x16D2243b6f82A5cFE3cD7889f0361DbA3eE28e7c](https://rinkeby.etherscan.io/address/0x16D2243b6f82A5cFE3cD7889f0361DbA3eE28e7c#code)
# ERC-1155

## LGA
LGA inherit ERC1155
Contract: [0x2eF225fB768c0fa412fC7e6C1715B4AdA5aB6CE3](https://rinkeby.etherscan.io/address/0x2eF225fB768c0fa412fC7e6C1715B4AdA5aB6CE3#code)


# Upgradeable
##PirateProxy

Contract: [0x198EdB9fEFB93756Fe3bAd5e4249ACFA7f0f7B61](https://rinkeby.etherscan.io/address/0x198EdB9fEFB93756Fe3bAd5e4249ACFA7f0f7B61#code)

##PirateAdmin

Contract: [0xd2443e1f956c52882733e8c73CD942a8DA3a0ABf](https://rinkeby.etherscan.io/address/0xd2443e1f956c52882733e8c73CD942a8DA3a0ABf#code)

###Implementations

Pirate V1

Contract: [0x5C2fe6B25ac11042817209A8785642822aD9ff91](https://rinkeby.etherscan.io/address/0x5C2fe6B25ac11042817209A8785642822aD9ff91#code)

Pirate V2 AccessControl

Contract: [0x9031D06113F88952dA1e591f8a89359a93c1a827](https://rinkeby.etherscan.io/address/0x9031D06113F88952dA1e591f8a89359a93c1a827#code)

Pirate V3 Pausable

Contract: [0xA73DA2aE776D1451e949f70C0a61C4efd335A279](https://rinkeby.etherscan.io/address/0xA73DA2aE776D1451e949f70C0a61C4efd335A279#code)
