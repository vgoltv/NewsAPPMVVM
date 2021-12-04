# -*- coding: utf-8 -*-
"""Flask configuration."""

APP_PORT = 5001
TESTING = True
DEBUG = True
#default - production
FLASK_ENV = 'development'
ALLOWED_LANG = ["af", "ar", "bg", "bn", "ca", "cs", "cy", "da", "de", "el", "en", "es", "et", "fa", "fi", "fr", "gu", "he", "hi", "hr", "hu", "id", "it", "ja", "kn", "ko", "lt", "lv", "mk", "ml", "mr", "ne", "nl", "no", "pa", "pl", "pt", "ro", "ru", "sk", "sl", "so", "sq", "sv", "sw", "ta", "te", "th", "tl", "tr", "uk", "ur", "vi", "zh-cn", "zh-tw"]
CONNECTION_ADDR = 'free-news.p.rapidapi.com'
HEADER_HOST = 'free-news.p.rapidapi.com'
HEADER_KEY = '6187781af1msh50364ed21d3df52p1033a6jsnde010d884223'
NAV = [
	{"name": "Github project", "url": "https://github.com/vgoltv/NewsAPPMVVM"},
]
