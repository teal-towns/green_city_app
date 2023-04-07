import re

import mongo_db
from common import math_polygon as _math_polygon

# def GetById(id):
#     ret = { 'valid': 1, 'msg': '', 'lendLibraryItem': {} }
#     query = { '_id': mongo_db.to_object_id(id) }
#     ret['lendLibraryItem'] = mongo_db.find_one('lendLibraryItem', query)['item']
#     return ret

def Get(title = '', tags = [], userIdOwner = '', limit = 25, skip = 0, sortKey = '',
    withOwnerInfo = 1, lngLatOrigin = None):
    ret = { 'valid': 1, 'msg': '', 'lendLibraryItems': [] }
    query = {}
    if len(tags) > 0:
        query['tags'] = { '$in': tags }
    if len(title) > 0:
        query['title'] = { '$regex': title, '$options': 'i' };
    if len(userIdOwner) > 0:
        query['userIdOwner'] = userIdOwner
    sort = None
    if len(sortKey) > 0:
        sortVal = 1
        if sortKey[0] == '-':
            sortVal = -1
            sortKey = sortKey[(slice(1, len(sortKey)))]
        sort = {}
        sort[sortKey] = sortVal
    ret['lendLibraryItems'] = mongo_db.find('lendLibraryItem', query, limit = limit, skip = skip, sort_obj = sort)['items']
    if withOwnerInfo:
        ret['lendLibraryItems'] = AddOwnersInfo(ret['lendLibraryItems'], lngLatOrigin)
    return ret

def AddOwnersInfo(lendLibraryItems, lngLatOrigin = None):
    userObjectIds = []
    for item in lendLibraryItems:
        userObjectId = mongo_db.to_object_id(item['userIdOwner'])
        if userObjectId not in userObjectIds:
            userObjectIds.append(userObjectId)
    query = {
        '_id': { '$in': userObjectIds },
    }
    fields = { 'email': 1, 'first_name': 1, 'last_name': 1, 'email': 1, 'lngLat': 1, }
    users = mongo_db.find('user', query, fields = fields)['items']
    for index, lendLibraryItem in enumerate(lendLibraryItems):
        for user in users:
            if user['_id'] == lendLibraryItem['userIdOwner']:
                lendLibraryItems[index]['xOwner'] = user
                if lngLatOrigin is not None and 'lngLat' in user and user['lngLat'] is not None:
                    lendLibraryItems[index]['xDistanceKm'] = _math_polygon.Haversine(user['lngLat'], lngLatOrigin, units = 'kilometers')
                break
    return lendLibraryItems

def Save(lendLibraryItem, userIdOwner = ''):
    ret = { 'valid': 1, 'msg': '', 'lendLibraryItem': {} }

    if '_id' not in lendLibraryItem or not lendLibraryItem['_id']:
        newData = lendLibraryItem
        lendLibraryItem['userIdOwner'] = userIdOwner
        result = mongo_db.insert_one('lendLibraryItem', newData)
        lendLibraryItem['_id'] = mongo_db.from_object_id(result['item']['_id'])
    else:
        query = {
            '_id': mongo_db.to_object_id(lendLibraryItem['_id'])
        }
        mutation = {
            '$set': {
                'title': lendLibraryItem['title'],
                'description': lendLibraryItem['description'],
                'tags': lendLibraryItem['tags'],
                'imageUrl': lendLibraryItem['imageUrl'],
            }
        }
        result = mongo_db.update_one('lendLibraryItem', query, mutation)
    ret['lendLibraryItem'] = lendLibraryItem
    return ret

def Remove(id):
    ret = { 'valid': 1, 'msg': '' }
    query = {
        '_id': mongo_db.to_object_id(id),
    }
    result = mongo_db.delete_one('lendLibraryItem', query)
    return ret
