(async () => {
    console.log("abc")
    let accounts =  await web3.eth.getAccounts();
    console.log(accounts, accounts.length);
    let balance = await web3.eth.getBalance(accounts[0]);
    console.log("balance in Wei is: ", balance)
    let balanceInEth = await web3.utils.fromWei(balance, "ether");
    // console.log(balanceInEth)
    console.log("balance in ETH is: ", balanceInEth)

})()