# -*- coding: utf-8 -*-
"""Flask configuration."""

APP_PORT = 5001
TESTING = True
DEBUG = True
#default - production
FLASK_ENV = 'development'
CACHE_TYPE = 'FileSystemCache'
CACHE_DIR = 'cache'
CACHE_DEFAULT_TIMEOUT = 600
ALLOWED_LANG = ["de", "en", "fr", "it"]
CONNECTION_ADDR = 'free-news.p.rapidapi.com'
HEADER_HOST = 'free-news.p.rapidapi.com'
HEADER_KEY = 'getyourownplease'
NAV = [
	{"name": "Github project", "url": "https://github.com/vgoltv/NewsAPPMVVM"},
]
