import math

_earthRadiusMeters = 6371009

def Haversine(lngLat, lngLatOrigin, units = 'meters'):
    phi1 = math.radians(lngLat[1])
    phi2 = math.radians(lngLatOrigin[1])
    deltaPhi = math.radians(lngLatOrigin[1] - lngLat[1])
    deltaLambda = math.radians(lngLatOrigin[0] - lngLat[0])
    a = math.sin(deltaPhi / 2.0) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(deltaLambda / 2.0) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    meters = _earthRadiusMeters * c
    if units == 'kilometers':
        return meters / 1000
    return meters
