from common import math_polygon as _math_polygon

def test_Haversine(accuracyRatio = 0.1):
    meters = _math_polygon.Haversine([-0.116773, 51.510357], [-77.009003, 38.889931])
    assert abs((meters - 5897658.3) / meters) < accuracyRatio

    km = _math_polygon.Haversine([-0.116773, 51.510357], [-77.009003, 38.889931], units = 'kilometers')
    assert abs((km - 5897) / km) < accuracyRatio
