# -*- coding: utf-8 -*-
from flask import Flask, jsonify, json, request, render_template
from flask_caching import Cache
from utils.newshub import Newshub
from apscheduler.schedulers.background import BackgroundScheduler


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
with app.app_context():
    cache.clear()
    
newshub = Newshub(app.config)

def news_harvester(hub, cache, lang):
    hub.parsefeed(cache, lang)
    
sched = BackgroundScheduler(daemon=True)
harvester_tick = app.config['CACHE_DEFAULT_TIMEOUT']
sched.add_job(news_harvester,'interval', seconds=harvester_tick, args=[newshub, cache, "en"])
sched.start()

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
    
@app.route('/digest/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def digest(version, phrase, lang, page):
    if version == "1.1":
        print("allowed version")
    else:
        return empty_json()
    
    lng = lang.lower()
    rlng = "en"
    if lng in app.config['ALLOWED_LANG']:
        rlng = lng
        
    cache_key = "articles"+"_"+rlng
    cached_articles = cache.get(cache_key)
    if cached_articles is not None:
        dict = {
            "articles":cached_articles
        }
        return json.dumps(dict, indent = 4),200,{'content-type':'application/json'}
            
    articles = newshub.parsefeed(cache, rlng)
    if articles is not None:
        dict = {
            "articles":articles
        }
        return json.dumps(dict, indent = 4),200,{'content-type':'application/json'}
            
    return empty_json(),200,{'content-type':'application/json'}
        
@app.route('/dummy/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def dummy(version, phrase, lang, page):
    if version == "1.1":
        return dummy_1_1_json(),200,{'content-type':'application/json'}
    
    return empty_json(),200,{'content-type':'application/json'}

@cache.cached(timeout=1200, key_prefix='empty_json')
def empty_json():
    dict = {
        "articles":[]
    }
    
    return json.dumps(dict, indent = 4)
    
@cache.cached(timeout=1200, key_prefix='dummy_1_1_json')
def dummy_1_1_json():
    return render_template(
        "news/1_1_dummy.json",
        ip_address=request.host_url,
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=app.config['APP_PORT'], debug=app.config['DEBUG'])