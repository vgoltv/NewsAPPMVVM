# -*- coding: utf-8 -*-
import json
from flask_caching import Cache
import feedparser
import html.parser
import re

class HTMLTextExtractor(html.parser.HTMLParser):
	def __init__(self):
		super(HTMLTextExtractor, self).__init__()
		self.result = [ ]
		
	def handle_data(self, d):
		self.result.append(d)
		
	def get_text(self):
		return ''.join(self.result)

class Newshub:
	def __init__(self, config):
		self.addr = config['CONNECTION_ADDR']
		self.connection_name = config['CONNECTION_NAME']
			
	@staticmethod
	def method(arg):
		print(arg)
	
	def parsefeed(self, cache, lang):
		cache_key = "articles"+"_"+lang
		cached_articles = cache.get(cache_key)
		if cached_articles is not None:
			return cached_articles
		full_data = feedparser.parse(self.addr)
		articles = []
		
		pattern = re.compile('([^\s\w]|_)+')
		
		for entry in full_data["entries"]:
			try:
				
				media_ref = ""
				
				# RSS Featured Image plugin for WP
				# Author: Jordy Meow
				for media in entry.media_content:
					if media['medium'] == 'image':
						media_ref = media['url']
						break
					
				summary = entry.summary
				
				for item in entry.content:
					if item.type == 'text/html' and item.value is not None:
						s = HTMLTextExtractor()
						s.feed(item.value)
						summary = s.get_text().strip()
						summary = summary.replace(u"\u00A0", " ")
						break
					
				
				article = {
					"title":entry.title,
					"author":entry.author,
					"published_date":entry.published,
					"published_date_precision":"full",
					"link":entry.link,
					"clean_url":self.connection_name,
					"summary":summary,
					"rights":"",
					"rank":10,
					"topic":"news",
					"country":"DE",
					"language":"en",
					"authors":[entry.author],
					"media":str(media_ref),
					"is_opinion":False,
					"twitter_account":"",
					"_score":10,
					"_id":entry.id
				}
				
				articles.append(article)
			except Exception:
				print("ERROR: Failed to parse Entry")
				
		json_object = json.dumps(articles, indent = 4) 
		cache.set(cache_key, articles)
		return articles
	
	def html_to_text(self, html):
		s = HTMLTextExtractor()
		s.feed(html)
		return s.get_text()
		
	def to_json(self):
		'''
		convert the instance of this class to json
		'''
		return json.dumps(self, indent = 4, default=lambda o: o.__dict__)