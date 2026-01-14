(async () => {
    const address = "0x7b96aF9Bd211cBf6BA5b0dd53aa61Dc5806b6AcE"
    const abyArray = [
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    const contractInstance = new web3.eth.Contract(abyArray, address);

    console.log(await contractInstance.methods.myUint().call());

    let accounts = await web3.eth.getAccounts();
    let txResult = await contractInstance.methods.setMyUint(345).send({from: accounts[0]});

    console.log(await contractInstance.methods.myUint().call());
    console.log(txResult);

})()