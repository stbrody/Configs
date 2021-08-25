const IPFS = require('ipfs-core')
const {multibase} = require('ipfs-core');
const dagJose = require('dag-jose').default
const { convert } = require('blockcodec-to-ipld-format')
const CID =  require('cids')
const uint8arrays = require('uint8arrays')


const format = convert(dagJose)

const CIDS_TO_LOAD=['bafyreibabdsqffkpt6x4awle7b4gnfgzyxfemilpttfnwhteclvne5fywa','bagcqcerayeaha4eagvxgdwhfjosjb2lxjs2ztwpmkytqzqixv667mniz6v5a', 'bafyreiaiejmtsqua5sr3xqyrilf43edrgdolblbhkyqqzfq2sy6yp3tqhu','bagcqcera2jbcbzonk5kvd27xaosvls5f2ibs6xej52hbdtjauhrkmnf4smva','bafyreie3qavxvfwsu26itarf2s2my6khmw72bwrba43kdeusprqss4bzx4'].map((cid) => new CID(cid))

function toKey(cid) {
    return '/' + uint8arrays.toString(multibase.encode('base32', cid.multihash)).slice(1).toUpperCase()
}

async function main() {
    const node = await IPFS.create({
        ipld: { formats: [format] },
        preload: {
            enabled: false
        },
        config: {
            Bootstrap: [],
        },
    })
    const mainnet = [
        "/dns4/ipfs-ceramic-public-mainnet-external.ceramic.network/tcp/4012/wss/p2p/QmS2hvoNEfQTwqJC4v6xTvK8FpNR2s6AgDVsTL3unK11Ng",
        "/dns4/ipfs-ceramic-private-mainnet-external.3boxlabs.com/tcp/4012/wss/p2p/QmXALVsXZwPWTUbsT8G6VVzzgTJaAWRUD7FWL5f7d5ubAL",
        "/dns4/ipfs-cas-mainnet-external.3boxlabs.com/tcp/4012/wss/p2p/QmUvEKXuorR7YksrVgA7yKGbfjWHuCRisw2cH9iqRVM9P8",
        "/dns4/ipfs-ceramic-elp-1-1-external.3boxlabs.com/tcp/4012/wss/p2p/QmUiF8Au7wjhAF9BYYMNQRW5KhY7o8fq4RUozzkWvHXQrZ",
        "/dns4/ipfs-ceramic-elp-1-2-external.3boxlabs.com/tcp/4012/wss/p2p/QmRNw9ZimjSwujzS3euqSYxDW9EHDU5LB3NbLQ5vJ13hwJ"
    ]
    const testnet = [
        "/dns4/ipfs-ceramic-public-clay-external.3boxlabs.com/tcp/4012/wss/p2p/QmWiY3CbNawZjWnHXx3p3DXsg21pZYTj4CRY1iwMkhP8r3",
        "/dns4/ipfs-ceramic-public-clay-external.ceramic.network/tcp/4012/wss/p2p/QmSqeKpCYW89XrHHxtEQEWXmznp6o336jzwvdodbrGeLTk",
        "/dns4/ipfs-ceramic-private-clay-external.3boxlabs.com/tcp/4012/wss/p2p/QmQotCKxiMWt935TyCBFTN23jaivxwrZ3uD58wNxeg5npi",
        "/dns4/ipfs-cas-clay-external.3boxlabs.com/tcp/4012/wss/p2p/QmbeBTzSccH8xYottaYeyVX8QsKyox1ExfRx7T1iBqRyCd",
        "/dns4/ipfs-clay-1.ceramic.geoweb.network/tcp/4012/ws/p2p/QmbDGaByZoomn3NQQjZzwaPWH6ei3ptzWK7a7ECtS35DKL"
    ]
    await Promise.all(testnet.map(async peer => {
        await node.swarm.connect(peer)
    }))
    console.log('peers', await node.swarm.peers())

    console.log('------ 0.start ------')
        const IPFS_GET_TIMEOUT = 30000 // -1 minute- 30 seconds
        for (const cid of CIDS_TO_LOAD) {
            console.log('cid', cid)
            const key = toKey(cid)
            console.log('key', key)
            console.log('folder', key.slice(key.length -3, key.length -1))
            try {
                const record = await node.dag.get(cid, {timeout: IPFS_GET_TIMEOUT})
                if (record) {
                    console.log(`cid ${cid} found!!!`)
                    console.log(record.value)
                } else {
                    console.warn(`cid ${cid} not-found!!!!!`)
                }
            } catch (e) {
                console.log(`Error fetching cid ${cid}!!!`)
                console.error(e)
            }
        }
        process.exit(0)
}

main()
