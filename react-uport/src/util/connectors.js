import { Connect, SimpleSigner } from 'uport-connect'

// export let uport = new Connect('TruffleBox')


// Most important part, bringing over your credentials
// This allows you to sign transactions from DAPP to your smartphone
// Confirm txn and send back to browser application
// This connects the react uport trufflebox with the uport decentralised identity platform

// Good for demonstration purposes but you should not do this in a production website
// Others can take your simple signer key and pretend to be you
export const uport = new Connect('Simon\'s test app', {
      clientId: '2ozSmvfoYS7pmLYybx2pLndSBkdS1Mz3G6h',
      network: 'rinkeby',
      signer: SimpleSigner('a8c4438ee89cbcdf654c72e86e341917106972f73400e44a734a831a54306ac7')
    })

export const web3 = uport.getWeb3()