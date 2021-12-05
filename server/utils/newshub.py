# -*- coding: utf-8 -*-
import json
from flask_caching import Cache
import http.client

class Newshub:
	def __init__(self, config):
		self.addr = config['CONNECTION_ADDR']
		host = config['HEADER_HOST']
		key = config['HEADER_KEY']
		self.headers = {
			'x-rapidapi-host': host,
			'x-rapidapi-key': key
			}
			
	@staticmethod
	def method(arg):
		print(arg)
			
	def harvest(self, cache, phrase, lang):
		cache_key = "articles"+"_"+phrase+"_"+lang
		cached_articles = cache.get(cache_key)
		if cached_articles is not None:
			return None
		try:
			conn = http.client.HTTPSConnection(self.addr)
			conn.request("GET", "/v1/search?q="+phrase+"&lang="+lang, headers=self.headers)
		except Exception as e:
			print(e)
			conn.close()
			return None
		res = conn.getresponse()
		data = res.read()
		
		data_decoded = data.decode()
		json_object = json.loads(data_decoded)
		
		try:
			status = json_object["status"]
		except KeyError:
			conn.close()
			return None
		
		try:
			articles = json_object["articles"]
		except KeyError:
			conn.close()
			return None
		
		conn.close()
		
		if res.status == 200 and status == "ok" :
			if articles is not None:
				cache.set(cache_key, articles)
				print("articles saved!")
				return articles

		return None
		
	def to_json(self):
		'''
		convert the instance of this class to json
		'''
		return json.dumps(self, indent = 4, default=lambda o: o.__dict__)