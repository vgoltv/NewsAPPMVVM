# -*- coding: utf-8 -*-
from flask import Flask, jsonify, json, request, render_template
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

@app.route("/")
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
    null = ""
    ip_address = request.host_url
    
    template_file = "news/1_0.json"
        
    return render_template(
        template_file,
        ip_address=ip_address,
    )
    
@app.route('/digest/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def digest(version, phrase, lang, page):
    ip_address = request.host_url
    
    if version == "1.0":
        return render_template(
            "news/1_0.json",
            ip_address=ip_address,
        )
    elif version == "1.1":
        print("allowed version")
    else:
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
        
    addr = app.config['CONNECTION_ADDR']
    host = app.config['HEADER_HOST']
    key = app.config['HEADER_KEY']
    
    headers = {
        'x-rapidapi-host': host,
        'x-rapidapi-key': key
        }
    
    lng = lang.lower()
    rlng = "en"
    if lng in app.config['ALLOWED_LANG']:
        rlng = lng
    
    try:
        conn = http.client.HTTPSConnection(addr)
        conn.request("GET", "/v1/search?q=SpaceX&lang="+rlng, headers=headers)
    except Exception as e:
        print(e)
        conn.close()
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
    
    res = conn.getresponse()
    data = res.read()
    
    data_decoded = data.decode()
    json_object = json.loads(data_decoded)
    
    try:
        status = json_object["status"]
    except KeyError:
        conn.close()
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
        
    try:
        articles = json_object["articles"]
    except KeyError:
        conn.close()
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
        
    conn.close()
    
    result_success = "false"
    if res.status == 200 and status == "ok" :
        print("success request")
    else:
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
        
    return render_template(
            "news/1_1.json",
            articles = articles,
        )
        
@app.route('/dummy/<string:version>/<string:phrase>/<string:lang>/<int:page>/', methods=['GET', 'POST'])
def dummy(version, phrase, lang, page):
    ip_address = request.host_url
    
    if version == "1.0":
        return render_template(
            "news/1_0.json",
            ip_address=ip_address,
        )
    elif version == "1.1":
        print("allowed version")
    else:
        return render_template(
            "news/default.json",
            ip_address=ip_address,
        )
    
    return render_template(
        "news/1_1_dummy.json",
        ip_address=ip_address,
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=app.config['APP_PORT'], debug=app.config['DEBUG'])