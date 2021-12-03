# -*- coding: utf-8 -*-
from flask import Flask
from flask import jsonify
from flask import request
from flask import render_template
import socket

app = Flask(__name__,
        static_url_path='', 
        static_folder='web/static',
        template_folder='web/templates')
    
app.config.from_pyfile('config.py')

@app.route("/")
def home():
    """Landing page route."""
    nav = [
        {"name": "Github project", "url": "https://github.com/vgoltv/NewsAPPMVVM"},
    ]
    return render_template(
        "home.html",
        nav=nav,
        title="NewsAPPMVVM",
        description="Sample project to learn how to use swiftui 2.0 with Combine, we look into using SwiftUI MVVM, also interact with an API to get our newsfeed, use SPM(Swift Package Manager) to speed up our development flow and handle swiftui layout with views such as VStack.",
    )
    
#to be compatible with version 1.0
@app.route("/summary/")
def summary():
    null = ""
    ip_address = request.host_url
    
    template_file = "news/1_0.json"
        
    return render_template(
        template_file,
        ip_address=ip_address,
    )

@app.route('/digest/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def digest(version, phrase, lang, page):
    null = ""
    ip_address = request.host_url
    
    template_file = "news/default.json"
    
    if version == "1.0":
        template_file = "news/1_0.json"
    else:
        template_file = "news/default.json"
    
    return render_template(
        template_file,
        ip_address=ip_address,
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=app.config['APP_PORT'])