# -*- coding: utf-8 -*-
from flask import Flask, jsonify, json, request, render_template
from flask_caching import Cache
import socket
import http.client

app = Flask(__name__,
        static_url_path='', 
        static_folder='web/static',
        template_folder='web/templates')
    
app.config.from_pyfile('config.py')


def to_pretty_json(value):
        return json.dumps(value, sort_keys=True, indent=4, separators=(',', ': '))
    
def page_forbidden(e):
    return render_template(
        "home.html",
        nav=app.config['NAV'],
        title="Error 403",
        description="Forbidden",
    ), 403
    
def page_not_found(e):
    return render_template(
        "home.html",
        nav=app.config['NAV'],
        title="Error 404",
        description="What you were looking for is just not there.",
    ), 404
    
def internal_server_error(e):
    return render_template(
        "home.html",
        nav=app.config['NAV'],
        title="Error 500",
        description="Internal Server Error",
    ), 500

    
app.jinja_env.filters['tojson_pretty'] = to_pretty_json
app.register_error_handler(403, page_forbidden)
app.register_error_handler(404, page_not_found)
app.register_error_handler(500, internal_server_error)

cache = Cache(app)

@app.route("/")
@cache.cached(timeout=600)
def home():
    """Landing page route."""
    return render_template(
        "home.html",
        nav=app.config['NAV'],
        title="NewsAPPMVVM",
        description="Sample project to learn how to use swiftui 2.0 with Combine, we look into using SwiftUI MVVM, also interact with an API to get our newsfeed, use SPM(Swift Package Manager) to speed up our development flow and handle swiftui layout with views such as VStack.",
    )
    
#to be compatible with version 1.0
@app.route("/summary/")
def summary():
    return dummy_1_0_json()
    
@app.route('/digest/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def digest(version, phrase, lang, page):
    if version == "1.0":
        return dummy_1_0_json()
    elif version == "1.1":
        print("allowed version")
    else:
        return empty_json()
    
    addr = app.config['CONNECTION_ADDR']
    host = app.config['HEADER_HOST']
    key = app.config['HEADER_KEY']
    
    headers = {
        'x-rapidapi-host': host,
        'x-rapidapi-key': key
        }
    
    lng = lang.lower()
    rlng = "en"
    search_phrase = "SpaceX"
    if lng in app.config['ALLOWED_LANG']:
        rlng = lng
        
    cache_key = "articles"+"_"+search_phrase+"_"+rlng
    cached_articles = cache.get(cache_key)
    if cached_articles is not None:
        return render_template(
                "news/1_1.json",
                articles = cached_articles,
            )
    
    try:
        conn = http.client.HTTPSConnection(addr)
        conn.request("GET", "/v1/search?q="+search_phrase+"&lang="+rlng, headers=headers)
    except Exception as e:
        print(e)
        conn.close()
        return empty_json()
    
    res = conn.getresponse()
    data = res.read()
    
    data_decoded = data.decode()
    json_object = json.loads(data_decoded)
    
    try:
        status = json_object["status"]
    except KeyError:
        conn.close()
        return empty_json()
        
    try:
        articles = json_object["articles"]
    except KeyError:
        conn.close()
        return empty_json()
        
    conn.close()
    
    if res.status == 200 and status == "ok" :
        if articles is not None:
            cache.set(cache_key, articles)
    else:
        return empty_json()
        
    return render_template(
            "news/1_1.json",
            articles = articles,
        )
        
@app.route('/dummy/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def dummy(version, phrase, lang, page):
    if version == "1.0":
        return dummy_1_0_json()
    elif version == "1.1":
        return dummy_1_1_json()
    
    return empty_json()

@cache.cached(timeout=1200, key_prefix='empty_json')
def empty_json():
    return render_template(
        "news/default.json",
        ip_address=request.host_url,
    )
    
@cache.cached(timeout=1200, key_prefix='dummy_1_0_json')
def dummy_1_0_json():
    return render_template(
        "news/1_0.json",
        ip_address=request.host_url,
    )
    
@cache.cached(timeout=1200, key_prefix='dummy_1_1_json')
def dummy_1_1_json():
    return render_template(
        "news/1_1_dummy.json",
        ip_address=request.host_url,
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=app.config['APP_PORT'], debug=app.config['DEBUG'])