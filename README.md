# Token Blender for steward tokens and Toucan NCT

[@EthicHub](https://t.me/ethichub) is one of the very first ReFi and even DeFi protocols, helping smallholder farmers in developing economies since 2018: as of today, coffee producers in 6 countries of Latin America.

We started as a lending/collateral project, but in order to reach them in a sustainable way we have to develop a more holistic approach. Accordingly, we are also helping them sell their crops and are now working on a solution for carbon credits.

The problem is that it's almost impossible to measure the carbon, as the value of these carbon credits is much smaller than the measurement cost.

As an alternative, we are blending Toucan's already certified and tokenized carbon credits with our farmers' steward tokens, to produce a premium carbon token. Whatever premium we get in the selling process is additional income for our farmers.

We intend to integrate Celo SocialConnect or Account Abstraction, Polygon ID, Ethereum Attestation Service, and maybe other tools.

This contract's purpose is to simplify the carbon offsetting process.

What it does in more exact terms is abstract the process of retiring TCO2, which normally looks like so:

- user exchanges USDC for BCT/NCT tokens at one of the DEXs (Uniswap, Sushiswap, etc. depending on the network)
- user interacts with the BCT/NCT token contract to redeem the tokens for TCO2
- user interacts with the TCO2 token contract to retire the TCO2

With the OffsetHelper contract, the user can do all this in a single transaction.

## Deployments

For current deployments, see the `./deployments` folder.
