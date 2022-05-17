const data = require('../data/stores.json')

exports.getStores = async(request, response) => {
    try {
        let stores = []
        data.map((entry) => {
            let distance = Math.sqrt(Math.pow(request.params.lat - entry.lat, 2) + Math.pow(request.params.lng - entry.lng, 2))
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
            return s2.distance - s1.distance;
        })
        return response.status(200).json(stores)
    } catch(error) {
        return response.status(500).json(error);
    }
}