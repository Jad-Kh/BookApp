const data = require('../data/stores.json')

const deg2rad = (deg) => {
    return deg * (Math.PI/180)
}

exports.getStores = async(request, response) => {
    try {
        let stores = []
        data.map((entry) => {
            let LatdegS = entry.lat * 110.574
            let LngdegS = entry.lng * 111.320 * Math.cos(deg2rad(entry.lat))
            let LatdegD = request.params.lat * 110.574
            let LngdegD = request.params.lng * 111.320 * Math.cos(deg2rad(request.params.lat))
            let distance = Math.sqrt(Math.pow(LatdegD - LatdegS, 2) + Math.pow(LngdegD - LngdegS, 2))
            let store = {
                store: entry.store,
                lat: entry.lat,
                lng: entry.lng,
                name: entry.name,
                distance: distance,
            }
            stores.push(store)
        })
        stores.sort((s1, s2) => {
            return s1.distance - s2.distance;
        })
        return response.status(200).json(stores)
    } catch(error) {
        return response.status(500).json(error);
    }
}